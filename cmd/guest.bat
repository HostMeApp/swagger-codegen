set executable=..\modules\swagger-codegen-cli\target\swagger-codegen-cli.jar

If Not Exist %executable% (
  mvn clean package
)

set swagger_uri=https://hostme-services-qa.azurewebsites.net/swagger/docs/mb
set out_dir=clients
set template_dir=..\modules\swagger-codegen\target\classes
set language=typescript-fetch
set out_dir=clients

set ags1=generate --api-package api --model-package model -i %swagger_uri% -l %language% -o %out_dir%\hostme-sdk-typescript-fetch-mobile

java %JAVA_OPTS% -Dapis -Dmodels -DsupportingFiles -DapiTests=false -DmodelTests=false -jar %executable% %ags1% --additional-properties debugParser=true -c options.json
