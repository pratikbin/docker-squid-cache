FROM ubuntu:20.04 as build
ARG VERSION=5.1
ARG MAJOR_VERSION=5
ARG TINI_VERSION=0.19.0
ADD https://github.com/krallin/tini/releases/download/v$TINI_VERSION/tini /tini
WORKDIR /app
RUN set -ex; \
  apt-get update; \
  DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends \
    --no-install-suggests -y \make gcc g++ wget tar grep gawk; \
  wget --progress=dot:giga http://www.squid-cache.org/Versions/v$MAJOR_VERSION/squid-$VERSION.tar.gz; \
  tar -xzf squid-*.tar.gz; \
  cd squid-*; \
  ./configure; \
  make install -j$(grep processor /proc/cpuinfo | wc -l); \
  chmod +x /tini; \
  /usr/local/squid/sbin/squid -v

FROM ubuntu:21.10

COPY --from=build /usr/local/squid /usr/local/squid
COPY --from=build /tini /tini
RUN chmod o+rw -R /usr/local/squid/var/

ENTRYPOINT ["/tini", "--"]
CMD ["/usr/local/squid/sbin/squid","--foreground"]
