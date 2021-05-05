# django-nginx-docker

Simple example to show how to serve Django application with Nginx.

## Building

```shell
docker build -t django-nginx .
```

## Running

```shell
docker run -ti --rm \
  --name django \
  -p 8000:8000 \
  -v $(pwd)/docs:/docs \
  django-nginx:latest
```

Visit <http://0.0.0.0:8000/>
