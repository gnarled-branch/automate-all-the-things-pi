FROM node:12

#create app directory
WORKDIR /usr/src/app

#install dependencies
COPY package*.json ./

RUN npm install

#bundle app source
COPY . .

EXPOSE 8080

CMD ["node","index.js"]
