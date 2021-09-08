#!/bin/sh

sh -c "pipenv $*"

cp /app/*.php /app/xml
cp /app/README.md /app/xml

