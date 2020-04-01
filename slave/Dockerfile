FROM postgres:9.6.11

RUN apt-get update && apt-get --assume-yes install iputils-ping && apt-get install --assume-yes gosu

COPY ./docker-entrypoint.sh /docker-entrypoint.sh

RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]

CMD ["gosu","postgres", "postgres"]