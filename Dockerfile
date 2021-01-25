#define build-test stage

FROM node:12 as install-test          
#create app directory
WORKDIR /app
COPY package*.json ./
COPY .babelrc ./
RUN npm install-test

FROM install-test as build  
WORKDIR /app
COPY package*.json ./
COPY .babelrc ./
COPY *.js ./
RUN npm run build

# run lean image
FROM node:12-alpine as run    
#create app directory
WORKDIR /app
COPY package.json ./
COPY .babelrc ./
RUN npm install
COPY --from=build /app/dist ./dist
EXPOSE 3000

CMD ["node","index.js"]
