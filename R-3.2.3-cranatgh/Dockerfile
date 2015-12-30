
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

RUN echo 'options(repos = c(CRAN = "https://cran.rstudio.com/"))'   \
		>> ~/.Rprofile                                      \
        && Rscript -e 'install.packages("devtools")'                \
	&& Rscript -e 'devtools::install_github("gaborcsardi/gh")'  \
	&& Rscript -e 'devtools::install_github("metacran/crandb")' \
	&& Rscript -e 'devtools::install_github("metacran/description")' \
	&& Rscript -e 'devtools::install_github("metacran/cranatgh")'

USER jenkins
