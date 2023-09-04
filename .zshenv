# Load dotfiles
for file in ~/.{aliases,functions,projects}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add brew and port stuff to path
export PATH=/usr/local/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:/opt/homebrew/bin:$PATH
export PATH=/Users/nuel/Library/Python/3.9/bin:$PATH

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
