# Load dotfiles
for file in ~/.{aliases,functions,projects}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Add brew stuff to path
export PATH=/usr/local/bin:$PATH

# motd
autoload colors; colors;
echo $fg[red];
fortune | cowsay -f eyes;
echo $reset_color;
