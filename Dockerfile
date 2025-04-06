# syntax=docker:dockerfile:1.4
FROM scratch AS stage1
ADD alpine-minirootfs-3.21.3-x86_64.tar /

# Ustawienie zmiennej wersji aplikacji
ARG VERSION="1.0.0"
ENV VERSION=$VERSION

# Deklaracja katalogu roboczego
WORKDIR /usr/app

# Instalacja nodejs i npm
RUN apk add --no-cache nodejs npm

# Kopiowanie pliku aplikacji i zależności do kontenera
COPY ./ index.js package.json ./

# Instalacja zależności
RUN npm install
RUN --mount=type=ssh git clone git@github.com:MichuMGW/pawcho6.git

# Etap 2
FROM nginx:latest AS stage2

# Ustawienie zmiennej wersji aplikacji
ARG VERSION="1.0.0"
ENV VERSION=$VERSION

# Instalacja nodejs
RUN apt-get update && apt-get install -y nodejs

# Kopiowanie plików z etapu 1 do etapu 2
COPY --from=stage1 /usr/app /usr/share/nginx/html

EXPOSE 80

# Healthcheck
# Sprawdzenie dostępności aplikacji co 10 sekund, z timeoutem 3 sekundy
HEALTHCHECK --interval=10s --timeout=3s \
    CMD curl -f http://localhost/ || exit 1

# Uruchomienie aplikacji
CMD ["node", "/usr/share/nginx/html/index.js"]
