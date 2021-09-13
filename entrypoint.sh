#!/bin/sh

sh -c "pipenv $*"

cp /app/*.php /web
cp /app/rss.opml /web
cp /app/README.md /web
mkdir -p /web/xml
cp /app/xml/*.xml /web/xml
