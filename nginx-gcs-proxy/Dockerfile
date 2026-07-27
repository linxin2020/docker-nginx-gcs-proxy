FROM nginx:stable-bookworm

# The official image renders templates in this directory at container startup.
# Limit substitution to application settings so nginx variables such as $uri
# and $host remain intact.
ENV NGINX_ENVSUBST_FILTER="CACHE_MAX_SIZE|CACHE_PATH|CACHE_VALIDITY|LISTEN_PORT|NOT_FOUND_MEANS_INDEX"
COPY --chmod=755 prepare-cache.sh /docker-entrypoint.d/15-prepare-cache.sh
COPY nginx.conf.tmpl /etc/nginx/templates/default.conf.template

ENV CACHE_MAX_SIZE="30G"
ENV CACHE_PATH="/var/cache/nginx"
ENV CACHE_VALIDITY="3M"
ENV LISTEN_PORT="8080"
ENV NOT_FOUND_MEANS_INDEX="false"

CMD ["nginx", \
    "-g", \
    "daemon off;"]
