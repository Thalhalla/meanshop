FROM nginx:alpine

RUN apk update && \
apk upgrade && \
apk add openssl bash && \
rm -rf /var/cache/apk/*

COPY nginx /assets
COPY client /meanshop/current/dist/public
CMD ["/assets/start.sh"]
