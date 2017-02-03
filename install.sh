cd ~/vimrc
cp -f ~/vimrc/.vimrc ~/
cp -rf ~/vimrc/.vim ~/

# Install Vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Install Spacegray theme
git clone git://github.com/ajh17/Spacegray.vim.git ~/.vim/bundle/Spacegray
cp -f ~/.vim/bundle/Spacegray/colors/spacegray.vim ~/.vim/colors/
rm -rf ~/.vim/bundle/Spacegray

echo "Installed vimrc successfully. Open vim and execute :PluginInstall in command mode"

