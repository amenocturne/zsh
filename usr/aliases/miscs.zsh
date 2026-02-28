alias ip="curl ifconfig.me"
alias coverformat='find .| ggrep ".jpg" | xargs -I {} convert {} -resize 500x500 "{}"'
alias graveyard="find /tmp/ -type f| ggrep 'graveyard-'"
alias picard="open * -a MusicBrainz\ Picard"

alias python="python3"

# auto refresh image/pdf in preview on MacOs
# usage: command to update file; prefresh
alias prefresh='echo "tell application \"Preview\" to activate\n tell application \"Alacritty\" to activate" | osascript -'

alias kb="cd ~/Vault/Obsidian/Mirror; claude-chill -- claude"
alias dev="cd ~/Vault/Projects; claude-chill -- claude"
