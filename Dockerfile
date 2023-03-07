FROM ubuntu:22.04
WORKDIR /usr/src/app
ENV LANG C.UTF-8
ENV DEBIAN_FRONTEND noninteractive

#var1
#RUN echo 'APT::Install-Suggests "0";' >> /etc/apt/apt.conf.d/00-docker
#RUN echo 'APT::Install-Recommends "0";' >> /etc/apt/apt.conf.d/00-docker
#RUN DEBIAN_FRONTEND=noninteractive \
#  apt-get update \
#  && apt-get install -y python3 \
#  && rm -rf /var/lib/apt/lists/*

# OS update, then clean up
#RUN apt-get -yq update  --fix-missing && \
#    apt-get -yq upgrade && \
#    apt-get -yq --no-install-recommends install \
#        software-properties-common \
#        apt-transport-https \
#        ca-certificates \
#        aptitude \
#        wget \
#        unzip && \
  #  #apt-get clean && \
  #  rm -rf /tmp/* /var/tmp/* /var/lib/apt/archive/* /var/lib/apt/lists/*
#RUN apt-get -yq --no-install-recommends install python3 git npm 
#RUN apt-get -yq install python3 git npm 
RUN apt update -y && apt upgrade -y && apt install git npm -y
RUN npm i -g yarn 
#n
#RUN n latest
RUN git clone https://github.com/baronrustamov/portal-dashboard.git .
#RUN npm cache clean --force
#RUN npm install
#ENV NODE_ENV=production
# EXPOSE 8080
RUN yarn install

# RUN apt-get clean -y && rm -rf /tmp/* /var/tmp/* /var/lib/apt/archive/* /var/lib/apt/lists/*

#EXPOSE 3000
ENV NODE_ENV production
ENV PORT 80
EXPOSE 80
#CMD [ "npm start", "dev" ]
CMD [ "yarn run", "dev" ]