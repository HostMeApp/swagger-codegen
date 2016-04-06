set executable=..\..\swagger-codegen-cli\swagger-codegen-cli.jar

If Not Exist %executable% (
  mvn clean package
)

set JAVA_OPTS=%JAVA_OPTS% -XX:MaxPermSize=256M -Xmx1024M -DloggerPath=conf/log4j.properties -DApis
set ags=generate -t ..\main\csharp -i http://hostme-services-dev.azurewebsites.net:80/swagger/docs/all -l csharp -o client\all\csharp -c options.json

java %JAVA_OPTS% -jar %executable% %ags%
