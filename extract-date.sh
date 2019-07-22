#!/bin/bash
exiftool_options=""
test_y="0"
usage="$(basename "$0") [-h] [-t] [-o] FILE..."
while getopts "hot" OPTION
do
  case $OPTION in
    h)
      echo "usage: $usage"
      echo "positional arguments:
  FILE...       one or more files to extract date from

optional arguments:
  -h            show this help message and exit
  -t            run a test.  files will not be moved/copied
  -o            overwrite existing files with exiftool's -overwrite_original_in_place"
      exit 0
      ;;
    o)
      echo "Overwriting original files"
      exiftool_options+="-overwrite_original_in_place"
      ;;
    t)
      echo "Testing, no changes will be made"
      test_y="1"
      ;;
  esac
done
shift $(($OPTIND - 1))
#  Decrements the argument pointer so it points to next argument.
#  $1 now references the first non-option item supplied on the command-line
#+ if one exists.
if [[ "$@" == "" ]]; then
  echo "No file given."
  echo "usage: $usage"
  exit 1
fi
for f in "$@"; do
  time=$(echo $f | grep -Eo '([0-9]{4})-?([0-9]{2})-?([0-9]{2})_?-?([0-9]{2})([0-9]{2})([0-9]{2})' | sed -E 's,([0-9]{4})-?([0-9]{2})-?([0-9]{2})_?-?([0-9]{2})([0-9]{2})([0-9]{2}),\1:\2:\3 \4:\5:\6,g')
  if [[ $time == "" ]]; then
    echo "No date in filename $f"
  elif [[ $test_y == 1 ]]; then
    echo 'Testing: DateTimeOriginal' $time 'to file' $f
  else
    echo 'writing DateTimeOriginal:' $time 'to file:' $f
    exiftool $exiftool_options "-datetimeoriginal=$time'" $f
  fi
done
