FROM streamsets/datacollector:${SDC_VERSION}
ARG SDC_LIBS

# Copy passwords file
COPY form-realm.properties etc/sdc/form-realm.properties
chmod go-rwx /etc/sdc/form-realm.properties

# Copy SQL Server jar
MKDIR /opt/extfiles/sqlserverjdbc
COPY mssql-jdbc-7.2.1.jre8.jar /opt/extfiles


RUN "${SDC_DIST}/bin/streamsets" stagelibs -install="${SDC_LIBS}"