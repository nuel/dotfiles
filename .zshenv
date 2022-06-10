# Load dotfiles
for file in ~/.{aliases,functions,projects}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add brew and port stuff to path
export PATH=/usr/local/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:$PATH

# Set editor
export EDITOR=nano

# motd
autoload colors; colors;
echo $fg[red];
fortune | cowsay -f eyes;
echo $reset_color;
