ARG NODE_VERSION
FROM node:${NODE_VERSION} 
WORKDIR /app
COPY package.json yarn.lock ./

COPY ./src ./src

RUN yarn install 


EXPOSE 4000
CMD [ "yarn", "run", "start" ]
