set executable=..\..\modules\swagger-codegen-cli\target\swagger-codegen-cli.jar

If Not Exist %executable% (
  mvn clean package
)

REM set JAVA_OPTS=%JAVA_OPTS% -Xmx1024M
set ags=generate -i modules\swagger-codegen\src\test\resources\2_0\petstore.json -l typescript-angular -o samples\client\petstore\typescript-angular

java %JAVA_OPTS% -Dmodels -DsupportingFiles -jar %executable% %ags%
java %JAVA_OPTS% -Dapis -jar %executable% %ags%