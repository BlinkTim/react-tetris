# Stage 1: Build React-Tetris App
FROM node:lts-alpine as builder

# Arbeitsverzeichnis setzen
WORKDIR /app

# Abhängigkeiten installieren
COPY package.json package-lock.json ./

# App-Quellcode kopieren und bauen
COPY . .
RUN npm install
RUN npm run build

# Stage 2: Setup Nginx und Kopiere den gebauten Code
FROM nginx:alpine

# Kopiere den gebauten Code aus dem vorherigen Builder-Stage
COPY --from=builder /app/dist /usr/share/nginx/html

# Nginx-Konfiguration kopieren
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Port für den Webserver öffnen
EXPOSE 80

# Container starten
CMD ["nginx", "-g", "daemon off;"]
