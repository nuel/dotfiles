# Load dotfiles
for file in ~/.{aliases,functions,projects}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add brew and port stuff to path
export PATH=/usr/local/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:/opt/homebrew/bin:$PATH

# Set editor
export EDITOR=nano

# motd
autoload colors; colors;
echo $fg[red];
fortune | cowsay -f eyes;
echo $reset_color;

# history
setopt APPEND_HISTORY
SAVEHIST=1000
HISTFILE=~/.zsh_history

# bun
export BUN_INSTALL="$HOME/.bun" 
export PATH="$BUN_INSTALL/bin:$PATH" 
[ -s "/Users/nuel/.bun/_bun" ] && source "/Users/nuel/.bun/_bun"
