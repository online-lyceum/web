FROM ubuntu:22.04 as builder
WORKDIR /build
RUN apt-get update && apt-get install -y npm
COPY ./app ./ 
RUN npm run build


FROM nginx:stable
COPY --from=builder /build/dist /usr/share/nginx/html

