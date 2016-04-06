set executable=..\..\modules\swagger-codegen-cli\target\swagger-codegen-cli.jar

If Not Exist %executable% (
  mvn clean package
)

set tempate_dir=..\..\modules\swagger-codegen\target\classes
set language=typescript-angular
set JAVA_OPTS=%JAVA_OPTS% -XX:MaxPermSize=256M -Xmx1024M -DloggerPath=conf/log4j.properties
set ags=generate --api-package HostMe.Sdk.Apis --model-package HostMe.Sdk.Models -t %template_dir%\%language% -i http://hostme-services-dev.azurewebsites.net:80/swagger/docs/web -l %language% -o samples\client\petstore\%language%

java %JAVA_OPTS% -Dmodels -DsupportingFiles -jar %executable% %ags%
java %JAVA_OPTS% -Dapis -jar %executable% %ags%