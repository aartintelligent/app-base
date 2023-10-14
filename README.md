# Docker App Base

### Usage

```shell
docker build . \
--tag aartintelligent/app-base:latest \
--build-arg "UID=$(id -u)" \
--build-arg "GID=$(id -g)" \
--build-arg "GIT_COMMIT=$(git rev-parse HEAD)"
```

```shell
docker run -d \
--name app-base \
aartintelligent/app-base:latest
```

```shell
docker container logs app-base
```

```shell
docker exec -it app-base supervisorctl status
```

```shell
until docker exec -it app-base /docker/d-health.sh >/dev/null 2>&1; do \
  (echo >&2 "Waiting..."); \
  sleep 2; \
done
```

```shell
docker exec -it app-base bash
```

```shell
docker stop app-base
```

```shell
docker rm app-base
```

```shell
docker login -u aartintelligent
```

```shell
docker push aartintelligent/app-base:latest
```
