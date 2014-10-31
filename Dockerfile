FROM ytnobody/ubuntu-jp:latest
MAINTAINER ytnobody <ytnobody@gmail.com>

ENV YANCHA_ROOT /opt/yancha

RUN apt-get install mysql-client libmysqlclient-dev sqlite3 -y --force-yes

RUN git clone https://github.com/uzulla/yancha.git $YANCHA_ROOT
RUN cd $YANCHA_ROOT && carton install && carton install --cpanfile cpanfile.mysql

ADD my.cnf /etc/my.cnf
RUN chmod 600 /etc/my.cnf 

ADD config.pl $YANCHA_ROOT/config.pl
ADD create_db.sql $YANCHA_ROOT/db/create_db.sql

ADD run /opt/run
RUN chmod +x /opt/run

EXPOSE 3000
ENTRYPOINT /opt/run
