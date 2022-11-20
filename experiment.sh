#!/bin/bash

rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm

./psnr 1  0.2 0.6 200 200   >> realtime_experiment.log
./psnr 1  0.2 0.6 640 480   >> realtime_experiment.log
./psnr 1  0.2 0.6 1500 1350 >> realtime_experiment.log
./psnr 1  0.2 0.6 200 200 -f ground_crew.h264   >> ground_crew_experiment.log
./psnr 1  0.2 0.6 640 480 -f ground_crew.h264   >> ground_crew_experiment.log
./psnr 1  0.2 0.6 1500 1350 -f ground_crew.h264 >> ground_crew_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 1  0.2 0.6 200 200 -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 1  0.2 0.6 640 480 -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 1  0.2 0.6 1500 1350 -f tiger_face.jpg >> tiger_face_experiment.log

./psnr 1   0.2 0.4 200 200   >> realtime_experiment.log
./psnr 1   0.2 0.4 640 480   >> realtime_experiment.log
./psnr 1   0.2 0.4 1500 1350 >> realtime_experiment.log
./psnr 1  0.2 0.4 200 200    -f ground_crew.h264   >> ground_crew_experiment.log
./psnr 1  0.2 0.4 640 480    -f ground_crew.h264   >> ground_crew_experiment.log
./psnr 1  0.2 0.4 1500 1350  -f ground_crew.h264   >> ground_crew_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 1   0.2 0.4 200 200   -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 1   0.2 0.4 640 480   -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 1   0.2 0.4 1500 1350 -f tiger_face.jpg   >> tiger_face_experiment.log

./psnr 1   0.9 0.6 200 200   >> realtime_experiment.log
./psnr 1   0.9 0.6 640 480   >> realtime_experiment.log
./psnr 1   0.9 0.6 1500 1350 >> realtime_experiment.log
./psnr 1   0.9 0.6 200 200  -f ground_crew.h264 >> realtime_experiment.log
./psnr 1   0.9 0.6 640 480 -f ground_crew.h264 >> realtime_experiment.log
./psnr 1   0.9 0.6 1500 1350 -f ground_crew.h264 >> realtime_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 1   0.9 0.6 200 200 -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 1   0.9 0.6 640 480 -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 1   0.9 0.6 1500 1350 -f tiger_face.jpg   >> tiger_face_experiment.log

./psnr 1   0.9 0.4 200 200 >> realtime_experiment.log
./psnr 1   0.9 0.4 640 480 >> realtime_experiment.log
./psnr 1   0.9 0.4 1500 1350 >> realtime_experiment.log
./psnr 1   0.9 0.4 200 200 -f ground_crew.h264 >> realtime_experiment.log
./psnr 1   0.9 0.4 640 480 -f ground_crew.h264 >> realtime_experiment.log
./psnr 1   0.9 0.4 1500 1350 -f ground_crew.h264 >> realtime_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 1   0.9 0.4 200 200  -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 1   0.9 0.4 640 480  -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 1   0.9 0.4 1500 1350  -f tiger_face.jpg   >> tiger_face_experiment.log

./psnr 0.5 0.2 0.6 200 200 >> realtime_experiment.log
./psnr 0.5 0.2 0.6 640 480 >> realtime_experiment.log
./psnr 0.5 0.2 0.6 1500 1350 >> realtime_experiment.log
./psnr 0.5 0.2 0.6 200 200  -f ground_crew.h264 >> realtime_experiment.log
./psnr 0.5 0.2 0.6 640 480  -f ground_crew.h264 >> realtime_experiment.log
./psnr 0.5 0.2 0.6 1500 1350  -f ground_crew.h264 >> realtime_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 0.5 0.2 0.6 200 200 -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 0.5 0.2 0.6 640 480 -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 0.5 0.2 0.6 1500 1350 -f tiger_face.jpg   >> tiger_face_experiment.log

./psnr 0.5 0.2 0.4 200 200 >> realtime_experiment.log
./psnr 0.5 0.2 0.4 640 480 >> realtime_experiment.log
./psnr 0.5 0.2 0.4 1500 1350 >> realtime_experiment.log
./psnr 0.5 0.2 0.4 200 200  -f ground_crew.h264 >> realtime_experiment.log
./psnr 0.5 0.2 0.4 640 480  -f ground_crew.h264 >> realtime_experiment.log
./psnr 0.5 0.2 0.4 1500 1350  -f ground_crew.h264 >> realtime_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 0.5 0.2 0.4 200 200 -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 0.5 0.2 0.4 640 480 -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 0.5 0.2 0.4 1500 1350 -f tiger_face.jpg   >> tiger_face_experiment.log

./psnr 0.5 0.9 0.6 200 200 >> realtime_experiment.log
./psnr 0.5 0.9 0.6 640 480 >> realtime_experiment.log
./psnr 0.5 0.9 0.6 1500 1350 >> realtime_experiment.log
./psnr 0.5 0.9 0.6 200 200 -f ground_crew.h264 >> realtime_experiment.log
./psnr 0.5 0.9 0.6 640 480 -f ground_crew.h264 >> realtime_experiment.log
./psnr 0.5 0.9 0.6 1500 1350 -f ground_crew.h264 >> realtime_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 0.5 0.9 0.6 200 200 -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 0.5 0.9 0.6 640 480 -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 0.5 0.9 0.6 1500 1350 -f tiger_face.jpg   >> tiger_face_experiment.log

./psnr 0.5 0.9 0.4 200 200 >> realtime_experiment.log
./psnr 0.5 0.9 0.4 640 480 >> realtime_experiment.log
./psnr 0.5 0.9 0.4 1500 1350 >> realtime_experiment.log
./psnr 0.5 0.9 0.4 200 200  -f ground_crew.h264 >> realtime_experiment.log
./psnr 0.5 0.9 0.4 640 480  -f ground_crew.h264 >> realtime_experiment.log
./psnr 0.5 0.9 0.4 1500 1350  -f ground_crew.h264 >> realtime_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 0.5 0.9 0.4 200 200 -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 0.5 0.9 0.4 640 480 -f tiger_face.jpg   >> tiger_face_experiment.log
rm SMALL/*.pgm
rm MEDIUM/*.pgm
rm LARGE/*.pgm
./psnr 0.5 0.9 0.4 1500 1350 -f tiger_face.jpg   >> tiger_face_experiment.log
