FROM ubuntu:20.04 as build
ARG VERSION=5.1
ARG MAJOR_VERSION=5
ADD http://www.squid-cache.org/Versions/v$MAJOR_VERSION/squid-$VERSION.tar.gz squid.tar.gz
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install --no-install-recommends \
    --no-install-suggests -y make gcc g++ wget tar grep
RUN tar -xzf squid.tar.gz; \
  cd squid-$VERSION; \
 ./configure --with-default-user=squid; \
  make install -j$(nproc); \
  /usr/local/squid/sbin/squid -v

FROM ubuntu:21.10
ARG S6_VERSION=2.2.0.1
ADD https://github.com/just-containers/s6-overlay/releases/download/$S6_VERSION/s6-overlay-amd64-installer /tmp/
ENV PATH="/usr/local/squid/sbin/:/usr/local/squid/bin/:${PATH}"
RUN chmod +x /tmp/s6-overlay-amd64-installer && /tmp/s6-overlay-amd64-installer /
RUN adduser --disabled-login --no-create-home --disabled-password squid
RUN set -ex; \
  mkdir -p /etc/services.d/squid/; \
  printf '#!/usr/bin/with-contenv bash\nmkdir -p /cache\nchown -cR squid:squid /usr/local/squid/var/ /cache' >/etc/cont-init.d/1-config; \
  printf '#!/usr/bin/execlineb\ns6-envuidgid squid\ns6-applyuidgid -U\n/usr/local/squid/sbin/squid -z\n/usr/local/squid/sbin/squid --foreground -d 1;' >/etc/services.d/squid/run

COPY --from=build /usr/local/squid /usr/local/squid
USER squid
ENTRYPOINT ["/init"]
