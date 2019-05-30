set executable=..\modules\swagger-codegen-cli\target\swagger-codegen-cli.jar

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

set template_dir=..\modules\swagger-codegen\target\classes
set JAVA_OPTS=%JAVA_OPTS% -XX:MaxPermSize=256M -Xmx512M -DloggerPath=conf/log4j.properties

set language=typescript-fetch
set ags1=generate --api-package api --model-package model -t %template_dir%\%language% -i %swagger_uri%/mb -l %language% -o %out_dir%\hostme-sdk-typescript-fetch-mobile

java %JAVA_OPTS% -Dapis -Dmodels -DsupportingFiles -DapiTests=false -DmodelTests=false -jar %executable% %ags1% --additional-properties debugParser=true -c ../cmd/options.json

cd /d %out_dir%\hostme-sdk-typescript-fetch-mobile
git config user.email "evgeny.popov@gmail.com"
git config user.name "Evgeny"
git add .
git commit -m %release_note%
git push

