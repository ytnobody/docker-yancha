# ytnobody/yancha

Yancha(Yet Another Network CHAt) on Docker

## synopsis

    $ sudo docker pull ytnobody/yancha
    $ sudo docker run -p 3000:3000 -d ytnobody/yancha

## note

### about chat log

In default settings, chat log is ephemeral data.

If you want to store it permanently, you have to use mysql. (see "using mysql" section in environment variables.)

### about twitter oauth

In default settings, twitter oauth is not enabled.

If you want enable it, please specify environment variables about twitter oauth. (see "using twitter-oauth" section in environment variables.)

## environment variables

### using mysql

* MYSQL\_DBHOST - mysql hostname or IP address
* MYSQL\_DBNAME - database name
* MYSQL\_USER - username
* MYSQL\_PASSWORD - password

### using twitter-oauth

* TWITTER\_CONSUMER\_KEY - consumer key
* TWITTER\_CONSUMER\_SECRET - consumer secret

### for debugging

* DEBUG - if you set as true value (like as 1), yancha is not start, and bootup with bash.

### exposed port

* 3000/tcp