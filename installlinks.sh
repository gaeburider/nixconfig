#!/bin/sh
NIXCONFIGDIR=$HOME"/.nixconfig"

if [ ! "$(readlink ~/.bash_logout)" ]; then
	if [ -f ~/.bash_logout ]; then
		mv ~/.bash_logout ~/.bash_logout_bak
	fi
	ln -s $NIXCONFIGDIR/.bash_logou.t ~/.bash_logout
fi

if [ ! "$(readlink ~/.bash_profile)" ]; then
	if [ -f ~/.bash_profile ]; then
		mv ~/.bash_profile ~/.bash_profile_bak
	fi
	ln -s $NIXCONFIGDIR/.bash_profile ~/.bash_profile
fi

if [ ! "$(readlink ~/.bashrc)" ]; then
	if [ -f ~/.bashrc ]; then
		mv ~/.bashrc ~/.bashrc_bak
	fi
	ln -s $NIXCONFIGDIR/.bashrc ~/.bashrc
fi

if [ ! "$(readlink ~/.zshrc)" ]; then
	if [ -f ~/.zshrc ]; then
		mv ~/.zshrc ~/.zshrc_bak
	fi
	ln -s $NIXCONFIGDIR/.zshrc ~/.zshrc
fi

if [ ! "$(readlink ~/.ackrc)" ]; then
	if [ -f ~/.ackrc ]; then
		mv ~/.ackrc ~/.ackrc_bak
	fi
	ln -s $NIXCONFIGDIR/.ackrc ~/.ackrc
fi

if [ ! "$(readlink ~/.vimrc)" ]; then
	if [ -f ~/.vimrc ]; then
		mv ~/.vimrc ~/.vimrc_bak
	fi
	ln -s $NIXCONFIGDIR/vim/vimrc.vim ~/.vimrc
	# TODO: create folder .config/nvim if not already exists
	mkdir ~/.config/nvim
	ln -s $NIXCONFIGDIR/vim/vimrc.vim ~/.config/nvim/init.vim
fi

if command -v lilyterm > /dev/null 2>&1; then
	if [ -f ~/.config/lilyterm/default.conf ]; then
		mv ~/.config/lilyterm/default.conf ~/.config/lilyterm/default.conf_bak
	fi
	ln -s $NIXCONFIGDIR/.lilytermrc ~/.lilytermrc
	ln -s $NIXCONFIGDIR/.lilytermrc ~/.config/lilyterm/default.conf
fi

if command -v terminator > /dev/null 2>&1; then
	if [ -f ~/.config/terminator/config ]; then
		mv ~/.config/terminator/config ~/.config/terminator/config_bak
	fi
	ln -s $NIXCONFIGDIR/.terminatorrc ~/.terminatorrc
	ln -s $NIXCONFIGDIR/.terminatorrc ~/.config/terminator/config
fi

if command -v i3wm > /dev/null 2>&1 || command -v i3 > /dev/null 2>&1; then
	if [ -f ~/.config/i3/config ]; then
		mv ~/.config/i3/config ~/.config/i3/config_bak
	fi
	ln -s $NIXCONFIGDIR/.i3rc ~/.i3rc
	ln -s $NIXCONFIGDIR/.i3rc ~/.config/i3/config
fi

if command -v curl >/dev/null 2>&1; then
	if [ "$(ls -a ~ | grep \.oh-my-zsh)" ]; then
		echo "oh my zsh seems already to be installed"
	else
		sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
		git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
		curl -o - https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/install.sh | zsh
        ln -s ~/.nixconfig/zshthemes/hug1.zsh-theme ~/.oh-my-zsh/themes/hug1.zsh-theme
        ln -s ~/.nixconfig/zshthemes/hug2.zsh-theme ~/.oh-my-zsh/themes/hug2.zsh-theme
	fi
else
	echo "curl not installed"
fi

#chmod -R 777 $NIXCONFIGDIR/.vim/usrbin/nixbin
#chmod -R 777 $NIXCONFIGDIR/.vim/usrbin/macbin


if [ ! "$(readlink ~/.fonts)" ]; then
	ln -s $NIXCONFIGDIR/.fonts ~/.fonts
fi

