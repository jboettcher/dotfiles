alias vim="nvim"
export EDITOR="nvim"
export LC_ALL=C.UTF-8 # for Hyper tests to work
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
       export LINKER=lld

       if [ -d "$HOME/.local/bin" ] ; then
          PATH="$PATH:$HOME/.local/bin"
       fi
       alias idea='/home/j.boettcher/Programs/idea-IC-223.7571.182/bin/idea.sh'
       export ASAN_OPTIONS=detect_container_overflow=0
  ;;
  FreeBSD)
    # commands for FreeBSD go here
  ;;
esac

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# CTRL-O: find bazel target with fzf
__target_sel() {
  local cmd="./bzl.py query '//...' 2> /dev/null"
  setopt localoptions pipefail no_aliases 2> /dev/null
  local item
  eval "$cmd" | FZF_DEFAULT_OPTS="--height ${FZF_TMUX_HEIGHT:-40%} --reverse --bind=ctrl-z:ignore $FZF_DEFAULT_OPTS $FZF_CTRL_T_OPTS" $(__fzfcmd) -m "$@" | while read item; do
    echo -n "${(q)item} "
  done
  local ret=$?
  echo
  return $ret
}
fzf-bazel-widget() {
  LBUFFER="${LBUFFER}$(__target_sel)"
  local ret=$?
  zle reset-prompt
  return $ret
}
zle     -N   fzf-bazel-widget
bindkey '^o' fzf-bazel-widget
