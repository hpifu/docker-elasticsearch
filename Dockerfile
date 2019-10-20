FROM elasticsearch:7.3.2

ADD https://github.com/medcl/elasticsearch-analysis-ik/releases/download/v7.3.2/elasticsearch-analysis-ik-7.3.2.zip /tmp/
RUN /usr/share/elasticsearch/bin/elasticsearch-plugin install -b file:///tmp/elasticsearch-analysis-ik-7.3.2.zip

RUN rm -rf /tmp/*
