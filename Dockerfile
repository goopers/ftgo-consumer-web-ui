FROM node:12.22.1-alpine
#FROM ftgo-consumer-web-ui_server:latest
RUN npx envinfo > ./envinfo.log
RUN cat ./envinfo.log

ARG REACT_APP_BACKEND_API_URL
ENV REACT_APP_BACKEND_API_URL $REACT_APP_BACKEND_API_URL
RUN echo "REACT_APP_BACKEND_API_URL: $REACT_APP_BACKEND_API_URL"

COPY package.json .
COPY package-lock.json .
RUN npm config set unsafe-perm true && npm install -g serve
RUN npm install
ADD src ./src
ADD public ./public

#CMD npm run start
RUN npm run build
CMD npm run serve
