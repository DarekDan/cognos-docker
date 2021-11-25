```shell
docker build --target cognos-dispatcher -t darekdan/cognos-dispatcher:11.2.1 .
```

```shell
docker run -d -p 60022:22 --name cognos-dispatcher --hostname cogdisp darekdan/cognos-dispatcher:11.2.1
```

```shell
docker run -e "ACCEPT_EULA=Y" -e "SA_PASSWORD=Pass@W0rd" -p 1433:1433 -d --hostname cogdb --name cogdb mcr.microsoft.com/mssql/server
```

```powershell
Get-Content .\Dockerfile.mssql | docker build -t darekdan/cognos-mssql -
```

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
AAP.Net Core
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