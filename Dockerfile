FROM python:2.7-alpine

RUN apk update && apk upgrade && \
    apk add \
        gcc python python-dev py-pip \
        # greenlet
        musl-dev \
        # sys/queue.h
        bsd-compat-headers \
        # event.h
        libevent-dev \
    && rm -rf /var/cache/apk/*

# want all dependencies first so that if it's just a code change, don't have to
# rebuild as much of the container
ADD requirements.txt /opt/requestbin/
RUN pip install -r /opt/requestbin/requirements.txt \
    && rm -rf ~/.pip/cache

# the code
ADD .  /opt/requestbin/

EXPOSE 8000

WORKDIR /opt/requestbin
CMD python web.py


