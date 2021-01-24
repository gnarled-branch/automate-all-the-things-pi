#define build-test stage

FROM node:12 as build-test          

#create app directory
WORKDIR /app

#install dependencies
COPY . .

RUN npm install && \                # Install dependencies
    npm run build && \              # Build the solution
    npm run test && \               # Run the tests
    
# run lean image
FROM node:12-alpine as run    

#create app directory
WORKDIR /app

#install dependencies
COPY --from=build-test /app/dist/src/ ./  # Copy binaries resulting from build-test

COPY package*.json ./    # Copy dependency registry

RUN npm install--only=prod         # Install only production dependencies

EXPOSE 3000

CMD ["node","index.js"]
