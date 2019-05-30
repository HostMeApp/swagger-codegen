set executable=%5\modules\swagger-codegen-cli\target\swagger-codegen-cli.jar

If Not Exist %executable% (
  mvn clean package
)

set swagger_uri=%1
set git_repo_url=%2
set release_note=%3
set out_dir=clients
set version=%4

git clone %git_repo_url%/hostme-sdk-angular-mobile %out_dir%/hostme-sdk-angular-mobile
git clone %git_repo_url%/hostme-sdk-angular2-mobile %out_dir%/hostme-sdk-angular2-mobile
git clone %git_repo_url%/hostme-sdk-angular-web %out_dir%/hostme-sdk-angular-web
git clone %git_repo_url%/hostme-sdk-angular-admin %out_dir%/hostme-sdk-angular-admin
git clone %git_repo_url%/hostme-sdk-angular2-admin %out_dir%/hostme-sdk-angular2-admin
git clone %git_repo_url%/hostme-sdk-csharp %out_dir%/hostme-sdk-csharp
git clone %git_repo_url%/hostme-sdk-typescript-fetch-mobile %out_dir%/hostme-sdk-typescript-fetch-mobile

git config user.email "evgeny.popov@gmail.com"
git config user.name "Evgeny"

rmdir /Q /S "%out_dir%/hostme-sdk-angular2-admin/src/model"
rmdir /Q /S "%out_dir%/hostme-sdk-angular2-admin/src/api"
rmdir /Q /S "%out_dir%/hostme-sdk-angular2-mobile/src/model"
rmdir /Q /S "%out_dir%/hostme-sdk-angular2-mobile/src/api"

rmdir /Q /S "%out_dir%/hostme-sdk-angular-mobile/src"
rmdir /Q /S "%out_dir%/hostme-sdk-angular-web/src"
rmdir /Q /S "%out_dir%/hostme-sdk-angular-admin/src"
rmdir /Q /S "%out_dir%/hostme-sdk-csharp/hostme-sdk-csharp-admin/hostme"
rmdir /Q /S "%out_dir%/hostme-sdk-csharp/hostme-sdk-csharp-web/hostme"
rmdir /Q /S "%out_dir%/hostme-sdk-csharp/hostme-sdk-csharp-mobile/hostme"

set template_dir=%5\modules\swagger-codegen\target\classes
set JAVA_OPTS=%JAVA_OPTS% -XX:MaxPermSize=256M -Xmx512M -DloggerPath=conf/log4j.properties

set language=typescript-angular
set ags1=generate --api-package api --model-package model -t %template_dir%\%language% -i %swagger_uri%/mb -l %language% -o %out_dir%\hostme-sdk-angular-mobile
set ags2=generate --api-package api --model-package model -t %template_dir%\%language% -i %swagger_uri%/admin -l %language% -o %out_dir%\hostme-sdk-angular-admin
set ags3=generate --api-package api --model-package model -t %template_dir%\%language% -i %swagger_uri%/web -l %language% -o %out_dir%\hostme-sdk-angular-web

java %JAVA_OPTS% -Dapis -Dmodels -DsupportingFiles -jar %executable% %ags1% -c options.json
java %JAVA_OPTS% -Dapis -Dmodels -DsupportingFiles -jar %executable% %ags2% -c options.json
java %JAVA_OPTS% -Dapis -Dmodels -DsupportingFiles -jar %executable% %ags3% -c options.json

set language=typescript-fetch
set ags1=generate --api-package api --model-package model -t %template_dir%\%language% -i %swagger_uri%/mb -l %language% -o %out_dir%\hostme-sdk-typescript-fetch-mobile

java %JAVA_OPTS% -Dapis -Dmodels -DsupportingFiles -jar %executable% %ags1% -c options.json



set language=typescript-angular2
set ags1=generate --api-package api --model-package model -t %template_dir%\%language% -i %swagger_uri%/mb -l %language% -o %out_dir%\hostme-sdk-angular2-mobile
set ags2=generate --api-package api --model-package model -t %template_dir%\%language% -i %swagger_uri%/admin -l %language% -o %out_dir%\hostme-sdk-angular2-admin
set ags3=generate --api-package api --model-package model -t %template_dir%\%language% -i %swagger_uri%/web -l %language% -o %out_dir%\hostme-sdk-angular2-web

java %JAVA_OPTS% -Dapis -Dmodels -DsupportingFiles -jar %executable% %ags1% -c options.json
java %JAVA_OPTS% -Dapis -Dmodels -DsupportingFiles -jar %executable% %ags2% -c options.json
java %JAVA_OPTS% -Dapis -Dmodels -DsupportingFiles -jar %executable% %ags3% -c options.json

set language=csharp
set ags=generate  --model-package HostMe.Sdk.Models -t %template_dir%\%language% -i %swagger_uri%/all -l %language% -o %out_dir%\hostme-sdk-csharp\hostme-sdk-csharp-models
set ags1=generate --api-package HostMe.Sdk.Apis.Mobile --model-package HostMe.Sdk.Models -t %template_dir%\%language% -i %swagger_uri%/mb -l %language% -o %out_dir%\hostme-sdk-csharp\hostme-sdk-csharp-mobile
set ags2=generate --api-package HostMe.Sdk.Apis.Admin --model-package HostMe.Sdk.Models -t %template_dir%\%language% -i %swagger_uri%/admin -l %language% -o %out_dir%\hostme-sdk-csharp\hostme-sdk-csharp-admin
set ags3=generate --api-package HostMe.Sdk.Apis.Web --model-package HostMe.Sdk.Models -t %template_dir%\%language% -i %swagger_uri%/web -l %language% -o %out_dir%\hostme-sdk-csharp\hostme-sdk-csharp-web

java %JAVA_OPTS% -Dmodels -jar %executable% %ags% -c options.json
java %JAVA_OPTS% -Dapis -jar %executable% %ags1% -c options.json
java %JAVA_OPTS% -Dapis -jar %executable% %ags2% -c options.json
java %JAVA_OPTS% -Dapis -jar %executable% %ags3% -c options.json

cd /d %out_dir%\hostme-sdk-angular-mobile
git config user.email "evgeny.popov@gmail.com"
git config user.name "Evgeny"
git add .
git commit -m %release_note%
git push


cd /d %out_dir%\hostme-sdk-typescript-fetch-mobile
git config user.email "evgeny.popov@gmail.com"
git config user.name "Evgeny"
git add .
git commit -m %release_note%
git push


cd /d ..\hostme-sdk-angular-web
git config user.email "evgeny.popov@gmail.com"
git config user.name "Evgeny"
git add .
git commit -m %release_note%
git push


cd /d ..\hostme-sdk-angular-admin
git config user.email "evgeny.popov@gmail.com"
git config user.name "Evgeny"
git add .
git commit -m %release_note%
git push


cd /d %out_dir%\hostme-sdk-angular2-mobile
git config user.email "evgeny.popov@gmail.com"
git config user.name "Evgeny"
git add .
git commit -m %release_note%
git push


cd /d ..\hostme-sdk-angular2-web
git config user.email "evgeny.popov@gmail.com"
git config user.name "Evgeny"
git add .
git commit -m %release_note%
git push


cd /d ..\hostme-sdk-angular2-admin
git config user.email "evgeny.popov@gmail.com"
git config user.name "Evgeny"
git add .
git commit -m %release_note%
git push

cd /d ..\hostme-sdk-csharp
git config user.email "evgeny.popov@gmail.com"
git config user.name "Evgeny"
git add .
git commit -m %release_note%
git push
