FROM ubuntu:22.04

# Update package lists
RUN apt-get update

# Install any necessary packages or dependencies
# For example:
# RUN apt-get install -y <package-name>

# Set up any configurations or commands needed

# Set the default command to run when the container starts
CMD ["bash"]
