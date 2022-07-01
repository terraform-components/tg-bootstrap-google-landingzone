git config --global --add safe.directory /mnt/workspace/source
export old_path=$(pwd)
cd /mnt/workspace/source
git init
cd $old_path
