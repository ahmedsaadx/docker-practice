FROM node:alpine 
WORKDIR /app
COPY package*.json . 
RUN npm install
COPY . /app/
RUN npm run build

FROM nginx:alpine
COPY --from=build-stage /app/build/ /usr/share/nginx/html
CMD ["nginx","-g","daemon off"]


