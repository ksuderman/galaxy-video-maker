#!/usr/bin/env bash

if [[ -z $1 || -z $2 ]] ; then
  echo "USAGE make-video.sh topic tutorial-name"
  exit 1
fi

topic=$1
tutor=$2

make _site/training-material/topics/$topic/tutorials/$tutor/slides.pdf ACTIVATE_ENV=pwd
bin/ari-quick.sh topics/$topic/tutorials/$tutor/slides.html
