```shell
docker build --target cognos-dispatcher -t darekdan/cognos-dispatcher:11.2.1 .
```

```shell
docker run -d -p 60022:22 --name cognos-dispatcher --hostname cogdisp darekdan/cognos-dispatcher:11.2.1
```