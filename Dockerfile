# Use the latest Arch Linux base image
FROM archlinux:latest

# Set a build-time variable for the tag
ARG BUILD_TAG=1.0.3

# Set a runtime environment variable
ENV RUN_TAG=$BUILD_TAG

# Update the package lists
RUN pacman -Syu --noconfirm

# Install git and git-lfs
RUN pacman -S --noconfirm git git-lfs

# Set the working directory
WORKDIR /root

# Copy the scripts into the image
COPY scripts/*.sh /root

# Make the scripts executable
RUN chmod +x /root/*.sh

# Copy the configs.template file into the image
COPY config.template /root

# Install git-lfs
RUN git lfs install

# Copy the entrypoint script into the image
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint script as the default command to run when starting a container
ENTRYPOINT ["/entrypoint.sh"]
