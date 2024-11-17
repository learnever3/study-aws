# STEP : 1 - BUILD REACT APP
FROM node:20-alpine3.20 AS build
WORKDIR /app
COPY package.json ./
RUN npm install
COPY . .
RUN npm run build

# STEP : 2 - SERVE WITH NGINX
FROM nginx:1.23-alpine
WORKDIR /usr/share/nginx/html
RUN rm -rf ./*
COPY --from=build /app/dist ./

# Copy the .env file into the container
COPY .env /usr/share/nginx/html/.env

EXPOSE 80
ENTRYPOINT ["nginx", "-g", "daemon off;"]
