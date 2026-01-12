# Download subtitles from clipboard URL and copy to clipboard (no persistent files)
ytsub() {
  if [[ "$1" == "-h" || "$1" == "--help" ]]; then
    echo "Usage: ytsub [--no-cookies]"
    echo ""
    echo "Download YouTube subtitles from clipboard URL and copy to clipboard."
    echo ""
    echo "Options:"
    echo "  --no-cookies  Skip browser cookies (use for public videos)"
    echo "  -h, --help    Show this help"
    echo ""
    echo "Example:"
    echo "  # Copy a YouTube URL, then run:"
    echo "  ytsub"
    echo "  ytsub --no-cookies"
    return 0
  fi

  local tmpdir=$(mktemp -d)
  local url=$(pbpaste)
  local cookie_opts=()

  if [[ "$1" != "--no-cookies" ]]; then
    cookie_opts=(--cookies-from-browser "firefox:$HOME/Library/Application Support/zen/Profiles")
  fi

  yt-dlp --skip-download --write-auto-sub --write-sub --sub-lang en \
    "${cookie_opts[@]}" -o "$tmpdir/sub" "$url"

  local files=("$tmpdir"/sub.*(N))
  if (( ${#files[@]} )); then
    cat "${files[@]}" | pbcopy
    echo "Subtitles copied to clipboard"
  else
    echo "No subtitles found"
    [[ "$1" != "--no-cookies" ]] && echo "Tip: try 'ytsub --no-cookies' if rate limited"
  fi
  rm -rf "$tmpdir"
}

alias sdl="pbpaste | xargs -I {} spotdl '{}'"
# alias mdl="pbpaste | xargs -I {} yt-dlp --cookies-from-browser firefox:'~/Library/Application Support/zen/Profiles' --format bestaudio --audio-format mp3 --extract-audio --output '%(playlist_index)s. %(title)s.%(ext)s' '{}'"
alias mdl="pbpaste | xargs -I {} yt-dlp --cookies-from-browser firefox:'~/Library/Application Support/zen/Profiles' -x --audio-format mp3 -o '%(playlist_index)s. %(title)s.%(ext)s' '{}'"

# alias vdl="pbpaste | xargs -I {} yt-dlp --cookies-from-browser firefox:'~/Library/Application Support/zen/Profiles' -f 'bestvideo[ext=mp4]+bestaudio[ext=m4a]/bestvideo+bestaudio' --merge-output-format mp4 '{}' -o '%(title)s.%(ext)s' "
# alias vdl="pbpaste | xargs -I {} yt-dlp --cookies-from-browser firefox:'~/Library/Application Support/zen/Profiles' -o '%(title)s.%(ext)s' '{}'"
vdl() {
  local url
  url=$(pbpaste)

  local common_flags=(
    # Prefer H.264/AAC when available, fallback to best quality
    -f "bv[vcodec^=avc1]+ba[acodec^=mp4a]/bv*+ba/b"
    --merge-output-format mp4
    # Re-encode to H.264/AAC if source has incompatible codecs (VP9/Opus)
    --recode-video mp4
    --postprocessor-args "VideoConvertor:-c:v libx264 -crf 18 -preset medium -c:a aac -b:a 192k"
    --cookies-from-browser "firefox:~/Library/Application Support/zen/Profiles"
    -o '%(title)s.%(ext)s'
  )

  if [[ $# -eq 0 ]]; then
    yt-dlp "${common_flags[@]}" "$url"
  else
    yt-dlp "${common_flags[@]}" --download-sections "*$1" "$url"
  fi
}
