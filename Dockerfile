# build environment
FROM node:latest as builder
RUN mkdir /usr/src/app
WORKDIR /usr/src/app
ENV PATH /usr/src/app/node_modules/.bin:$PATH
# COPY . /usr/src/app
RUN npm install -g git
RUN git clone https://github.com/baronrustamov/portal-dashboard .
RUN npm install
RUN npm run build

# RUN yarn install
# RUN yarn run build 

# production environment
FROM nginx:latest
RUN rm -rf /etc/nginx/conf.d
RUN mkdir -p /etc/nginx/conf.d
COPY ./default.conf /etc/nginx/conf.d/
COPY --from=builder /usr/src/app/build /usr/share/nginx/html
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
