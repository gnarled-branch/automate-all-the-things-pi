#define build-test stage

FROM node:12 as install-test          
#create app directory

WORKDIR /app
COPY package*.json ./
COPY .babelrc ./
RUN npm ci
COPY *.js ./
RUN npm test

FROM install-test as build  
WORKDIR /app
COPY *.js ./
RUN npm run build

# run lean image
FROM node:12-alpine as run    
#create app directory
WORKDIR /app
COPY package*.json ./
COPY .babelrc ./
RUN npm ci
COPY --from=build /app/src/dist .
EXPOSE 3000

CMD ["node","index.js"]
