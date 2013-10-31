#!/bin/bash -e

pushd $HOME

### Clone Homeshick ###
if [ ! -d "$HOME/.homesick/repos/homeshick" ]; then
	git clone git://github.com/andsens/homeshick.git $HOME/.homesick/repos/homeshick
	$HOME/.homesick/repos/homeshick/bin/homeshick link
fi
homesick="$HOME/.homeshick"

### Clone my dotfiles repo ###
#$homesick clone git://github.com/nastevens/dotfiles.git

### Backup existing files ###
test -e symlink-backup || mkdir symlink-backup
mv .bashrc symlink-backup 2>&1 >/dev/null || true 
mv .profile symlink-backup 2>&1 >/dev/null || true
mv .vimrc symlink-backup 2>&1 >/dev/null || true
mv .vim symlink-backup 2>&1 >/dev/null || true
# mv .ssh symlink-backup/
# mv .bashrc symlink-backup/ || true
# mv .profile symlink-backup/ || true

### Pathogen is special - it links to Vim autoload folder ###
cd $HOME/.homesick/repos/dotfiles/home
if [ ! -d ../../vim-pathogen ]; then
	echo "Cloning pathogen"
	$homesick clone git://github.com/tpope/vim-pathogen.git
	ln -s ../../../../vim-pathogen/autoload/pathogen.vim .vim/autoload/pathogen.vim
fi

### Clone and link vim plugins ###
vimplugins=(
	bkad/CamelCaseMotion
	paradigm/TextObjectify
	scrooloose/nerdcommenter
	Lokaltog/vim-easymotion
	tfnico/vim-gradle
	michaeljsmith/vim-indent-object
	krisajenkins/vim-pipe
	natw/vim-pythontextobj
	derekwyatt/vim-scala
	mhinz/vim-startify
	tpope/vim-dispatch
	dagwieers/asciidoc-vim
	dantler/vim-alternate
	corntrace/bufexplorer
	tpope/vim-surround
	vim-scripts/CRefVim
	vim-scripts/argtextobj.vim
	vim-scripts/ebnf.vim
	vim-scripts/vimwiki
	vim-scripts/visSum.vim
)

for plugin in "${vimplugins[@]}"; do
	package=`expr $plugin : '.*\(/.*\)' | cut -c 2-`
	echo "Cloning $plugin ($package)"
	$homesick clone git://github.com/${plugin}.git
	ln -s ../../../../$package .vim/bundle/$package
done

### Initialize dotfiles ###
echo "Create symlinks"
$homesick symlink dotfiles

popd
