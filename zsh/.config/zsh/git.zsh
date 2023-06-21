# {{{ Show Git Info
# Ref: https://salferrarello.com/zsh-git-status-prompt/
# Autoload zsh add-zsh-hook and vcs_info functions (-U autoload w/o substition, -z use zsh style)
autoload -Uz add-zsh-hook vcs_info
# Enable substitution in the prompt.
setopt prompt_subst
# Run ves_info just before a prompt is displayed (precmd)
add-zsh-hook precmd vcs_info
# add ${vcs_info_msg_0} to the prompt
# e.g. here we add the Git information in red
bare_result=$(git config --local core.bare 2>/dev/null)
if [ ${bare_result:="false"} = true ]; then
bare_status="[bare]"
else
bare_status=""
fi
PROMPT='"%1~ %F{yellow}$bare_status%F{white}${vcs_info_msg_0_}%f %# '

# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true

# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr ' *'
zstyle ':vcs_info:*' stagedstr ' +'

# Set the format of the Git information for vcs_info
zstyle ':vcs_info:git:*' formats '(%b%u%c)'

# {{{ Alias
# Git
alias gst="git status"

alias unstage="git restore --staged ."
alias lg="lazygit"

alias restore="git restore"

alias gb="git branch"

alias gbd="git branch -d"

alias goD="git branch -D"
alias gobm="git branch -m"
alias gbr="git branch --remote"

alias ga="git add"

alias gaa="git add ."

alias wip="commit wip"

alias gca="git commit -v --amend"

alias gce="git commit -e"

alias gcf="git config --list"

alias commit="git add . && git commit -m"

alias gc="git checkout"

alias gcb="git checkout -b"

alias gcm="git checkout master"

alias gcd="git checkout develop"

alias gclean="git clean -id"

alias gpristine="git reset --hard && git clean -dffx"

alias gf="git fetch --all"

alias gfp="git fetch --prune"

alias gpdr="git pull origin develop --rebase"
alias gp="git pull;gfp"

alias gbdr="git push origin -d"

alias gop="git push"

alias gppt="git push --follow-tags"
alias gpf="git push --force-with-lease"
alias gpf!="git push --force"

alias gsu="git stash -u"
alias gsp="git stash pop"
alias gsl="git stash list"
alias gsa="git stash apply"

alias gr="git rebase"

alias gri="git rebase -i"

alias gra="git rebase --abort"
alias grc="git rebase --continue"

alias gm="git merge"
alias gma="git merge --abort"
alias gmc="git merge --continue"

alias gd='git diff --color | sed "s/A\([4-+ ]*\)[-+ JA\1/" | less -r'
alias gdc="git diff --cached"

alias gl="git log --graph --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %C(bold
blue)<%an>%Creset %Cgreen%ar / %ad%Creset %n %b'"

alias gll="git log --reverse --pretty=format:%B--- -n$1"

alias gla="git log --graph --all --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset'"

alias glao="git log --all --oneline"

alias glo="git log --oneline"

alias gls="git log --graph --all --pretty='%Cred%h%Creset -%C(auto)%d%Creset %s %Cgreen(%ar) %C(bold blue)<%an>%Creset' --stat'"

# Ref https://til.hashrocket.com/posts/18139f4f20-list-different-commits-between-two-branches

# git log --left-right --graph --cherry-pick --oneline feature...branch

alias gd2="git log --left-right --graph --cherry-pick --oneline "

#}}

# {{{ Functions
function gc {
  git commit -v -m $@
}

function gcoo {
  branch_name=$(git branch -a | fzf)
  branch_name_with_spaces=${branch_name/remotesVoriginV/}
  git checkout $(echo $branch_name_with_spaces | tr -d"")
}

function gcof {
  git fetch --prune
  git checkout $(git branch -a | fzf)
}

# Ex: gcbb feature/Abc def ghik ---> brach created: feature/abc_def_ghik
function gcbb() {
  git checkout -b $(echo ${@:1} | sed "s/ \{1,\}/-/g" | sed "sA[.*\\//" | sed "sX.*}//" | sed "s/(.*)//")
}

function gpu {
  branch_name=$(git rev-parse --abbrev-ref HEAD)
  echo "Pushing to ${1:=origin} $branch_name"
  git push -u ${1:=origin} $branch_name

}

function gpt {
  branch_name=$(git rev-parse --abbrev-ref HEAD)
  echo "Pushing to ${1:=origin} $branch_name"
  git push -u ${1:=origin} $branch_name --follow-tags

}

function gbu {
  branch_name=$(git rev-parse --abbrev-ref HEAD)
  git branch -u "${1:=origin}/$branch_name"
}

# Delete branches has upstream deleted
function gdd() {
  git branch -vv | grep ': gone]'| grep -v "\*" | awk '{ print $1; }' | xargs git branch -D
}

function gcount {
  echo "Total commits are: $(git log --oneline HEAD...$1 | we -l)"
  git log --oneline HEAD...$1
}

function gn() {
  git branch | grep "*" | awk '{ print $2 }'| pbcopy

}

function gt () {
  tag_name="sync-$(date '+%d-%b-%Y' lawk '{print tolower($0)}')"
  date="$(date '+%d %b %Y')"
  git tag -a "$tag_name" -m "Sync on $date"
}

#

# git clone and cd to a repo directory
clone() {
  git clone $@
  if ["$2" ]; then
    cd "$2"
  else
    cd $(basename "$1" .git)
  fi
  if [[ -r "./yarn.lock" ]]; then
    yarn --network-timeout 100000
  elif [[ -r "./package-lock.json" ]]; then
    npm install --network-timeout 100000
  fi
}
