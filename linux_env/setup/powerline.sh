sudo apt-get install fonts-powerline

pip install --user powerline-status
pip install powerline-gitstatus

mkdir ~/.config/powerline/colorschemes
cp ./linux_env/setup/powerline.colorschemes.json ~/.config/powerline/colorschemes/default.json

mkdir ~/.config/powerline/themes/shell
cp ./linux_env/setup/powerline.git-shell.json ~/.config/powerline/themes/shell/default.json
