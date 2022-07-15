FROM node:14-alpine AS build
ARG VERSION=v0.12.0

RUN apk add git

WORKDIR /opt/node_app

RUN git clone --depth 1 --branch $VERSION https://github.com/excalidraw/excalidraw.git .

RUN yarn --ignore-optional

ARG NODE_ENV=production

RUN yarn build:app:docker

FROM nginx:1.21-alpine

COPY --from=build /opt/node_app/build /usr/share/nginx/html

HEALTHCHECK CMD wget -q -O /dev/null http://localhost || exit 1
