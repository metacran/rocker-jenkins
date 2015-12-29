
FROM jenkins

MAINTAINER "r-hub admin" admin@r-hub.io

USER root

RUN apt-get update \
	&& apt-get install -y --no-install-recommends \
	gcc \
	g++ \
	gfortran \
	less \
	locales \
	ca-certificates \
	curl \
	default-jdk \
	libbz2-dev \
	libcairo2-dev \
	libcurl4-openssl-dev \
	libicu-dev \
	libjpeg-dev \
	libpcre3-dev \
	libpng-dev \
	libreadline-dev \
	libtiff5-dev \
	libx11-dev \
	libxt-dev \
	lmodern \
	subversion \
	tcl8.6-dev \
	texinfo \
	texlive-base \
	texlive-fonts-extra \
	texlive-fonts-recommended \
	texlive-latex-base \
	texlive-latex-recommended \
	tk8.6-dev \
	x11proto-core-dev \
	&& rm -rf /var/lib/apt/lists/*

## Configure default locale,
## see https://github.com/rocker-org/rocker/issues/19
RUN echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen && locale-gen
	en_US.utf8 && /usr/sbin/update-locale LANG=en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENV CRAN http://cran.r-project.org
ENV RVERSION 3.2.3

RUN rm -rf R-${RVERSION} R-${RVERSION}.tar.gz \
        && major=$(echo $RVERSION | sed 's/\..*$//') \
        && url="${CRAN}/src/base/R-${major}/R-${RVERSION}.tar.gz" \
        && curl -O "$url" \
	&& tar xzf "R-${RVERSION}.tar.gz"
		
ENV RPREFIX /opt/R-${RVERSION}
		
ENV ROPTIONS --with-recommended-packages=no
		
RUN cd R-${RVERSION}                                             \
	&& R_PAPERSIZE=letter                                    \
	R_BATCHSAVE="--no-save --no-restore"                     \
	PERL=/usr/bin/perl                                       \
	R_UNZIPCMD=/usr/bin/unzip                                \
	R_ZIPCMD=/usr/bin/zip                                    \
	R_PRINTCMD=/usr/bin/lpr                                  \
	AWK=/usr/bin/awk                                         \
	CFLAGS="-std=gnu99 -Wall -pedantic"                      \
	CXXFLAGS="-Wall -pedantic"                               \
	LIBS="-lz -lbz2 -llzma"                                  \
	./configure --prefix=${RPREFIX} ${ROPTIONS}              \
	&& make                                                  \
	&& make install

USER jenkins
