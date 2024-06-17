# docker-gitlfs

_A small archlinux image with `git` and `git-lfs` for containerized `git` operations._

## Usage

Use the `podman-compose.yml` file to start a container with the current directory mounted at `/workdir` in the container.

```bash
podman-compose up
```

Change the `podman-compose.yml` file to suit your needs particularly the `volumes` section.
## Clone the repository.

```bash
git clone git@github.com:bluepantsdev/docker-gitlfs.git
cd docker-gitlfs
```

## Container Workflow

Follow these tips to build, run and test the container.

### Set some variables to save your self time

```bash
export container_image="localhost/gitlfs"
export container_tag="<nexttag>"
```

### Build the container

After making changes to the scripts, Dockerfile, etc build the image and start a container.

```bash
# Build the container
podman build -t $container_image:$container_tag .
# Run with the interactive flag to test the container
podman run -it --name gitlfs -v ./config:/config -v ./data:/data $container_image:$container_tag
# run with the daemon flag to run in the background
podman run -t -d --name gitlfs -v ./config:/config -v ./data:/data $container_image:$container_tag
```
If all looks good, then go ahead and push the image to the registry.

```bash
podman push docker.io/bluepantsdev/gitlfs:$container_tag
podman push docker.io/bluepantsdev/gitlfs:latest
```

If you need to make changes, then you can remove the image and container and start over.

```bash
podman rm $(podman ps -a -q --filter ancestor=$container_image) && podman rmi $(podman images -q $container_image)
```

## Compose Workflow

Edit as needed and test with `podman-compose`.

```bash
podman-compose up
```

Stop the compose stack

```bash
podman-compose down
```

## Tips

Stop and remove a container and images

```bash
podman rm $(podman ps -a -q --filter ancestor=$container_image) && podman rmi $(podman images -q $container_image)
```

Remove unused ("dangling") images

```bash
podman images -q -f "dangling=true"
```

## License

TBD
```
