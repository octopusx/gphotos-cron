FROM ubuntu:18.04

RUN apt update 
RUN apt -y install cron python3 python3-pip
RUN pip3 install gphotos-sync

RUN mkdir -p /root/.config /config
RUN ln -s /config /root/.config/gphotos-sync 
VOLUME /config

RUN mkdir /storage
VOLUME /storage

RUN (crontab -l 2>/dev/null; echo "* 4 * * * gphotos-sync /storage 2>&1 | tee -a /config/log.txt") | crontab -

CMD ["cron", "-f"]