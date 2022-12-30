FROM tiangolo/node-frontend:10 
WORKDIR /app
COPY package*.json /app/RUN 
RUN npm install
COPY ./ /app/
RUN npm run build

FROM nginx
COPY --from=build-stage /app/build/ /usr/share/nginx/html
COPY --from=build-stage /nginx.conf /etc/nginx/conf.d/default.conf
CMD ["nginx","-g","daemon off"]


