# About

## What is this for?

I built this to stream the webcam attached to my [OctoPi](https://octoprint.org/) to [YouTube Live](https://www.youtube.com/channel/UC4R8DWoMoI7CAwX8_LjQHig). There is nothing more excting then watching a live stream of a 3D printer laying down lines of plastic, right?

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

Run with `shell` command or without command to get dropped into `bash` shell.

Run with `octopi-youtubelive` command and a number of arguments to stream the [OctoPi](https://octoprint.org/) webcam to [YouTube Live](https://www.youtube.com/channel/UC4R8DWoMoI7CAwX8_LjQHig). The following arguments are expected:

- OctoPi Webcam Stream (Example: http://192.168.1.34:8080/?action=stream)
- YouTube Live Server URL (Example: rtmp://a.rtmp.youtube.com/live2)
- YouTube Live Stream Name/Key (Example: xxxx-xxxx-xxxx-xxxx)
- OctoPi Filter (Example: null)

    docker run -it --rm --privileged adilinden/rpi-stream:latest octopi-youtubelive \
        http://192.168.1.34:8080/?action=stream \
        rtmp://a.rtmp.youtube.com/live2 \
        xxxx-xxxx-xxxx-xxxx \
        null
