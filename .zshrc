# The following lines were added by compinstall

zstyle ':completion:*' completer _complete _ignored _approximate
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' max-errors 2
zstyle :compinstall filename '/home/nicolas/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
bindkey -e
# End of lines configured by zsh-newuser-install

setopt no_share_history

export PATH=/home/nicolas/bin:$PATH
export EDITOR=nano

if [ -z "$DISPLAY" ] && [ `tty` = /dev/tty1 ]; then
	startx
	exit 0
fi

alias lftpsb='lftp -u drinkcat,slZNNFTmFpgw0rWY helios.feralhosting.com'

