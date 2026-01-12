alias zc="nvim $HOME/.config/zsh/.zshrc"
alias v="nvim"
vf(){
  fd -t f| fzf | xargs -I {} $EDITOR {}
}

alias snip='cd ~/.local/share/nvim/site/pack/packer/start/friendly-snippets/snippets'

diff_file(){
 find . -type f -name "$1" -print0 | xargs -0 nvim -d
}
