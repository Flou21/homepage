# This is a multi-stage Dockerfile (build and run)

# Remember to target specific version in your base image,
# because you want reproducibility (in a few years you will thank me)

FROM ubuntu:22.04 as build

# update
RUN apt-get update -y

# Install build dependencies
RUN apt-get install hugo -y

WORKDIR /app

# Copy the source code
COPY . .

# Build the static files
RUN hugo

# Rootless nginx
FROM nginxinc/nginx-unprivileged:1.17.6-alpine

# Copy the static files from the build stage
COPY --from=build /app/public /usr/share/nginx/html

