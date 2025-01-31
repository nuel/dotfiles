# Add brew, port & composer stuff to path
export PATH=/usr/local/bin:$PATH
export PATH=/opt/local/bin:/opt/local/sbin:/opt/homebrew/bin:$PATH
export PATH=$HOME/.composer/vendor/bin:$PATH

# motd
autoload colors; colors;
echo $fg[red];
fortune | cowsay -f eyes;
echo $reset_color;
