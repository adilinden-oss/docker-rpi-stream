#!/bin/bash

# Allow CTR-C to exit while loop
exit_func() {
        echo "SIGTERM detected"            
        exit 1
}
trap exit_func SIGTERM SIGINT

# Wrapper for ffmpeg
function run_ffmpeg {
    local cam_url="$1"
    local cam_fps="$2"
    local flv_url="$3"
    local flv_key="$4"
    local filter="$5"

    # Define streaming parameters
    VIDEO_IN="-re -f mjpeg -framerate 5 -i $cam_url"
    AUDIO_IN="-ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero"
    VIDEO_OUT="-vcodec h264 -pix_fmt yuv420p -framerate $cam_fps -g $(($cam_fps * 2)) -strict experimental -filter:v $filter"
    AUDIO_OUT="-acodec aac -ab 128k"
    STREAM_URL="-f flv $flv_url/$flv_key"

    echo "ffmpeg $VIDEO_IN $AUDIO_IN $VIDEO_OUT $AUDIO_OUT $STREAM_URL"

    ffmpeg $VIDEO_IN $AUDIO_IN $VIDEO_OUT $AUDIO_OUT $STREAM_URL
}

# See how we were called
case $1 in
    octopi-youtubelive)
        # Streaming from OctoPi webcam to YouTube Live
        # Provided for adilinden-oss/octoprint-youtubelive plugin
        echo "Streaming OctoPi webcam to YouTube Live..."
        echo "OctoPi Webcam Stream:         $2"
        echo "YouTube Live Server URL:      $3"
        echo "YouTube Live Stream Name/Key: $4"
        echo "OctoPi Filter:                $5"

        run_ffmpeg "$2" "5" "$3" "$4" "$5"

        echo "Done streaming..."
        ;;

    octopi-youtube)
        # Simplified OctoPi to Twitch.TV
        echo "Streaming to Twitch.TV..."
        echo "OctoPi Webcam Stream:         $2"
        echo "YouTube Live Stream Name/Key: $3"

        run_ffmpeg "$2" "5" "rtmp://a.rtmp.youtube.com/live2" "$3" "null"
        ;;

    octopi-twitch)
        # Simplified OctoPi to YouTube Live
        echo "Streaming to YouTube Live..."
        echo "OctoPi Webcam Stream:         $2"
        echo "Twitch.Tv Stream Key:         $3"

        run_ffmpeg "$2" "5" "rtmp://live.twitch.tv/app" "$3" "null"
        ;;

    ffmpeg-loop)
        # Keep running ffmpeg until explicitely stopped
        shift
        while "true"; do
            echo "Executing \"ffmpeg $(echo $@ | cut -c -55)...\""
            ffmpeg $@

            # Pause for a bit before retrying
            echo -n "Pausing... "
            for ((wait=20; wait>=1; wait--))
            do
                echo -n "$wait "
                sleep 1
            done
            echo
        done
        ;;

    *)
        # Execute command provided on command line
        echo "Executing \"$(echo $@ | cut -c -55)...\""
        $@
esac
