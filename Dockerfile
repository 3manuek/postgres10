FROM ubuntu:16.04
MAINTAINER Emanuel Calvo  <3manuek at gmail domain>
ARG INCUBATOR_VER=unknown

RUN apt-get update

RUN apt-get -y -q install locales git build-essential libreadline-dev zlib1g-dev bison flex
RUN rm -rf /var/lib/apt/lists/* \
	&& localedef -i en_US -c -f UTF-8 -A /usr/share/locale/locale.alias en_US.UTF-8
ENV LANG en_US.utf8

RUN git clone https://github.com/postgres/postgres.git

RUN cd postgres && \
    ./configure --prefix=/opt/pg10 && \
    make 

USER root
RUN cd postgres/contrib && \
    make all && \
    make install && \
    cd ..

RUN cd postgres && make install
RUN useradd postgres 
RUN chown -R postgres:  /opt/pg10/

RUN INCUBATOR_VER=${INCUBATOR_VER} pwd

USER postgres
# export LC_CTYPE=en_US.UTF-8
#CMD ["/opt/pg10/bin/initdb", "-D", "/opt/pg10/data"]
#RUN mkdir -p /var/run/postgresql && chown -R postgres /var/run/postgresql
RUN /opt/pg10/bin/initdb -D /opt/pg10/data
#RUN chown postgres: -R /opt/pg10/data/
USER postgres 
RUN sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /opt/pg10/data/postgresql.conf 
RUN echo "host all  all    0.0.0.0/0  md5" >> /opt/pg10/data/pg_hba.conf
#RUN echo "listen_addresses='*'" >> /opt/pg10/data/postgresql.conf

VOLUME  ["/opt/pg10/data"]

ENTRYPOINT ["docker-entrypoint.sh"]
EXPOSE 5432

CMD ["/opt/pg10/bin/postgres", "-D", "/opt/pg10/data", "-c", "config_file=/opt/pg10/data/postgresql.conf"]

# Set the default command to run when starting the container
#CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]