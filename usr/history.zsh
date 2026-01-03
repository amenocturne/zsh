# History
HISTSIZE=50000
SAVEHIST=50000
HISTFILE="$HOME/.config/zsh/history"

setopt INC_APPEND_HISTORY     # Write immediately, not on exit
setopt EXTENDED_HISTORY       # Save timestamps
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_ALL_DUPS   # Remove older duplicate
setopt HIST_IGNORE_SPACE      # Commands starting with space are private
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
