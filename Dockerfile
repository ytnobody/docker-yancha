FROM ytnobody/alpine-perl
MAINTAINER ytnobody <ytnobody@gmail.com>

ENV YANCHA_ROOT /opt/yancha

RUN apk update && apk add mysql-client sqlite openssl-dev bash

RUN git clone https://github.com/uzulla/yancha.git $YANCHA_ROOT

WORKDIR /opt/yancha
RUN cpanm --installdeps .

WORKDIR /
ADD my.cnf /etc/my.cnf
RUN chmod 600 /etc/my.cnf 

ADD config.pl $YANCHA_ROOT/config.pl
ADD create_db.sql $YANCHA_ROOT/db/create_db.sql

ADD run /opt/run
RUN chmod +x /opt/run

EXPOSE 3000
# CMD "/bin/sh"
ENTRYPOINT ["/bin/sh","/opt/run"]
