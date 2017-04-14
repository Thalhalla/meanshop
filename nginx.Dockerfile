FROM nginx:alpine

ENV THALHALLA_MEANSHOP true

RUN apk update && \
apk upgrade && \
apk add openssl && \
apk add bash && \
rm -rf /var/cache/apk/*

COPY nginx /assets
COPY client /meanshop/current/dist/public
CMD ["/assets/start.sh"]
