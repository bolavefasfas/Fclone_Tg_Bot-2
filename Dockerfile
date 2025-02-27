FROM ubuntu:20.04

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

RUN apt-get -qq update -y 
RUN apt-get clean && \
    apt-get -y update && \
    apt-get install -y locales && \
    locale-gen en_US.UTF-8
RUN apt-get -qq install -y DEBIAN_FRONTEND=noninteractive git python3 python3-pip \
    locales python3-lxml aria2 \
    curl pv jq nginx npm
    
COPY requirements.txt .
RUN pip3 install --no-cache-dir -r requirements.txt && \
    apt-get -qq purge git
    
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

COPY . .

RUN chmod +x start.sh
RUN chmod +x fclone
CMD ["bash","start.sh"]
