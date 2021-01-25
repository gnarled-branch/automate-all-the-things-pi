#define build-test stage

FROM node:12 as install          
#create app directory
WORKDIR /app
COPY package*.json ./
COPY .babelrc ./
RUN npm install

FROM install as test-build  
WORKDIR /app
COPY *.js ./
RUN npm test
RUN npm run build


# run lean image
FROM node:12-alpine as run    
#create app directory
WORKDIR /app
COPY package.json ./
COPY .babelrc ./
RUN npm install
COPY --from=test-build /app/src/dist ./dist
EXPOSE 3000

CMD ["node","index.js"]
