# docker-squid-cache

Docker image for squid cache v5 <http://www.squid-cache.org>

## Features

- `s6-overlay`ed
- Dynamically create `cache_dir` if exist
- Config reloader
- Stdout squid access logs
- Cert-checking
- *zero vulnerabilities by Trivy [`2021-10-16T23:44:19.434+0530`]

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

- Run squid

  ```bash
  docker-compoes up
  # OR
  docker run -it --name squid \
    -v $(pwd)/conf/squid-cache.conf:/etc/squid/squid.conf \
    -c $(pwd)/ssl:/etc/squid/ssl \
    -p 3129:3129 \
    pratikimprowise/squid:main
  ```

- Setup HTTP proxy on your devices or browsers (import CA cert to devices or browsers)

## Tags

### `pratikimprowise/squid:`

- [`latest` , `5` , `5.0` , `5.0-main`](https://hub.docker.com/r/pratikimprowise/squid/tags?page=1&ordering=last_updated&name=5)
