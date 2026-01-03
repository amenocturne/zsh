# Shell options
setopt extendedglob           # Extended globbing
setopt nomatch                # Error on no glob match
setopt menucomplete           # Cycle through completions
setopt interactive_comments   # Allow comments in interactive shell
unsetopt autocd               # Don't cd into directories by typing name
unsetopt BEEP                 # No beeping

# Input
bindkey -v                    # Vim mode
KEYTIMEOUT=1                  # 10ms delay for ESC (default 400ms)
stty stop undef               # Disable ctrl-s freeze
export zle_highlight=('paste:none')

# History search with up/down arrows
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
