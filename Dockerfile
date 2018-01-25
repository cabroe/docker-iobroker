############################################################
# Dockerfile to build ioBroker container images
# Based on Alpine Linux
############################################################

# Set the base image to Alpine Linux witch nodejs 6
FROM mhart/alpine-node:6

# File Author / Maintainer
MAINTAINER Carsten Bröckert <cabroe@gmail.com>

################## BEGIN INSTALLATION ######################
# Democontent
# Ref: http://google.com

# Install required libraries
# RUN apk add --update alpine-sdk avahi avahi-dev bash curl eudev-dev fontconfig git gnupg libpcap-dev procps python sudo unzip

RUN apk add --update --no-cache bash build-base git python sudo make tzdata xz

# Create the default iobroker directories
RUN mkdir -p /opt/iobroker/ && chmod 777 /opt/iobroker/
RUN mkdir -p /opt/scripts/ && chmod 777 /opt/scripts/

# Set workdir to /opt/scripts
WORKDIR /opt/scripts/

# Add scripts/iobroker_startup.sh to /opt/scripts/iobroker_startup.sh and make it executable
ADD scripts/iobroker_startup.sh iobroker_startup.sh
RUN chmod +x iobroker_startup.sh

# Set workdir to /opt/iobroker
WORKDIR /opt/iobroker/

# Install ioBroker and write local hostname to install_host file
RUN npm install iobroker --unsafe-perm && echo $(hostname) > .install_host

# Install node-gyp for compability reasons
RUN npm install node-gyp -g

# Set script for startup ioBroker ???
CMD ["sh", "/opt/scripts/iobroker_startup.sh"]
