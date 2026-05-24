#Construcción con Node
FROM node:20-alpine AS build
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm install
COPY . .

ARG VITE_API_VENTAS
ARG VITE_API_DESPACHOS

ENV VITE_API_VENTAS=$VITE_API_VENTAS
ENV VITE_API_DESPACHOS=$VITE_API_DESPACHOS

RUN npm run build

#Servir con Nginx
FROM nginx:1.19.0-alpine
COPY --from=build /app/dist/ /usr/share/nginx/html
EXPOSE 80