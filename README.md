# extract-date
Bash script to extract the date from image files in the format YYYY-?mm-?DD-?\_?HHMMSS and insert it into the exif data using exiftool

Requires exiftool

usage: extract-date.sh [-h] [-t] [-o] FILE...
positional arguments:
  FILE...       one or more files to extract date from

optional arguments:
  -h            show this help message and exit
  -t            run a test.  files will not be moved/copied
  -o            overwrite existing files with exiftool's -overwrite_original_in_place
