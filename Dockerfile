FROM wettyoss/wetty:2.5

RUN apk add ncdu

# create placehoders for ncdu folder/dump
RUN mkdir -p /folder-to-scan/
RUN touch /ncdu-dump.json

COPY ./docker-entrypoint.sh /docker-entrypoint.sh
RUN chmod +x /docker-entrypoint.sh

ENTRYPOINT [ "/docker-entrypoint.sh" ]
