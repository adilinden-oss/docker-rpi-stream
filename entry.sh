#!/bin/bash

case $1 in
    octopi-youtubelive)
        # Streaming from OctoPi webcam to YouTube Live
        echo "Streaming OctoPi webcam to YouTube Live..."
        echo "OctoPi Webcam Stream:         $2"
        echo "YouTube Live Server URL:      $3"
        echo "YouTube Live Stream Name/Key: $4"
        echo "OctoPi Filter:                $5"

        # Define streaming parameters
        FPS=5
        VIDEO_IN="-re -f mjpeg -framerate 5 -i $2"
        AUDIO_IN="-ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero"
        VIDEO_OUT="-vcodec h264 -pix_fmt yuv420p -framerate $FPS -g $(($FPS * 2)) -strict experimental -filter:v $5"
        AUDIO_OUT="-acodec aac -ab 128k"
        STREAM_URL="-f flv $3/$4"

        # Start Stream
        ffmpeg $VIDEO_IN $AUDIO_IN $VIDEO_OUT $AUDIO_OUT $STREAM_URL

        echo "Done streaming..."
        ;;
    shell)
        # Executing shell
        echo "Providing shell..."
        /bin/bash
        ;;
    *)
        # Fallthough dropping into shell
        echo "Command unknown, providing shell..."
        /bin/bash
esac
