ARG NODE_VERSION
ARG APP_ENV
FROM node:${NODE_VERSION} AS dev
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install
COPY src/ ./src/



FROM node:${NODE_VERSION} AS deps
WORKDIR /app
COPY package.json yarn.lock ./
RUN yarn install --production


FROM node:${NODE_VERSION} AS prod
WORKDIR /app
COPY --from=deps /app/node_modules ./node_modules/
COPY --from=dev /app ./
EXPOSE 4000
CMD ["node", "src/server.js"]
