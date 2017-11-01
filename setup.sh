#!/bin/bash

cd /kaldi/egs/american-archive-kaldi/sample_experiment
rm path.sh
wget https://raw.githubusercontent.com/hipstas/kaldi-pop-up-archive/master/scripts/path.sh
rm set-kaldi-path.sh
wget https://raw.githubusercontent.com/hipstas/kaldi-pop-up-archive/master/scripts/set-kaldi-path.sh
cd /kaldi/egs/wsj/s5/utils/
rm run.pl
wget https://raw.githubusercontent.com/hipstas/kaldi-pop-up-archive/master/scripts/run.pl

mkdir /audio_in
cd /audio_in

## Now add media files to /audio_in/

for file in *.{wav,mp3,mp4,WAV,MP3,MP4}; do
base=$(basename """$file""" .mp3);
ffmpeg -i """$file""" -ac 1 -ar 16000 """$base"""_16kHz.wav;
done

mkdir /audio_in_16khz/
mv *_16kHz.wav /audio_in_16khz/


######### Starting the batch run ##########

nohup python /kaldi/egs/american-archive-kaldi/run_kaldi.py /kaldi/egs/american-archive-kaldi/sample_experiment/ /audio_in_16khz/ && \
rsync -a /kaldi/egs/american-archive-kaldi/sample_experiment/output/ /audio_in/transcripts/