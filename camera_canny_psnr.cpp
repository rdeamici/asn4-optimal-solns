/**
*/
#include <iostream>
#include <unistd.h>
#include "opencv2/opencv.hpp"
#include "canny_util.h"
#include "calcpsnr.h"
#include <sys/time.h>
#include <string.h>
using namespace std;
using namespace cv;

/* Pi Camera MAX resolution: 2592x1944 (default: 640x480) */
/* ground_crew.h264: 1280x720 */
/* tiger_face.jpg: 888x900 */

float NFRAME = 30.0;

void ERRMSG(char* filename) {
   fprintf(stderr,"\n<USAGE> %s sigma tlow thigh height width [-d writedirim] [-f tiger_face.jpg | ground_crew.h264] \n",filename);
   fprintf(stderr,"      sigma:      Standard deviation of the gaussian");
   fprintf(stderr," blur kernel.\n");
   fprintf(stderr,"      tlow:       Fraction (0.0-1.0) of the high ");
   fprintf(stderr,"edge strength threshold.\n");
   fprintf(stderr,"      thigh:      Fraction (0.0-1.0) of the distribution");
   fprintf(stderr," of non-zero edge\n                  strengths for ");
   fprintf(stderr,"hysteresis. The fraction is used to compute\n");
   fprintf(stderr,"      height:     number of rows in the output image\n");
   fprintf(stderr,"      width:      number of columns in the output image\n");
   fprintf(stderr,"                  the high edge strength threshold.\n");
   fprintf(stderr,"      writedirim: Optional argument to output ");
   fprintf(stderr,                  "a floating point direction image.\n\n");
   fprintf(stderr,"      file: Optional argument to take in a file. If no file ");
   fprintf(stderr,"is provided, the camera will be accessed on the rpi by default.\n\n");
   exit(1);
}

int main(int argc, char **argv)
{
   char* dirfilename; /* Name of the output gradient direction image */
   char outfilename[128];    /* Name of the output "edge" image */
   char composedfname[128];  /* Name of the output "direction" image */
   unsigned char* image;     /* The input images */
   unsigned char *edge;      /* The output edge image */
   int rows, cols, HEIGHT, WIDTH;           /* The dimensions of the image. */
   float sigma,              /* Standard deviation of the Gaussian kernel. */
	 tlow,               /* Fraction of the high threshold in hysteresis. */
	 thigh;              /* High hysteresis threshold control. The actual
			        threshold is the (100 * thigh) percentage point
			        in the histogram of the magnitude of the
			        gradient image that passes non-maximal
			        suppression. */
   int count;            /* Frame count iterator */
   char *infile = NULL;
   int opt;
   /****************************************************************************
   * Get the command line arguments.
   ****************************************************************************/
   if(argc < 6){
      ERRMSG(argv[0]);
   }

   dirfilename = NULL;
   sigma = atof(argv[1]);
   tlow = atof(argv[2]);
   thigh = atof(argv[3]);
   cols = WIDTH = atoi(argv[4]);
   rows = HEIGHT = atoi(argv[5]);
   while((opt = getopt(argc, argv, "df:")) != -1){
      switch(opt){
         case 'd':
            dirfilename = (char *) "dummy";
            break;
         case 'f':
            infile = optarg;
            if (strcmp(infile,"tiger_face.jpg") == 0) {
               NFRAME = 1;
            }
            else if (strcmp(infile,"ground_crew.h264") != 0) {
               printf("[ERROR] UNKNOW input file: %s\n",infile);
               ERRMSG(argv[0]);
            }
            break;
         case '?':
            ERRMSG(argv[0]);
            break;
      }
   }
   // open the default camera (/dev/video0) OR a video OR an image
   // Check VideoCapture documentation for more details
   VideoCapture cap;
   Mat frame, grayframe;

   if(infile == NULL) {
      VideoCapture incap;
      if(!incap.open(0)) {
        printf("Failed to open media\n");
        return 0;
      }
      // create video to process
      for(count = 0; count < NFRAME; count++) {
         //capture
         incap >> frame;
         resize(frame, frame, Size(WIDTH, HEIGHT), 0, 0, INTER_LINEAR);

         //extract the image in gray format
         cvtColor(frame, grayframe, COLOR_BGR2GRAY);
         image = grayframe.data;
         // save image
         sprintf(outfilename, "REALTIME/IMG_%03d.pgm" , count);
         if(write_pgm_image(outfilename, image, rows, cols, NULL, 255) == 0){
            fprintf(stderr, "Error writing the raw image, %s.\n", outfilename);
            exit(1);
         }
         // reopen the videCapture cap
         if (!cap.open("REALTIME/IMG_%03d.pgm")) {
            printf("Failed to open REALTIME image sequences\n");
            return 0;
         }
      }
      //cap.set(CAP_PROP_FRAME_WIDTH, MWIDTH);
      //cap.set(CAP_PROP_FRAME_HEIGHT, MHEIGHT);
   } else {
      if(!cap.open(infile)) {
         printf("Failed to open media\n");
         return 0;
      }
   }

   // printf("Media Input: %.0f, %.0f\n",cap.get(CAP_PROP_FRAME_WIDTH), cap.get(CAP_PROP_FRAME_HEIGHT));

   // For low-end CPUs, may wait a while until camera stabilizes
   // printf("Sleep 3 seconds for camera stabilization...\n");
   // usleep(3*1e6);


   struct timeval start, end;
   count = 0;
   gettimeofday(&start,NULL);
   printf("\n=== Canny Edge Detection %d x %d: sigma %f, tlow %f, thigh %f, %.0f frames ===\n",WIDTH, HEIGHT, sigma, tlow, thigh, NFRAME);

   while(count<NFRAME) {
      //capture
      cap >> frame;
      if (frame.empty()) {
         printf("blank frame_%d!\n",count);
         exit(1);
      }
      //extract the image in gray format
      cvtColor(frame, grayframe, COLOR_BGR2GRAY);
      resize(grayframe, grayframe, Size(WIDTH, HEIGHT), 0, 0, INTER_LINEAR);
      image = grayframe.data;

      /****************************************************************************
      * Perform the edge detection. All of the work takes place here.
      ****************************************************************************/
      if(VERBOSE) printf("Starting Canny edge detection.\n");
      if(dirfilename != NULL){
         sprintf(composedfname, "camera_s_%3.2f_l_%3.2f_h_%3.2f_%d.fim",
         sigma, tlow, thigh,count);
         dirfilename = composedfname;
      }

      /****************************************************************************
      *Apply Canny Edge Detection Algorithm
      ****************************************************************************/
      canny(image, rows, cols, sigma, tlow, thigh, &edge, dirfilename);


      /****************************************************************************
      * Write out the edge image to a file.
      ****************************************************************************/
      if      (WIDTH == 200) sprintf(outfilename,  "SMALL/EDGE_%03d.pgm" , count);
      else if (WIDTH == 640) sprintf(outfilename, "MEDIUM/EDGE_%03d.pgm", count);
      else if (WIDTH == 1500) sprintf(outfilename,  "LARGE/EDGE_%03d.pgm", count);
      else {
         printf("ERROR: WIDTH = %d",WIDTH);
         exit(1);
      }
      if(VERBOSE) printf("Writing the edge image in the file %s.\n", outfilename);

      if(write_pgm_image(outfilename, edge, rows, cols, NULL, 255) == 0){
         fprintf(stderr, "Error writing the edge image, %s.\n", outfilename);
         exit(1);
      }

      /****************************************************************************
      * Write out the captured image to a file.
      ****************************************************************************/
      if      (WIDTH == 200) sprintf(outfilename, "SMALL/RAW_%03d.pgm" , count);
      else if (WIDTH == 640) sprintf(outfilename,"MEDIUM/RAW_%03d.pgm", count);
      else if (WIDTH == 1500) sprintf(outfilename, "LARGE/RAW_%03d.pgm", count);

      if(VERBOSE) printf("Writing the raw image in the file %s.\n", outfilename);

      if(write_pgm_image(outfilename, image, rows, cols, NULL, 255) == 0){
         fprintf(stderr, "Error writing the raw image, %s.\n", outfilename);
         exit(1);
      }
      count++;
   } //end of while loop

   /****************************************************************************
   * Get FPS information.
   ****************************************************************************/
   gettimeofday(&end,NULL);
   double time_elapsed =  ((end.tv_sec*1000000 + end.tv_usec) - (start.tv_sec*1000000 +start.tv_usec));
   // printf("=== Finish Canny Edge Detection_%d ===\n",i);
   printf("Total Elapsed Time : %lf sec.\n", time_elapsed/1000000);
   printf("FPS: %4f.\n", NFRAME/(time_elapsed/1000000));

   /****************************************************************************
   * Read the edge detected files and raw_images and calculate PSNR.
   ****************************************************************************/
   count = 0;
   char raw_image_name[128];
   char edge_image_name[128];
   double PSNR = 0.0;

   if(VERBOSE) printf("Calculating PSNR value...\n");
   while(count<NFRAME) {
      if (WIDTH == 200) {
         /* Get the edge image name */
         sprintf(edge_image_name, "SMALL/EDGE_%03d.pgm", count);
         /* Get the raw image name */
         sprintf(raw_image_name,  "SMALL/RAW_%03d.pgm", count);
      } else if (WIDTH == 640) {
         sprintf(edge_image_name, "MEDIUM/EDGE_%03d.pgm", count);
         sprintf(raw_image_name,  "MEDIUM/RAW_%03d.pgm", count);
      } else if (WIDTH == 1500) {
         sprintf(edge_image_name, "LARGE/EDGE_%03d.pgm", count);
         sprintf(raw_image_name, "LARGE/RAW_%03d.pgm", count);
      }
      PSNR = PSNR + calcpsnr(raw_image_name, edge_image_name);
      count++;
   }

   PSNR = PSNR / NFRAME;
   printf("Average PSNR value = %3.2f \n", PSNR);
   //free resources
   //delete image;
   return 0;
}
