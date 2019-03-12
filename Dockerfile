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

# Install JDBC driver
ENV STREAMSETS_LIBRARIES_EXTRA_DIR "/opt/sdc-extras/"

RUN "${SDC_DIST}/bin/streamsets" stagelibs -install=streamsets-datacollector-jdbc-lib