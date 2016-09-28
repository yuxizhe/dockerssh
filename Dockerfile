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

RUN apt-get install -y curl

RUN curl -sL https://deb.nodesource.com/setup_4.x | sudo -E bash -
RUN apt-get install -y nodejs

RUN npm install pm2 -g

RUN git clone https://github.com/yuxizhe/heroku.git

WORKDIR /heroku


RUN git checkout firebase

RUN pm2 start index.js
