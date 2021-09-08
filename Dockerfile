ARG PYTHON_IMAGE_VERSION=3
FROM python:$PYTHON_IMAGE_VERSION

RUN pip install --upgrade pip \
 && pip install pipenv \
 && python --version ; pip --version ; pipenv --version

RUN mkdir /app
RUN mkdir /app/xml
RUN mkdir /entrypoint.d

WORKDIR /app

COPY proxy_rsshub/Pipfile /app
RUN pipenv install -d

COPY proxy_rsshub/main.py /app
COPY proxy_rsshub/function_base.py /app
COPY proxy_rsshub/README.md /app

COPY php /app

COPY config.json /app
COPY entrypoint.sh /entrypoint.d
RUN chmod +x /entrypoint.d/entrypoint.sh
ENTRYPOINT ["/entrypoint.d/entrypoint.sh"]
