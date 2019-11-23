FROM alpine:3.7
RUN apk add --update py-pip python-dev py-mysqldb mariadb-dev mariadb-client-libs

RUN apk --no-cache add --virtual build-dependencies build-base py-mysqldb gcc libc-dev libffi-dev mariadb-dev

RUN pip install gunicorn flask mysqlclient

WORKDIR /case/
