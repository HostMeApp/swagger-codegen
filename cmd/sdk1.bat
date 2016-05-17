set executable=..\modules\swagger-codegen-cli\target\swagger-codegen-cli.jar

If Not Exist %executable% (
  mvn clean package
)

set swagger_uri=%1
set git_repo_url=%2
set release_note=%3
set out_dir=clients

git clone %git_repo_url%/hostme-sdk-angular-mobile %out_dir%/hostme-sdk-angular-mobile
git clone %git_repo_url%/hostme-sdk-angular-web %out_dir%/hostme-sdk-angular-web
git clone %git_repo_url%/hostme-sdk-angular-admin %out_dir%/hostme-sdk-angular-admin
git clone %git_repo_url%/hostme-sdk-csharp %out_dir%/hostme-sdk-csharp


cd /d %out_dir%\hostme-sdk-angular-mobile
git add .
call npm install
call npm run version -- -b %release_note%
git push
git push --tags

cd /d ..\hostme-sdk-angular-web
git add .
call npm install
call npm run version -- -b %release_note%
git push
git push --tags

cd /d ..\hostme-sdk-angular-admin
git add .
call npm install
call npm run version -- -b %release_note%
git push
git push --tags

cd /d ..\hostme-sdk-csharp
git add .
git commit -m %release_note%
git push
git push --tags