#define build-test stage

FROM markadams/chromium-xvfb-js As builder

#create app directory
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm test && npm run build --prod

#RUN npm run build --prod

# run on nginx
FROM nginx:1.15.8-alpine

COPY --from=builder /app/dist/SampleApp/ /usr/share/nginx/html
