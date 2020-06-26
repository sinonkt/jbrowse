FROM bitnami/apache:2.4.43

ENV JBROWSE_VERSION 1.16.9

USER root

RUN apt-get update -y && \
  apt-get install -y \
  unzip \
  build-essential \
  libpng-dev \
  zlib1g-dev \
  libgd-dev

RUN curl -L -O https://github.com/GMOD/jbrowse/releases/download/${JBROWSE_VERSION}-release/JBrowse-${JBROWSE_VERSION}.zip && \
  rm -rf /app && \
  unzip -j JBrowse-${JBROWSE_VERSION}.zip -d /app && \
  rm -f JBrowse-${JBROWSE_VERSION}.zip && \
  cd /app && \
  rm -rf extlib && \
  ./bin/cpanm -v --notest -l extlib/ Bio::Perl@1.7.2 && \
  ./bin/cpanm JSON && \
  ./setup.sh

  
  # mv JBrowse-${JBROWSE_VERSION} /var/www/html/jbrowse && \
  # chown -R 1001 /var/www/html/jbrowse && \
  # cd /var/www/html/jbrowse && \
  # ./setup.sh

# USER 1001