FROM debian:bullseye-slim

ENV LDNS_VERSION=1.8.1

RUN apt update &&\
    apt install -y build-essential libtool libssl-dev &&\
    rm -rf /var/lib/apt/lists/*

WORKDIR /tmp
ADD https://github.com/NLnetLabs/ldns/archive/refs/tags/${LDNS_VERSION}.tar.gz ldns.tar.gz

RUN tar xf ldns.tar.gz &&\
    cd ldns-${LDNS_VERSION} &&\
    libtoolize -ci && \
    autoreconf -fi &&\
    ./configure --enable-rrtype-svcb-https --with-drill &&\
    make &&\
    make install &&\
    ldconfig &&\
    rm -r /tmp

WORKDIR /

CMD ["drill"]
