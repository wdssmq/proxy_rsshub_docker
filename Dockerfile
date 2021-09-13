FROM python:3.9.7-alpine

RUN pip install --upgrade pip \
 && pip install pipenv \
 && python --version ; pip --version ; pipenv --version

RUN mkdir /app
RUN mkdir /app/xml
RUN mkdir /entrypoint.d
RUN mkdir /web

WORKDIR /app

COPY proxy_rsshub/Pipfile /app
RUN pipenv install -d

COPY proxy_rsshub/*.py /app/
COPY proxy_rsshub/README.md /app

COPY php /app

COPY config.yml /app
COPY entrypoint.sh /entrypoint.d
RUN chmod +x /entrypoint.d/entrypoint.sh
ENTRYPOINT ["/entrypoint.d/entrypoint.sh"]
