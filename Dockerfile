# syntax=docker/dockerfile

FROM mongo:5.0.17 as production
LABEL maintainer=cichan02
COPY init.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/init.sh
RUN openssl rand -base64 756 > /etc/mongodb.keyfile && \
    chown mongodb /etc/mongodb.keyfile && \
    chmod 400 /etc/mongodb.keyfile
CMD ["mongod", "--replSet", "rs0", "--auth", "--keyFile", "/etc/mongodb.keyfile"]
