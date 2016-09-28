FROM       ubuntu:14.04


RUN apt-get update

RUN apt-get install -y openssh-server
RUN mkdir /var/run/sshd

RUN echo 'root:root' |chpasswd

RUN sed -ri 's/^PermitRootLogin\s+.*/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config

EXPOSE 22

CMD    ["/usr/sbin/sshd", "-D"]

RUN apt-get install -y git

RUN  wget -qO- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash

RUN nvm install node

RUN nvm use node

RUN npm install pm2 -g

RUN git clone https://github.com/yuxizhe/heroku.git

RUN cd heroku/

RUN pm2 start index.js
