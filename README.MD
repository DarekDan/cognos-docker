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