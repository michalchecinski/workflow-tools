FROM alpine

RUN apk add --no-cache libstdc++ gcc gcompat

WORKDIR /usr/local/bin
RUN wget -O bw.zip "https://func.bitwarden.com/api/dl/?app=cli&platform=linux"
RUN unzip bw.zip
RUN rm -rf bw.zip
RUN chmod +x bw

WORKDIR /root
COPY ./entrypoint.sh .
RUN chmod +x entrypoint.sh
CMD ["/bin/sh", "./entrypoint.sh"]
