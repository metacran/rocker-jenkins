
FROM rhub/rocker-jenkins

MAINTAINER "r-hub admin" admin@r-hub.io

USER root

RUN apt-get update                     \
	&& apt-get install -y          \
		libxml2-dev            \
		libssl-dev             \
		libssh2-1-dev          \
	&& rm -rf /var/lib/apt/lists/*	

ENV PATH /opt/R-3.2.3/bin:$PATH

RUN Rscript -e 'options(repos = c(CRAN = "https://cran.rstudio.com/"))' \
            -e 'install.packages("devtools")'                           \
            -e 'library(devtools)'                                      \
            -e 'install_github("gaborcsardi/gh")'                       \
            -e 'install_github("metacran/crandb")'                      \
            -e 'install_github("metacran/desc")'                        \
            -e 'install_github("metacran/cranatgh")'


USER jenkins
