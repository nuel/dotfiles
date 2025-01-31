# Load dotfiles
for file in ~/.{aliases,functions,projects}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Set editor
export EDITOR=nano

# history
setopt APPEND_HISTORY
SAVEHIST=1000
HISTFILE=~/.zsh_history

# bun
export BUN_INSTALL="$HOME/.bun" 
export PATH="$BUN_INSTALL/bin:$PATH" 
[ -s "/Users/nuel/.bun/_bun" ] && source "/Users/nuel/.bun/_bun"
