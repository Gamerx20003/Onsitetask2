FROM manjarolinux/base:latest as base
RUN pacman -Syyu 
ENTRYPOINT ["tail"]

COPY . /srv/http

CMD ["-f","/dev/null"]
