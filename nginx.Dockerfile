FROM nginx:alpine
COPY nginx /config-nginx
COPY client /meanshop/current/dist/public
CMD ["/config-nginx/start.sh"]
