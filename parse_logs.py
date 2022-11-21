import sys

log = sys.argv[1]
size = sys.argv[2]
with open(log) as real:
    found_one = 0
    for line in real:
        line = line.strip()
        if 0 < found_one < 5:
            print(line)
            found_one += 1
        elif found_one == 4:
            found_one = 0
        if size in line:
            print(line)
            found_one = 1