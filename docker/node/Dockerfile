FROM node:20-alpine
WORKDIR /app
COPY src-node/package*.json ./
RUN npm install --production
COPY src-node/ .
CMD ["node", "index.js"]