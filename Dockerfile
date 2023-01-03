FROM ubuntu:22.04

LABEL \
	maintainer="ZeroK" \
	vendor="Lakka Project" \
	description="Container with everything needed to build Lakka"

RUN cp /etc/apt/sources.list /etc/apt/sources.list.bak
COPY . .
ADD sources.list /etc/apt/

RUN \
	# Install dependencies
	# See https://buildroot.org/downloads/manual/manual.html#requirement
	apt-get update && \
	apt-get install -y -q --no-install-recommends \
	# MANDATORY build tools
	#which \
	#sed \
	make \
	binutils \
	build-essential \
	gcc \
	g++ \
	#bash \
	patch \
	#gzip \
	bzip2 \
	perl \
	tar \
	cpio \
	unzip \
	rsync \
	file \
	bc \
	# MANDATORY source fetching tools
	wget \
	# OPTIONAL recommended dependencies
	python \
	python-dev \
	xxd \
	# OPTIONAL configuration interface dependencies
	libncurses5-dev \
	#libqt5-dev \
	#libglib2.0-dev libgtk2.0-dev libglade2-dev \
	# OPTIONAL source fetching tools
	#bazaar \
	# bzr \
	cvs \
	git \
	mercurial \
	rsync \
	liblscp-dev \
	subversion \
	# OPTIONAL java related packages
	#javacc \
	#jarwrapper \
	# OPTIONAL documentation generation tools
	#asciidoc \
	#w3m \
	python3 \
	python3-dev \
	python3-distutils \
	python3-setuptools \
	#dblatex \
	# OPTIONAL graph generation tools
	#graphviz \
	#python-matplotlib \
	#
	# ADDITIONAL dependency to get root certificates
	ca-certificates \
	# ADDITIONAL dependency to get client ssh
	openssh-client \
	# ADDITIONAL dependency to get unbuffer
	expect \
	# ADDITIONAL dependency to get locale-gen
	locales \
	# ADDITIONAL nice to have dependencies
	sudo \
	procps \
	&& \
	apt-get -y autoremove && \
	apt-get -y clean && \
	rm -rf /var/lib/apt/lists/* && \
	#
	# Set locale
	sed -i 's/# \(en_US.UTF-8\)/\1/' /etc/locale.gen && \
	locale-gen --purge --lang en_US.UTF-8  && \
	#
	# Add user
	useradd -ms /bin/bash lakka && \
	usermod -a -G sudo lakka && \
	echo "lakka:lakka" | chpasswd && \
	#
	
	# Set file ownership
	chown -R lakka:lakka /home/lakka

# Set user
USER lakka

# Set working directory
WORKDIR /home/lakka/

# Set environment
ENV \
	HOME=/home/lakka \
	LC_ALL=en_US.UTF-8
