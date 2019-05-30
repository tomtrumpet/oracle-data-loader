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

ADD ./bootstrap.sh /app/bootstrap.sh
RUN chmod +x /app/bootstrap.sh

# wait for it
ADD wait-for-it.sh /app/wait-for-it.sh
RUN chmod +x /app/wait-for-it.sh

ENTRYPOINT ["./wait-for-it.sh", "db:1521", "--timeout=0", "--strict", "--", "/bin/bash", "-c", "/app/bootstrap.sh" ]
