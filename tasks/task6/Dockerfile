From ubuntu:18.04
RUN apt-get update && apt-get install -y nginx && apt-get clean && rm -rf /var/lib/apt/lists/*
RUN touch index.html
RUN echo "hello world from saad" > index.html
RUN tar cvfk index.html.tar index.html
RUN cp index.html /var/www/html/
RUN mv  index.html.tar /var/www/html/
EXPOSE 80
CMD [ "nginx","-g","daemon off;"]
