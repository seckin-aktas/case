FROM python:2.7.17-alpine3.10

WORKDIR /app

RUN apk add --no-cache mariadb-connector-c-dev && \
    apk add --no-cache --virtual .build-deps \
        build-base \
        mariadb-dev && \
    pip install mysqlclient && \
    apk del .build-deps 

ADD requirements.txt .
RUN pip install -r requirements.txt

EXPOSE 3000

ADD main.py /app

CMD ["gunicorn", "-b", "0.0.0.0:3000", "main:application", "--reload"]
