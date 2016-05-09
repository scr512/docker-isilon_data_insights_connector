FROM phusion/baseimage
MAINTAINER Jason Davis <scr512@gmail.com>
RUN apt-get update && apt-get install -y \
    python \
    curl \
    git \
    python-pip \
    python-dev \
    gcc \
    --no-install-recommends \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN mkdir -p /opt/isilon_data_insights_connector
RUN git clone https://github.com/Isilon/isilon_data_insights_connector.git /opt/isilon_data_insights_connector
RUN curl https://bootstrap.pypa.io/ez_setup.py -o - | python
RUN pip install daemons influxdb urllib3 
RUN pip install git+https://github.com/Isilon/isilon_sdk_8_0_python.git
ADD ./isi_data_insights_d.cfg /opt/isilon_data_insights_connector/isi_data_insights_d.cfg

RUN mkdir /etc/service/isi_data_insights_d
ADD /daemon/isi_data_insights_d.sh /etc/service/isi_data_insights_d/run

CMD ["/sbin/my_init"]
