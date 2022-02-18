FROM postgres:13

ENV SCWS_VERSION 1.2.3
ENV RUM_VERSION 1.3.9

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates gcc g++ libc6-dev cmake make git wget curl \
        postgresql-server-dev-13 libpq-dev systemtap-sdt-dev

RUN mkdir -p /usr/lib/scws/rum && \
        git clone https://github.com/postgrespro/rum --branch ${RUM_VERSION} --single-branch /usr/lib/scws/rum && \
        git clone https://github.com/jaiminpan/pg_jieba /usr/lib/scws/pg_jieba
        

RUN /sbin/ldconfig -v && \
        chown -R postgres.postgres /usr/lib/postgresql && \
        chown -R postgres.postgres /usr/share/postgresql && \
        chown -R postgres.postgres /usr/include/postgresql && \
        chown -R postgres.postgres /usr/lib/scws/rum/

RUN cd /usr/lib/scws/rum/ && \
        make USE_PGXS=1 PG_CONFIG=/usr/lib/postgresql/13/bin/pg_config && \
        make USE_PGXS=1 PG_CONFIG=/usr/lib/postgresql/13/bin/pg_config install 
        #make USE_PGXS=1 PG_CONFIG=/usr/lib/postgresql/13/bin/pg_config installcheck 

RUN cd /usr/lib/scws/pg_jieba && \
        git submodule update --init --recursive && \
        mkdir /usr/lib/scws/pg_jieba/build && \
        cd /usr/lib/scws/pg_jieba/build &&\ 
        cmake -DPostgreSQL_TYPE_INCLUDE_DIR=/usr/include/postgresql/13/server .. && \
        make && make install  

RUN apt-get purge -y --auto-remove ca-certificates cmake wget unzip && \
        rm -rf /usr/lib/scws/rum /usr/lib/scws/pg_jieba


