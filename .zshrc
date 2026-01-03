#!/bin/bash

source "$HOME/.config/zsh/secrets.zsh"

# Folder where all the important things are
export VAULT="$HOME/Vault"

export BROWSER="firefox"
export EDITOR="nvim"
export TERM="xterm-256color"
export TERMINAL="ghostty"

export HOMEBREW_NO_AUTO_UPDATE=1

# Prompt
autoload -U colors && colors
export STARSHIP_CONFIG="$HOME/.config/starship/starship.toml"
eval "$(/opt/homebrew/bin/starship init zsh)"

# Load all user configuration recursively from specified folder
user_config_folder="$HOME/.config/zsh/usr"
for c in "$user_config_folder"/*.zsh(N) "$user_config_folder"/**/*.zsh(N); do
    source "$c"
done

# Autocompletion (must be before plugins)
if type brew &>/dev/null; then
    FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"
fi
autoload -Uz compinit && compinit
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z}={A-Za-z}' menu select
zmodload zsh/complist
_comp_options+=(globdots)

# Load all the plugins
plugins_folder="$HOME/.config/zsh/plugins"
plugins=(
    "zsh-autosuggestions/zsh-autosuggestions.zsh"
    "zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
)
for p in "${plugins[@]}"; do
    source "$plugins_folder/${p}"
done


eval "$(zoxide init zsh)"


export BSTINPUTS="$HOME/Library/Application Support/MiKTeX/texmfs/install/bibtex/bst/ieeetran"
export CPLUS_INCLUDE_PATH="/usr/local/Cellar/gcc/11.2.0_3:/Library/Developer/CommandLineTools/SDKs/MacOSX10.15.sdk/usr/include"

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# some useful options (man zshoptions)
setopt  extendedglob nomatch menucomplete
unsetopt autocd
setopt interactive_comments
stty stop undef		# Disable ctrl-s to freeze terminal.
export zle_highlight=('paste:none')

# beeping is annoying
unsetopt BEEP

if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]
then
    export SDKMAN_DIR="$HOME/.sdkman"
    [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
[[ ! -r '/Users/skril/.opam/opam-init/init.zsh' ]] || source '/Users/skril/.opam/opam-init/init.zsh' > /dev/null 2> /dev/null
# END opam configuration
. "/Users/skril/.acme.sh/acme.sh.env"
