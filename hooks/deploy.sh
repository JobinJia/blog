#!/bin/sh
cd ..
rm -rf public/
yarn build
pwd
zip -q -r -o public.zip public
scp -i '/Users/jiabinbin/.ssh/root' public.zip root@150.109.111.71:../workspace/blog/
ssh -i '/Users/jiabinbin/.ssh/root' root@150.109.111.71 'cd /workspace/blog/ ; ./deploy.sh'
rm -rf public.zip
git status
git add .
git status
git commit -m 'update blog'
git push origin master
echo 'task finished'