FROM manjarolinux/base:latest as base
RUN pacman -Syyu
RUN echo "y" | pacman -S apache 
RUN systemctl enable httpd
ENTRYPOINT ["tail"]
COPY . /srv/http

CMD ["-f","/dev/null"]
