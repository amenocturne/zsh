alias sdl="pbpaste | xargs -I {} spotdl '{}'"
# alias mdl="pbpaste | xargs -I {} yt-dlp --cookies-from-browser firefox:'~/Library/Application Support/zen/Profiles' --format bestaudio --audio-format mp3 --extract-audio --output '%(playlist_index)s. %(title)s.%(ext)s' '{}'"
alias mdl="pbpaste | xargs -I {} yt-dlp --cookies-from-browser firefox:'~/Library/Application Support/zen/Profiles' -x --audio-format mp3 -o '%(playlist_index)s. %(title)s.%(ext)s' '{}'"

# alias vdl="pbpaste | xargs -I {} yt-dlp --cookies-from-browser firefox:'~/Library/Application Support/zen/Profiles' -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 '{}' -o '%(title)s.%(ext)s' "
# alias vdl="pbpaste | xargs -I {} yt-dlp --cookies-from-browser firefox:'~/Library/Application Support/zen/Profiles' -o '%(title)s.%(ext)s' '{}'"
vdl() {
  local url
  url=$(pbpaste)

  local common_flags=(
    -f "bestvideo+bestaudio"
    --merge-output-format mp4
    --cookies-from-browser "firefox:~/Library/Application Support/zen/Profiles"
    -o '%(title)s.%(ext)s'
  )

  if [[ $# -eq 0 ]]; then
    yt-dlp "${common_flags[@]}" "$url"
  else
    yt-dlp "${common_flags[@]}" --download-sections "*$1" "$url"
  fi
}
