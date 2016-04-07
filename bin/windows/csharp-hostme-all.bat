set executable=..\..\modules\swagger-codegen-cli\target\swagger-codegen-cli.jar

If Not Exist %executable% (
  mvn clean package
)

set tempate_dir=..\..\modules\swagger-codegen\target\classes
set language=csharp
set JAVA_OPTS=%JAVA_OPTS% -XX:MaxPermSize=256M -Xmx1024M -DloggerPath=conf/log4j.properties
set ags=generate  --model-package HostMe.Sdk.Models -t %template_dir%\%language% -i http://hostme-services-dev.azurewebsites.net:80/swagger/docs/all -l %language% -o samples\client\petstore\%language%
set ags1=generate --api-package HostMe.Sdk.Apis.Mobile --model-package HostMe.Sdk.Models -t %template_dir%\%language% -i http://hostme-services-dev.azurewebsites.net:80/swagger/docs/mb -l %language% -o samples\client\petstore\%language%
set ags2=generate --api-package HostMe.Sdk.Apis.Admin --model-package HostMe.Sdk.Models -t %template_dir%\%language% -i http://hostme-services-dev.azurewebsites.net:80/swagger/docs/mb -l %language% -o samples\client\petstore\%language%


java %JAVA_OPTS% -Dmodels -DsupportingFiles -jar %executable% %ags% -c options.json
java %JAVA_OPTS% -Dapis -jar %executable% %ags1% -c options.json
java %JAVA_OPTS% -Dapis -jar %executable% %ags2% -c options.json