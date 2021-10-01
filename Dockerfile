FROM ubuntu as build
RUN set -ex; \
  apt update; \
  DEBIAN_FRONTEND=noninteractive apt install --no-install-recommends -y make gcc g++ wget tar grep gawk; \
  wget http://www.squid-cache.org/Versions/v5/squid-5.1.tar.gz; \
  tar -xzf squid-*.tar.gz; \
  cd squid-*; \
  ./configure; \
  make -j$(grep processor /proc/cpuinfo | wc -l); \
  squid -v

FROM ubuntu

RUN apt update; \
  DEBIAN_FRONTEND=noninteractive apt install -y --no-install-recommends cron libasn1-8-heimdal libcap2 libdbi-perl libecap3 libexpat1 libgdbm-compat4 libgdbm6 libgssapi-krb5-2 libgssapi3-heimdal libhcrypto4-heimdal libheimbase1-heimdal libheimntlm0-heimdal libhx509-5-heimdal libicu66 libk5crypto3 libkeyutils1 libkrb5-26-heimdal libkrb5-3 libkrb5support0 libldap-2.4-2 libldap-common libltdl7 libmnl0 libnetfilter-conntrack3 libnfnetlink0 libperl5.30 libpopt0 libroken18-heimdal libsasl2-2 libsasl2-modules-db libsqlite3-0 libssl1.1 libwind0-heimdal libxml2 logrotate netbase openssl perl perl-modules-5.30 squid-common squid-langpack ssl-cert tzdata ca-certificates
COPY --from=build /usr/sbin/squid /usr/sbin/squid
RUN squid -v

# apt update
# apt install squid
# squid -h
# squid -v
# wget
# apt install wget -y
# wget http://www.squid-cache.org/Versions/v5/squid-5.0.7.tar.gz
# tar -xvzf squid-5.0.7.tar.gz
# ls
# cd squid-5.0.7
# ls
# continue
# ./configure
# make
# apt install make
# make
# cat Makefile.
# ls
# cat Makefile.in
# ls
# ./configure
# apt install gcc gawk -y
# ./configure
# apt install g++ -y
# ./configure
# echo $?
# make
# make -j8
# squid -v
# du
# du $(which squid)
# du $(which squid) -sh
# history
