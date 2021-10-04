FROM ubuntu:20.04 as build
ARG VERSION=5.1
ARG MAJOR_VERSION=5
ARG TINI_VERSION=0.19.0
ADD https://github.com/krallin/tini/releases/download/v$TINI_VERSION/tini /tini
ADD http://www.squid-cache.org/Versions/v$MAJOR_VERSION/squid-$VERSION.tar.gz squid.tar.gz
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends \
    --no-install-suggests -y make gcc g++ wget tar grep
RUN tar -xzf squid.tar.gz; \
  cd squid-$VERSION; \
 ./configure --with-default-user=root; \
  make install -j$(nproc); \
  chmod +x /tini; \
  /usr/local/squid/sbin/squid -v

FROM ubuntu:21.10
## for squid and squidclient
ENV PATH="/usr/local/squid/sbin/:/usr/local/squid/bin/:${PATH}"

COPY --from=build /tini /tini
COPY --from=build /usr/local/squid /usr/local/squid
# RUN squid -z
ENTRYPOINT ["/tini", "--"]
CMD ["/usr/local/squid/sbin/squid","--foreground"]
