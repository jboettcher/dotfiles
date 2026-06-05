alias vim="nvim"
export EDITOR="nvim"
#export LC_ALL=C # for Hyper tests to work
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
       if [ -d "$HOME/bin" ] ; then
          PATH="$PATH:$HOME/bin"
       fi
       if [ -d "$HOME/.local/bin" ] ; then
          PATH="~/.local/bin:$PATH"
       fi
       alias clangd-18="/opt/homebrew/opt/llvm/bin/clangd"
       alias fc="falcon login && falcon context import cdp-hyperdb && falcon context apply cdp_hyperdb026_test1_uswest2_cdp001 && falcon credentials request --duration=31d --major-reason=Demo --details=Demo && falcon credentials config --role=PCSKDeveloperRole && falcon kube config && kubectl config set-context --current --namespace=cdp && cd /tmp/byoh/test1-cdp001 && python3 ~/hyper-devtools/connect-to-falcon/fetch_certs.py cdp-control cdp && falcon context apply cdp_hyperdb016_dev1_uswest2_cdp001 && falcon credentials request --duration=31d --major-reason=Demo --details=Demo && falcon credentials config --role=PCSKDeveloperRole && falcon kube config && kubectl config set-context --current --namespace=cdp && cd /tmp/byoh/dev1-cdp001 && python3 ~/hyper-devtools/connect-to-falcon/fetch_certs.py cdp-control cdp && falcon context apply cdp_hyperdb031_dev1_uswest2_cdp002 && falcon credentials request --duration=31d --major-reason=Demo --details=Demo && falcon credentials config --role=PCSKDeveloperRole && falcon kube config && kubectl config set-context --current --namespace=cdp && cd /tmp/byoh/dev1-cdp002 && python3 ~/hyper-devtools/connect-to-falcon/fetch_certs.py cdp-control cdp && falcon context apply cdp_hyperdb099_perf2_uswest2_cdp1 && falcon credentials request --duration=31d --major-reason=Demo --details=Demo && falcon credentials config --role=PCSKDeveloperRole && falcon kube config && kubectl config set-context --current --namespace=cdp && cd /tmp/byoh/perf2-cdp1 && python3 ~/hyper-devtools/connect-to-falcon/fetch_certs.py cdp-control cdp && falcon context apply cdp_hyperdb1_test1_uswest2_cdp002 && falcon credentials request --duration=31d --major-reason=Demo --details=Demo && falcon credentials config --role=PCSKDeveloperRole && falcon kube config && kubectl config set-context --current --namespace=cdp && cd /tmp/byoh/test1-cdp002 && python3 ~/hyper-devtools/connect-to-falcon/fetch_certs.py cdp-control cdp"

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
       if [ -d "$HOME/bin" ] ; then
         PATH="$PATH:$HOME/bin"
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

re() {
     ./bzl.py --quiet run scripts/review -- "$@"
}
