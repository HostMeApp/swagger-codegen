cd /d %1
git init
git add .
git commit -m "First commit"
git remote add origin https://github.com/HostMeApp/Sdk.git
git remote -v
git push origin master