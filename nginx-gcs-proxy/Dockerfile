FROM nginx:stable-bookworm

# The official image renders templates in this directory at container startup.
# Limit substitution to application settings so nginx variables such as $uri
# and $host remain intact.
ENV NGINX_ENVSUBST_FILTER="GCS_BUCKET_URL|LISTEN_PORT|NOT_FOUND_MEANS_INDEX"
COPY nginx.conf.tmpl /etc/nginx/templates/default.conf.template

ENV GCS_BUCKET_URL=" "
ENV LISTEN_PORT="8080"
ENV NOT_FOUND_MEANS_INDEX="false"

CMD ["nginx", \
    "-g", \
    "daemon off;"]
