FROM streamsets/datacollector
ARG SDC_LIBS

# Copy passwords file
COPY form-realm.properties etc/sdc/form-realm.properties
RUN sudo chmod go-rwx /etc/sdc/form-realm.properties
RUN sudo chown sdc /etc/sdc/form-realm.properties
#RUN sudo ls -l /etc/sdc

# Copy security file
COPY sdc-security.policy etc/sdc/sdc-security.policy
RUN sudo chown sdc /etc/sdc/sdc-security.policy

# Copy SQL Server jar
RUN sudo mkdir -p /opt/sdc-extras/streamsets-datacollector-jdbc-lib/lib/
COPY mssql-jdbc-7.2.1.jre8.jar /opt/sdc-extras/streamsets-datacollector-jdbc-lib/lib/mssql-jdbc-7.2.1.jre8.jar
ENV STREAMSETS_LIBRARIES_EXTRA_DIR "/opt/sdc-extras/"

# Copy Snowflake library and unpack it
COPY streamsets-datacollector-snowflake-lib-1.0.1.tgz /opt/streamsets-datacollector-user-libs/streamsets-datacollector-snowflake-lib-1.0.1.tgz
RUN sudo tar -xvzf /opt/streamsets-datacollector-user-libs/streamsets-datacollector-snowflake-lib-1.0.1.tgz
RUN cp -r streamsets-libs/streamsets-datacollector-snowflake-lib /opt/streamsets-datacollector-user-libs/


RUN "${SDC_DIST}/bin/streamsets" stagelibs -install=streamsets-datacollector-jdbc-lib