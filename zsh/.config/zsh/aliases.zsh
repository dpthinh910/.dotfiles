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

# make directory
take() {
  mkdir -p $@ && cd $(@:$#)
}

# cd into whatever is the forefront Finder window
cdf() {
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

# project opener
repo() {
  cd "$(~/.dotfiles/bin/repo $1)"
}
