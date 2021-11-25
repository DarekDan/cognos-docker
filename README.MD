# Containerizing Cognos Analytics

## Cognos docs

[Silent Installation](https://www.ibm.com/docs/en/cognos-analytics/11.2.0?topic=configuration-use-silent-installation)

[Response File Template](https://www.ibm.com/docs/en/cognos-analytics/11.2.0?topic=configuration-use-response-file-template)

[Silent Configuration](https://www.ibm.com/docs/en/cognos-analytics/11.2.0?topic=configuration-use-silent)

## Docker Commands

### Build Cognos Dispatcher (with CM)
```shell
docker build --target cognos-dispatcher -t darekdan/cognos-dispatcher .
```
[SSH Config credit](https://stackoverflow.com/questions/22886470/start-sshd-automatically-with-docker-container)

### Start Cognos Dispatcher
```shell
docker run -d --restart unless-stopped -p 60022:22 --name cognos-dispatcher --hostname cogdisp darekdan/cognos-dispatcher
```

### Build a Microsoft SQL Server with CM database
```shell
docker build -t darekdan/cognos-db --target cognos-db .
docker run -d  -p 1433:1433 --name cognos-db --hostname cogdb darekdan/cognos-db
```
[Credit](https://www.abhith.net/blog/create-sql-server-database-from-a-script-in-docker-compose/)

## TODO 

1. Fix Docker DNS [Known issue](https://github.com/docker/for-win/issues/3810)
2. Implement docker-compose

#### Sample docker-compose.yaml
```yaml
version: '3.4'

services:
  other.service:
    ...
    environment:
      - ConnectionString=Data Source=CONTAINER_NAME_OF_db;Initial Catalog=DB_NAME;User Id=sa;Password=Your_password123;Pooling=False;Max Pool Size=200;MultipleActiveResultSets=True
    depends_on:
      - db
  db:
    image: my/db/image/name
    build:
      context: .
      dockerfile: data/Dockerfile
    # ports:
    #   - "1444:1433"
    volumes:
     - mssqldata:/var/opt/mssql

volumes:
  mssqldata:
```
ASP.Net Core
```yaml
services:
  other.service:
    image: my/aspnet-core-app/image/name
    build:
      context: .
      dockerfile: MyAspNetCore.App/Dockerfile
    environment:
      - ConnectionString=Data Source=CONTAINER_NAME_OF_db;Initial Catalog=DB_NAME;User Id=sa;Password=Your_password123;Pooling=False;Max Pool Size=200;MultipleActiveResultSets=True
    depends_on:
      - db
  db:
    image: my/db/image/name
    build:
      context: .
      dockerfile: data/Dockerfile
    # ports:
    #   - "1444:1433"
    volumes:
     - mssqldata:/var/opt/mssql
volumes:
  mssqldata:
```