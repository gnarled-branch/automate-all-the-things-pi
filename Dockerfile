#define build-test stage

FROM node:12-alpine as build-test          

#create app directory
WORKDIR/usr/src/app

#install dependencies
COPY . .

RUN npm install-test

# run lean image
FROM node:12-alpine as run    

#create app directory
WORKDIR /usr/src/app

#install dependencies
COPY --from=build-test /usr/src/app/dist/src/ ./  # Copy binaries resulting from build-test

COPY package*.json ./    # Copy dependency registry

RUN npm install--only=prod         # Install only production dependencies

EXPOSE 3000

CMD ["node","index.js"]
