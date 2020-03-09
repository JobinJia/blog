#!/bin/sh
cd ..
pwd
zip -q -r -o public.zip public
scp -i '/Users/jiabinbin/.ssh/root' public.zip root@150.109.111.71:../workspace/blog/
ssh -i '/Users/jiabinbin/.ssh/root' root@150.109.111.71 'cd /workspace/blog/ ; ./deploy.sh'
rm -rf public.zip