set executable=.\modules\swagger-codegen-cli\target\swagger-codegen-cli.jar

If Not Exist %executable% (
  mvn clean package
)

set JAVA_OPTS=%JAVA_OPTS% -XX:MaxPermSize=256M -Xmx1024M -DloggerPath=conf/log4j.properties
set ags=generate -Dmodels -t modules\swagger-codegen\src\main\resources\csharp -i http://hostme-services-dev.azurewebsites.net:80/swagger/docs/all -l csharp -o client\all\csharp -c bin\windows\options.json

java %JAVA_OPTS% -jar %executable% %ags%
