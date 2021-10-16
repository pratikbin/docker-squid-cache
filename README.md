# docker-squid-cache

Docker image for squid cache v5 <http://www.squid-cache.org>

## Run

- Create certs

  ```bash
  mkdir -p ssl
  openssl req -new -newkey rsa:2048 -sha256 -days 9999 -nodes -x509 \
    -extensions v3_ca -keyout ssl/private.pem \
    ## -subj "/O=Improwised/OU=DevOpsDept/C=IN/ST=Gujarat/L=Rajkot" \
    -out ssl/private.pem

  openssl x509 -in ssl/private.pem \
    -outform DER -out ssl/CA.der

  openssl x509 -inform DER -in ssl/CA.der \
    -out ssl/CA.pem
  ```

- ```bash
  docker run -it --rm pratikimprowise/squid
  ## as daemon
  docker run -d pratikimprowise/squid
  ```

- With custom config

  ```bash
  docker run -it --rm -v $(pwd)/squid-cache.conf:/etc/squid/squid.conf pratikimprowise/squid
  ```

- Setup HTTP proxy on your devices or browsers (import CA cert to devices or browsers)

- Done.

## Tags

### `pratikimprowise/squid:`

- [`latest` , `5` , `5.0` , `5.0-main`](https://hub.docker.com/r/pratikimprowise/squid/tags?page=1&ordering=last_updated&name=5)
