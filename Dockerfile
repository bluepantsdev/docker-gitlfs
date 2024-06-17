# Use the latest Arch Linux base image
FROM ubi9-init:latest

# Set a build-time variable for the tag
ARG BUILD_TAG=1.0.5

# Set a runtime environment variable
ENV RUN_TAG=$BUILD_TAG

# Update the container
RUN dnf -y update; dnf clean all

# Install git and git-lfs
RUN dnf install -y git git-lfs

# Install git-lfs
RUN git lfs install

# Copy the configs.template file into the image
COPY rootfs/ /

# chmod /usr/local/bin/update-timer.sh
RUN chmod +x /usr/local/bin/update-timer.sh

# enable gitlfspull timer
RUN systemctl enable update-timer.timer

CMD [ "/sbin/init" ]

