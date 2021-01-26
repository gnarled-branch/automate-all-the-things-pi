#define build-test stage

FROM node:12 as build          
#create app directory
WORKDIR /app
COPY package*.json ./
COPY .babelrc ./
RUN npm ci 
COPY . .
RUN npm test && npm run build

# run lean image
FROM node:12-alpine as run    
#create app directory
WORKDIR /app
COPY package*.json ./
COPY .babelrc ./
RUN npm ci --production && npm cache clean --force
COPY --from=build /app/src/dist .
EXPOSE 3000

CMD ["node","index.js"]
