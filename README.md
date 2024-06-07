# docker-gitlfs

_A small archlinux image with `git` and `git-lfs` for containerized `git` operations._

## Usage

Use the `podman-compose.yml` file to start a container with the current directory mounted at `/workdir` in the container.

```bash
podman-compose up
```

Change the `podman-compose.yml` file to suit your needs particularly the `volumes` section.

## Build and Run

```bash
(podman|docker) build -t <your_repo_url>/gitlfs:latest .
(podman|docker) run -v ~/config:/config -v ~/data:/data <your_repo_url>/gitlfs:latest
```

## License

TBD
```
