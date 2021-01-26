#define build-test stage

FROM node:12.16.1-alpine As builder

#create app directory
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm test && npm run build --prod

# run on nginx
FROM nginx:1.15.8-alpine

COPY --from=builder /usr/src/app/dist/SampleApp/ /usr/share/nginx/html
