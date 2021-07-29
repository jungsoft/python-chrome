# syntax=docker/dockerfile:1

FROM python:3.9

RUN apt-get update \
    && apt-get install -y \
        libglib2.0-0 \
        libnss3 \
        libgconf-2-4 \
        libfontconfig1 \
        wget \
        gcc

# Download and install Chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN echo "deb http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google.list

RUN apt-get update -y
RUN apt-get install -y google-chrome-stable=92.0.4515.107-1

# Download and install Chromedriver
RUN wget -q --continue -P /chromedriver "http://chromedriver.storage.googleapis.com/92.0.4515.107/chromedriver_linux64.zip"
RUN unzip /chromedriver/chromedriver* -d /chromedriver

# Put Chromedriver into the PATH
ENV PATH /chromedriver:$PATH
