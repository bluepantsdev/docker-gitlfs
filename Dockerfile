# Use the latest Arch Linux base image
FROM archlinux:latest

# Update the package lists
RUN pacman -Syu --noconfirm

# Install git and git-lfs
RUN pacman -S --noconfirm git git-lfs

# Set the working directory
WORKDIR /root

# Copy the config.template file into the image
COPY config.template /root/config.template

# Copy the gitconfig.template file into the image
COPY gitlfspull.sh.template /root/gitlfspull.sh.template

# Install git-lfs in the default account
RUN git lfs install

# Copy the entrypoint script into the image
COPY entrypoint.sh /entrypoint.sh

# Make the entrypoint script executable
RUN chmod +x /entrypoint.sh

# Set the entrypoint script as the default command to run when starting a container
ENTRYPOINT ["/entrypoint.sh"]
