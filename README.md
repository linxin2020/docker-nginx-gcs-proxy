# docker-nginx-gcs-proxy
A Docker image for running Nginx as a caching proxy for public Google Cloud Storage buckets.

## Usage

```bash
docker build -t nginx-gcs-proxy ./nginx-gcs-proxy
docker run -d --name nginx-gcs-proxy \
  -p 8080:8080 nginx-gcs-proxy

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
