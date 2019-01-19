FROM adilinden/rpi-ffmpeg:20190119

COPY entry.sh entry.sh
RUN chmod +x entry.sh

ENTRYPOINT ["./entry.sh"]