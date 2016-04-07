set executable=..\modules\swagger-codegen-cli\target\swagger-codegen-cli.jar

If Not Exist %executable% (
  mvn clean package
)

set swagger_uri=%1
set out_dir=clients
set tempate_dir=..\modules\swagger-codegen\target\classes
set language=typescript-angular
set JAVA_OPTS=%JAVA_OPTS% -XX:MaxPermSize=256M -Xmx1024M -DloggerPath=conf/log4j.properties
set ags1=generate --api-package HostMe.Sdk --model-package HostMe.Sdk -t %template_dir%\%language% -i %swagger_uri%/mb -l %language% -o %out_dir%\hostme-sdk-angular-mobile
set ags2=generate --api-package HostMe.Sdk --model-package HostMe.Sdk -t %template_dir%\%language% -i %swagger_uri%/admin -l %language% -o %out_dir%\hostme-sdk-angular-admin
set ags3=generate --api-package HostMe.Sdk --model-package HostMe.Sdk -t %template_dir%\%language% -i %swagger_uri%/web -l %language% -o %out_dir%\hostme-sdk-angular-web

java %JAVA_OPTS% -Dapis -Dmodels -DsupportingFiles -jar %executable% %ags1% -c options.json
java %JAVA_OPTS% -Dapis -Dmodels -DsupportingFiles -jar %executable% %ags2% -c options.json
java %JAVA_OPTS% -Dapis -Dmodels -DsupportingFiles -jar %executable% %ags3% -c options.json

set language=csharp
set ags=generate  --model-package HostMe.Sdk.Models -t %template_dir%\%language% -i %swagger_uri%/all -l %language% -o %out_dir%\hostme-sdk-csharp-models
set ags1=generate --api-package HostMe.Sdk.Apis.Mobile --model-package HostMe.Sdk.Models -t %template_dir%\%language% -i %swagger_uri%/mb -l %language% -o %out_dir%\hostme-sdk-csharp-mobile
set ags2=generate --api-package HostMe.Sdk.Apis.Admin --model-package HostMe.Sdk.Models -t %template_dir%\%language% -i %swagger_uri%/admin -l %language% -o %out_dir%\%language%\hostme-sdk-csharp-admin
set ags3=generate --api-package HostMe.Sdk.Apis.Web --model-package HostMe.Sdk.Models -t %template_dir%\%language% -i %swagger_uri%/web -l %language% -o %out_dir%\hostme-sdk-csharp-web

java %JAVA_OPTS% -Dmodels -jar %executable% %ags% -c options.json
java %JAVA_OPTS% -Dapis -jar %executable% %ags1% -c options.json
java %JAVA_OPTS% -Dapis -jar %executable% %ags2% -c options.json
java %JAVA_OPTS% -Dapis -jar %executable% %ags3% -c options.json
