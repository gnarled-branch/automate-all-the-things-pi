FROM node:12-alpine as build-test           #define the base image

#create app directory
WORKDIR/usr/src/app

#install dependencies
COPY . .

RUN npm install-test

#bundle app source
COPY . .


FROM node:12-alpine as run           #define the run image

#create app directory
WORKDIR /usr/src/app

#install dependencies
COPY --from=build-test /usr/src/app/dist/src/ ./  # Copy binaries resulting from build-test

COPY package*.json ./    # Copy dependency registry

RUN npm install--only=prod         # Install only production dependencies

EXPOSE 3000

CMD ["node","index.js"]
