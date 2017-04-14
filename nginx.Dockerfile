FROM nginx:alpine

RUN apk update && \
apk upgrade && \
apk add openssl && \
rm -rf /var/cache/apk/*

COPY nginx /config-nginx
COPY client /meanshop/current/dist/public
CMD ["/config-nginx/start.sh"]
