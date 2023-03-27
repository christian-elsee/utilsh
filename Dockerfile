FROM alpine:3.15
WORKDIR /opt/main
ENV PATH="/opt/main/src:$PATH"

RUN apk add --update-cache \
      curl  \
      socat \
      bats \
      git \
      shellcheck

ENTRYPOINT [ "bats" ]
CMD [ "--tap", "test" ]
