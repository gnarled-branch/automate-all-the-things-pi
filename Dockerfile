#define build-test stage

FROM node:current-alpine3.12 As builder
#create app directory
RUN apk add chromium
WORKDIR /app
ENV CHROME_BIN=/usr/bin/chromium-browser
COPY package*.json ./
RUN npm install
COPY . .
RUN npm test && npm run build --prod

# run on nginx
FROM nginx:1.15.8-alpine

COPY --from=builder /app/dist/SampleApp/ /usr/share/nginx/html
