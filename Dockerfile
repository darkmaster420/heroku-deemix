FROM lsiobase/alpine:3.15
FROM finniedj/deemix:latest

RUN apk add --no-cache curl jq
ARG TARGETARCH
ARG STATIC_URL
ARG BUILDDATE
ENV BUILDDATEENV=${BUILDDATE}
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt

LABEL \
    app.deemix.image.created="${BUILDDATE}" \
    app.deemix.image.url="https://gitlab.com/Bockiii/deemix-docker" \
    app.deemix.image.title="Docker image for Deemix" \
    app.deemix.image.description="Docker image for Deemix" \
    maintainer="Bocki"

RUN curl -L $STATIC_URL/deemix-server-linux-$TARGETARCH -o deemix-server

COPY root/ /

EXPOSE 6595
ENTRYPOINT [ "/init" ]
