FROM node:23-alpine AS build
ARG VERSION=v0.12.0

# hadolint ignore=DL3018
RUN : \
	&& apk add --no-cache git \
	&& rm -rf /var/cache/apk/*

WORKDIR /opt/node_app

RUN : \
	&& git clone --depth 1 --branch $VERSION https://github.com/excalidraw/excalidraw.git . \
	&& yarn --ignore-optional

ARG NODE_ENV=production

RUN yarn build:app:docker

FROM nginx:1.23-alpine

COPY --from=build /opt/node_app/build /usr/share/nginx/html

HEALTHCHECK CMD wget -q -O /dev/null http://localhost || exit 1
