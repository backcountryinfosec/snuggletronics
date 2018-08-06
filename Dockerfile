FROM resin/rpi-raspbian:jessie
MAINTAINER SuperTwigg

#Install dependencies

RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    git-core \
    build-essential \
    python3-pip
RUN ln -s /usr/bin/nodejs /usr/bin/node && \
    npm install -g bower
WORKDIR /opt/
RUN git clone git://git.drogon.net/wiringPi
RUN cd wiringPi && ./build
RUN pip3 install wiringpi \
    Flask-RESTful \
    SQLAlchemy
WORKDIR /opt/
RUN git clone https://github.com/backcountryinfosec/snuggletronics.git && \
    cd snuggletronics && \
    echo '{ "allow_root": true }' > /root/.bowerrc && \
    bower install

CMD ["/usr/bin/python3", "/opt/snuggletronics/runserver.py"]
