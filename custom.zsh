alias vim="nvim"
export EDITOR="nvim"
export LANG=en_US.utf-8

case "$USER" in
  caravan)
     export DATA='~/volume'
     ;;
  *)
     export DATA='~'
     ;;
esac

case `uname` in
  Darwin)
    # commands for OS X go here
       export MAKEFLAGS="-j $(sysctl -n hw.ncpu)"
       export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
  ;;
  Linux)
    # commands for Linux go here
       alias fd=fdfind
       export MAKEFLAGS="-j $(nproc)"
       export FZF_DEFAULT_COMMAND='fdfind --type f --hidden --follow --exclude .git'
       alias cppmake='~/Programs/cppmake/bin/cppmake'
       alias open='gio open'
       export PATH="/usr/lib/ccache:$PATH"
       if [ -d "$HOME/.local/bin" ] ; then
          PATH="$PATH:$HOME/.local/bin"
       fi
       alias idea='/home/j.boettcher/Programs/idea-IC-223.7571.182/bin/idea.sh'
  ;;
  FreeBSD)
    # commands for FreeBSD go here
  ;;
esac
