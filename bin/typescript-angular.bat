set executable=..\..\swagger-codegen-cli\swagger-codegen-cli.jar

If Not Exist %executable% (
  mvn clean package
)

set JAVA_OPTS=%JAVA_OPTS% -XX:MaxPermSize=256M -Xmx1024M -DloggerPath=conf/log4j.properties
set ags=generate --api-package HostMe.Sdk.Apis --model-package HostMe.Sdk.Models -t ..\main\typescript-angular -i http://hostme-services-dev.azurewebsites.net:80/swagger/docs/web -l typescript-angular -o samples\client\petstore\typescript-angular
set ags1=generate --model-package HostMe.Sdk.Models --api-package HostMe.Sdk.Apis -t ..\main\typescript-angular -i http://hostme-services-dev.azurewebsites.net:80/swagger/docs/web -l typescript-angular -o samples\client\petstore\typescript-angular


java %JAVA_OPTS% -Dmodels -DsupportingFiles -jar %executable% %ags1%
java %JAVA_OPTS% -Dapis -jar %executable% %ags%