FROM oraclelinux:7-slim

ARG release=19
ARG update=3

RUN yum -y update

RUN  yum -y install oracle-release-el7 && yum-config-manager --enable ol7_oracle_instantclient && \
     yum -y install oracle-instantclient${release}.${update}-basic oracle-instantclient${release}.${update}-devel oracle-instantclient${release}.${update}-sqlplus && \
     yum -y install oracle-instantclient${release}.${update}-tools && \
     rm -rf /var/cache/yum

# Uncomment if the tools package is added
ENV PATH=$PATH:/usr/lib/oracle/${release}.${update}/client64/bin

WORKDIR /app

# setup cron
RUN yum -y install crontabs

# comment out PAM
RUN sed -i -e '/pam_loginuid.so/s/^/#/' /etc/pam.d/crond

ADD cron /etc/cron.d/load_data_cron
RUN chmod 0644 /etc/cron.d/load_data_cron
RUN crontab /etc/cron.d/load_data_cron
RUN touch /var/log/cron.log

ADD load.sh /app/load.sh
RUN chmod +x /app/load.sh

ADD things.data /app/things.data
ADD things.ctl /app/things.ctl

# run cron
CMD sleep 60 && crond && tail -f /var/log/cron.log
