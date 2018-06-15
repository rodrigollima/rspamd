FROM centos:centos7
MAINTAINER Rodrigo Lima <rodrigo.lima@inova.net>
ENV REFRESHED_AT 2018-06-15

RUN yum -y install epel-release
RUN curl -o /etc/yum.repos.d/rspamd.repo http://rspamd.com/rpm-stable/centos-7/rspamd.repo
RUN rpm --import http://rspamd.com/rpm-stable/gpg.key
RUN yum -y install rspamd

RUN	echo 'type = "console";' > /etc/rspamd/override.d/logging.inc \
	&& echo 'bind_socket = "*:11334";' > /etc/rspamd/override.d/worker-controller.inc \
	&& echo 'pidfile = false;' > /etc/rspamd/override.d/options.inc



VOLUME	[ "/usr/bin/rspamd" ]
CMD	[ "/usr/bin/rspamd", "-f", "-u", "_rspamd", "-g", "_rspamd" ]

EXPOSE	11333 11334
