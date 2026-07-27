# docker-nginx-gcs-proxy
A Docker image for running Nginx as a caching proxy for public Google Cloud Storage buckets.

Published multi-platform images are available from GitHub Container Registry:

```bash
docker pull ghcr.io/linxin2020/docker-nginx-gcs-proxy:latest
```

## Usage

```bash
docker build -t nginx-gcs-proxy ./nginx-gcs-proxy
docker run -d --name nginx-gcs-proxy \
  -e CACHE_PATH="/data/nginx-cache" \
  -e CACHE_VALIDITY="3M" \
  -v /srv/nginx-gcs-cache:/data/nginx-cache \
  -p 8080:8080 nginx-gcs-proxy

```

`CACHE_PATH` is the path inside the container. Mount the desired host directory
to the same path with `-v` to persist the cache across container replacements.
The container creates the directory when needed and makes it writable by Nginx.

### Docker Compose

The included `docker-compose.yaml` pulls the published image and stores cached
objects in a named Docker volume:

```bash
docker compose up -d
```

The host port, cache validity, and single-page application fallback can be
overridden when starting the stack:

```bash
PROXY_PORT=9090 CACHE_VALIDITY=7d NOT_FOUND_MEANS_INDEX=true \
  docker compose up -d
```

Stop the service without deleting its cache:

```bash
docker compose down
```

Put the bucket name in the first URL path segment:

```bash
curl http://127.0.0.1:8080/my-public-bucket/path/to/object
```

The request above is proxied to
`https://storage.googleapis.com/my-public-bucket/path/to/object`.

## Configuration

The following table lists the configurable environment variables of nginx-gcs-proxy and their default values.

Variable | Description | Default
--- | --- | ---
`CACHE_PATH` | Absolute cache directory inside the container. Mount a host directory to this path to persist cached objects. | `/var/cache/nginx`
`CACHE_VALIDITY` | How long successful responses remain valid and unused cache files are retained. Accepts a positive Nginx time value such as `12h`, `7d`, or `3M` (uppercase `M` means months; lowercase `m` means minutes). | `3M`
`LISTEN_PORT` | Server listen port | 8080
`NOT_FOUND_MEANS_INDEX` | When an object is not found, request `index.html` from the same bucket. Useful when serving single-page apps. Possible values: `true`, `false`. | false

## Health-checking

```bash
curl -v http://127.0.0.1:8080/healthz/

```
```
*   Trying 127.0.0.1...
* TCP_NODELAY set
* Connected to 127.0.0.1 (127.0.0.1) port 8080 (#0)
> GET /healthz/ HTTP/1.1
> Host: 127.0.0.1:8080
> User-Agent: curl/7.55.1
> Accept: */*
> 
< HTTP/1.1 200 OK
< Server: nginx
< Date: Wed, 17 Jan 2018 14:22:23 GMT
< Content-Type: application/octet-stream
< Content-Length: 0
< Connection: keep-alive
< 
* Connection #0 to host 127.0.0.1 left intact
```

## Building

```bash
docker build -t nginx-gcs-proxy ./nginx-gcs-proxy

```

## Testing

```bash
docker run --rm nginx-gcs-proxy nginx -t
```
