# docker-squid-cache

Docker image for squid cache v5.1 <http://www.squid-cache.org>

> 5.2 releasing soon

## Run

- ```bash
  docker run -it --rm pratikimprowise/squid
  ## as daemon
  docker run -d pratikimprowise/squid
  ```

- With custom config

  ```bash
  docker run -it --rm -v $(pwd)/squid-cache.conf:/usr/local/squid/etc/squid.conf pratikimprowise/squid
  ```

## Tags

---

### `pratikimprowise/squid:`

- [`latest` , `5` , `5.1` , `5.1-main`](https://hub.docker.com/r/pratikimprowise/squid/tags?page=1&ordering=last_updated&name=5)
