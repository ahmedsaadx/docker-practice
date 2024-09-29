# Build Stage
FROM node:20-slim 
RUN apt-get update && apt-get install curl -y 
USER node
WORKDIR /app
COPY --chown=node:node package*.json ./
RUN npm ci
COPY --chown=node:node . .
RUN cp .env.example .env
RUN npm run build


EXPOSE 3000
CMD ["npm", "run", "start"]
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 CMD curl -s -o /dev/null -w "%{http_code}" http://localhost:3000 || exit 1

