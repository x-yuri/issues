FROM alpine

RUN apk add tree rsync

WORKDIR /site
RUN mkdir -p public/assets \
    && echo 1.css > public/assets/1.css \
    && echo robots.txt > public/robots.txt \
    && mkdir bin
COPY entrypoint.sh bin

ENTRYPOINT ["bin/entrypoint.sh"]
