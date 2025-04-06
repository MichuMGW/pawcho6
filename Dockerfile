# syntax=docker/dockerfile:1.2

# Etap 1
FROM scratch AS stage1
ADD alpine-minirootfs-3.21.3-x86_64.tar /

# Deklaracja katalogu roboczego
WORKDIR /usr/app

# Instalacja nodejs i npm
RUN apk add --no-cache openssh-client git nodejs npm

RUN mkdir -p ~/.ssh && ssh-keyscan github.com >> ~/.ssh/known_hosts

RUN --mount=type=ssh git clone git@github.com:MichuMGW/pawcho6.git
WORKDIR /usr/app/pawcho6
RUN npm install

# Etap 2
FROM nginx:latest AS stage2

# Ustawienie zmiennej wersji aplikacji
ARG VERSION="1.0.0"
ENV VERSION=$VERSION

WORKDIR /usr/app

RUN apt update && apt install -y curl nodejs npm

# Kopiowanie plików z etapu 1 do etapu 2
COPY --from=stage1 /usr/app/pawcho6 /usr/app

COPY default.conf /etc/nginx/conf.d/default.conf

EXPOSE 80

# Healthcheck
# Sprawdzenie dostępności aplikacji co 10 sekund, z timeoutem 3 sekundy
HEALTHCHECK --interval=10s --timeout=1s \
    CMD curl -f http://localhost/80 || exit 1

# Uruchomienie aplikacji i nginx
CMD ["sh", "-c", "node /usr/app/index.js & nginx -g 'daemon off;'"]
