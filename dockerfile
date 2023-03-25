FROM debian:latest

COPY config.sh /config.sh
RUN chmod +x /config.sh
COPY 10-uname /10-uname

CMD ["/config.sh"]