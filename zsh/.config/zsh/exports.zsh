export EIDTOR=nvim
export REACT_EDITOR=code
export WORKSPACE_FOLDER=~/workspace
export NVIM_HOME=~/.config/nvim
export TERM=xterm-256color
export FZF_DEFAULT_OPTS="--layout=reverse --height 100%"
export NVM_DIR="$HOME/.nvm"

# Add location of global PATHS
export PATH="$PATH:$HOME/nvim-macos/bin"
export PATH="$PATH:$HOME/.node_modules/bin"
export PATH="$PATH:$HOME/.npm-packages/bin:path"
export PATH="$PATH:$HOME/homebrew/bin"
export PATH="$PATH:$HOME/lib"
export PATH="$PATH:$HOME/nvim-osx64/bin"

# Disable certificate check
export NODE_TLS_REJECT_UNAUTHORIZED=0

#rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"
export PATH="$PATH:$HOME/.rbenv/versions/2.6.5/bin"

# artifactory is on aur, add it to proxy exclusions
export no_proxy=artifactory.ext.national.com.au
export NO_PROXY=artifactory.ext.national.com.au

# Set NAB proxies, not required when on ZScaler VPN
# export HTTPS_PROXY=http://proxy.nab.com.au:10091
# export HTTP_PROXY=http://proxy.nab.com.au:10091
# export no_proxy=localhost, 127.0.0.*,10.*,.thenational.com,.national.com.au,registry.yarnpkg.com,registry.npmjs.org
