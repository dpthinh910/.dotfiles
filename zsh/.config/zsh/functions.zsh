# Function to source file if they exist
function zsh_add_file() {
  [ -f "$HOME/$1" ] && source "$HOME/$1"
}

function zsh_add_plugin() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
  if [ -d "$HOME/plugins/$PLUGIN_NAME"]; then
    # for plugins
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh" || \
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.zsh"
  else
    git clone "https://github.com/$1.git"
    "$HOME/plugins/$PLUGIN_NAME"
  fi
}

function zsh_add_completion() {
  PLUGIN_NAME=$(echo $1 | cut -d "/" -f 2)
  if [ -d "$HOME/plugins/$PLUGIN_NAME" ]; then
    # For completions
    completion_file_path=$(ls $HOME/plugins/$PLUGIN_NAME/_*)
    fpath+="$(dirname "${completion_file_path}")"
    zsh_add_file "plugins/$PLUGIN_NAME/$PLUGIN_NAME.plugin.zsh"
  else
    git clone "https://github.com/$1.git"
    "$HOME/plugins/$PLUGIN_NAME"
    fpath+=$(ls $HOME/plugins/$PLUGIN_NAME/_*)
    rm $ZDOTDIR/.zccompdump
  fi
    complete_file="$(baseName "${completion_file_path}")"
    if [ "$2" == true ] && compinit "${completion_file:1}"
}