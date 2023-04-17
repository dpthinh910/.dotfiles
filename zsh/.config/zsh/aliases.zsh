# navigation between folders
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../../"
alias -- -="cd -"

# directories
alias dot="cd ~/.dotfiles"
alias lib="cd ~/Library"
alias w="cd ~/workspace"
alias dt="cd ~/Desktop"
alias doc="cd ~/Documents"
alias dev="cd ~/Developer"

# open code editor
alias c="code"
alias cc="code ."

# list folder with color
alias ls="ls -G"
alias ll="ls -a"
alias la="ls -la"
alias l="la"

alias zshrc="nvim ~/.zshrc"
alias nvimrc="nvim ~/.config/nvim"
alias j='z'
alias f='zi'

# update .zshrc file
alias sz="source ~/.zshrc && echo \"Sourced.\""

# colorize grep output (good for log files)
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# confirm before overwriting something
alias cp="cp -i"
alias rm="rm -i"
alias mv="mv -i"

alias mk="mkdir -vp"
alias cl="clear"
alias cls="clear"
alias x="exit 0"

alias ys="yarn run start"
alias yb="yarn run build"
alias yi="CYPRESS_INSTALL_BINARY=0 yarn"
alias yt="yarn run test"

alias -- +x="chmod +x"
alias o="open"
alias oo="open ."
alias e="$EDITOR"

# download file via curl
alias get="curl -O -L"

# run npm silent without noise
alias nr="npm run --silent"

# jest watch
alias jw="npx jest --watch"

# take functions

# mkcd is equivalent to takedir
function mkcd takedir() {
  mkdir -p $@ && cd ${@:$#}
}

function takeurl() {
  local data thedir
  data="$(mktemp)"
  curl -L "$1" > "$data"
  tar xf "$data"
  thedir="$(tar tf "$data" | head -n 1)"
  rm "$data"
  cd "$thedir"
}

function takegit() {
  git clone "$1"
  cd "$(basename ${1%%.git})"
}

function take() {
  if [[ $1 =~ ^(https?|ftp).*\.(tar\.(gz|bz2|xz)|tgz)$ ]]; then
    takeurl "$1"
  elif [[ $1 =~ ^([A-Za-z0-9]\+@|https?|git|ssh|ftps?|rsync).*\.git/?$ ]]; then
    takegit "$1"
  else
    takedir "$@"
  fi
}

# cd into whatever is the forefront Finder window
cdf() {
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

# project opener
repo() {
  cd "$(~/.dotfiles/bin/repo $1)"
}
