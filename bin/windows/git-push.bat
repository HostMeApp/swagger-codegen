set git_user_id=%1
set git_repo_id=%2
set release_note=%3

git init
git add .
git commit -m %release_note%
git remote add origin https://github.com/%git_user_id%/%git_repo_id%
git remote -v
git pull origin master
git push origin master