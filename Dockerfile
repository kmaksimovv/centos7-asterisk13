FROM centos:7
MAINTAINER MaksKon
RUN yum -y update
RUN yum -y install vim tar
RUN yum -y install gcc gcc-c++ make wget subversion \ 
            libxml2-devel ncurses-devel openssl-devel \ 
            sqlite-devel libuuid-devel vim-enhanced \ 
            jansson-devel unixODBC unixODBC-devel libtool-ltdl \ 
            libtool-ltdl-devel subversion speex-devel mysql-devel
WORKDIR /usr/src
RUN wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-13-current.tar.gz
RUN tar -zxvf asterisk-13-current.tar.gz
WORKDIR /usr/src/asterisk-13.38.3/
RUN sh contrib/scripts/get_mp3_source.sh
RUN ./configure
RUN make
RUN make install
# RUN make samples
RUN make config
RUN groupadd asterisk
RUN useradd -d /var/lib/asterisk -g asterisk asterisk
RUN chown -R asterisk:asterisk /var/spool/asterisk /var/run/asterisk /etc/asterisk /var/{lib,log,spool}/asterisk /usr/lib/asterisk
WORKDIR /root
CMD ["/usr/sbin/asterisk", "-f"]
