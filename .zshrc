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
# To force rebuild: rm ~/.zcompdump && exec zsh
FPATH="/opt/homebrew/share/zsh/site-functions:${FPATH}"
autoload -Uz compinit
if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
    compinit  # rebuild if older than 24 hours
else
    compinit -C  # use cache
fi
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Lazy load sdkman - only loads when you first run 'sdk'
if [[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]]; then
    export SDKMAN_DIR="$HOME/.sdkman"
    sdk() {
        unfunction sdk
        source "$SDKMAN_DIR/bin/sdkman-init.sh"
        sdk "$@"
    }
fi

# Lazy load opam - only loads when you first run 'opam'
if [[ -r "$HOME/.opam/opam-init/init.zsh" ]]; then
    opam() {
        unfunction opam
        source "$HOME/.opam/opam-init/init.zsh" > /dev/null 2>&1
        opam "$@"
    }
fi

# Lazy load acme.sh - only loads when you first run 'acme.sh'
if [[ -f "$HOME/.acme.sh/acme.sh.env" ]]; then
    acme.sh() {
        unfunction acme.sh
        source "$HOME/.acme.sh/acme.sh.env"
        acme.sh "$@"
    }
fi
