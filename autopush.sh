echo "\n==========GIT STATUS==========\n"
git status
echo "\n==========GIT ADD=============\n"
git add .
echo "\n==========GIT COMMIT==========\n"
git commit -m "[autopush] $1"
echo "\n==========GIT PUSH============\n"
git push