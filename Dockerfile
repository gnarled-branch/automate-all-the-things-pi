#define build-test stage

FROM node:12 as build-test          

#create app directory
WORKDIR /app

#install dependencies
COPY package*.json ./

RUN npm install-test
    
# run lean image
FROM node:12-alpine as run    

#create app directory
WORKDIR /app

#install dependencies
COPY . .

RUN npm install

EXPOSE 3000

CMD ["node","index.js"]
