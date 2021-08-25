FROM manjarolinux/base:latest as base
RUN pacman -Syyu 

COPY . /srv/http


