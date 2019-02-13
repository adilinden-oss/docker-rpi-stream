# About

## What is this for?

I built this to stream the webcam attached to my [OctoPi](https://octoprint.org/) to [YouTube Live](https://www.youtube.com/channel/UC4R8DWoMoI7CAwX8_LjQHig). There is nothing more excting then watching a live stream of a 3D printer laying down lines of plastic, right?

The [Dockerfile](https://github.com/adilinden-oss/docker-rpi-stream/blob/master/Dockerfile) is on GitHub [adilinden-oss/docker-rpi-stream](https://github.com/adilinden-oss/docker-rpi-stream).

## Prerequisities

A Raspberry Pi with docker installed.

    curl -sSL https://get.docker.com | sh
    sudo usermod pi -aG docker
    sudo reboot

## Building

Build it from Github

    git clone https://github.com/adilinden-oss/docker-rpi-stream.git
    cd docker-rpi-stream
    docker build -t adilinden/rpi-stream .

Or, get it from Docker Hub

    docker pull adilinden/rpi-stream

## Usage

Run with `octopi-youtubelive` command and a number of arguments to stream the [OctoPi](https://octoprint.org/) webcam to [YouTube Live](https://www.youtube.com/channel/UC4R8DWoMoI7CAwX8_LjQHig). The following arguments are expected:

- OctoPi Webcam Stream (Example: http://192.168.1.34:8080/?action=stream)
- YouTube Live Server URL (Example: rtmp://a.rtmp.youtube.com/live2)
- YouTube Live Stream Name/Key (Example: xxxx-xxxx-xxxx-xxxx)
- OctoPi Filter (Example: null)

Example

    docker run -it --rm --privileged adilinden/rpi-stream:latest octopi-youtubelive \
        http://192.168.1.34:8080/?action=stream \
        rtmp://a.rtmp.youtube.com/live2 \
        xxxx-xxxx-xxxx-xxxx \
        null

Run with `octopi-youtube` command for a simplified way to stream the [OctoPi](https://octoprint.org/) webcam to [YouTube Live](https://www.youtube.com/channel/UC4R8DWoMoI7CAwX8_LjQHig). The following arguments are expected:

- OctoPi Webcam Stream (Example: http://192.168.1.34:8080/?action=stream)
- YouTube Live Stream Name/Key (Example: xxxx-xxxx-xxxx-xxxx)

Example

    docker run -it --rm --privileged adilinden/rpi-stream:latest octopi-youtube \
        http://192.168.1.34:8080/?action=stream \
        xxxx-xxxx-xxxx-xxxx

Run with `octopi-twitch` command for a simplified way to stream the [OctoPi](https://octoprint.org/) webcam to [Twitch.Tv](https://www.twitch.tv/). The following arguments are expected:

- OctoPi Webcam Stream (Example: http://192.168.1.34:8080/?action=stream)
- Twitch Stream Key (Example: live_123456789_mysupersecrettwitchkey)

Example

    docker run -it --rm --privileged adilinden/rpi-stream:latest octopi-twitch \
        http://192.168.1.34:8080/?action=stream \
        live_123456789_mysupersecrettwitchkey

Run with `ffmpeg-loop` and appropriate `ffmpeg` command line parameters to stream the [OctoPi](https://octoprint.org/) webcam to some streaming service of your choice. This places `ffmpeg` inside a while loop and continues to try restarting `ffmpeg` if it fails for any reason, such as connectivity issues. Use with caution! The use of CTRL-C breaks out of the `while` loop if executed interactively.

Example

    docker run -it --rm --privileged adilinden/rpi-stream:latest ffmpeg-loop \
        -re -f mjpeg -framerate 5 -i http://192.168.1.34:8080/?action=stream \
        -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero \
        -vcodec h264 -pix_fmt yuv420p -framerate 5 -g 10 -strict experimental -filter:v null \
        -acodec aac -ab 128k -f flv rtmp://live.twitch.tv/app/live_123456789_mysupersecrettwitchkey

Run any supported command within the container. This allows for executing `ffmpeg` with appropriate command line parameters. It is also possible to drop into a shell inside the container.

Examples

    docker run -it --rm --privileged adilinden/rpi-stream:latest ffmpeg \
        -re -f mjpeg -framerate 5 -i http://192.168.1.34:8080/?action=stream \
        -ar 44100 -ac 2 -acodec pcm_s16le -f s16le -ac 2 -i /dev/zero \
        -vcodec h264 -pix_fmt yuv420p -framerate 5 -g 10 -strict experimental -filter:v null \
        -acodec aac -ab 128k -f flv rtmp://live.twitch.tv/app/live_123456789_mysupersecrettwitchkey

    docker run -it --rm --privileged adilinden/rpi-stream:latest bash

Enjoy!

