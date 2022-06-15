# Build image
FROM node:18-alpine as builder

COPY . /usr/src/app
WORKDIR /usr/src/app
# builds the /dist directory
RUN npm install \
    && npm run build

# Run image
FROM node:18-alpine

# copy /dist to this image
COPY --from=builder /usr/src/app/dist /usr/app
WORKDIR /usr/app

# The /dist directory could be served from a CDN or any web server
# This example uses the `serve` package
RUN npm install -g serve@13.0.2

ENTRYPOINT ["serve", "-s", "/usr/app", "-l", "8080"]
EXPOSE 8080
