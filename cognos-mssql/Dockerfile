FROM mcr.microsoft.com/mssql/server:2019-CU14-ubuntu-20.04 AS cognos-mssql-base

ENV SA_PASSWORD Pass@W0rd
ENV ACCEPT_EULA Y

EXPOSE 1433
USER root
RUN apt update
RUN apt-get -qq install netcat

FROM cognos-mssql-base as cognos-db
COPY ./entrypoint.sh /
COPY ./init.sql /

RUN chmod +x /entrypoint.sh
RUN chmod -x /init.sql

ENTRYPOINT [ "/bin/bash", "entrypoint.sh" ]
CMD [ "/opt/mssql/bin/sqlservr" ]
