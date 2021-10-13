#!/bin/bash

[[ $EUID -eq 0 ]] && {
  echo "Do not run this helper as the root user, please."
  exit 1
}

[[ -z "$XDG_CONFIG_HOME" ]] && XDG_CONFIG_HOME="$HOME/.config"
STORAGE_DIR="$XDG_CONFIG_HOME/apple-aerial"
entries_db="$STORAGE_DIR/entries.json"

upgrade() {
  mkdir -p "$STORAGE_DIR"
  pushd "$STORAGE_DIR" || exit 1
  wget --no-check-certificate "https://sylvan.apple.com/Aerials/resources.tar" -O "./resources.tar"
  tar -xf ./resources.tar
  rm ./resources.tar
  rm -rf ./TVIdleScreenStrings.bundle
  popd || exit 1
}

download() {
  url="$1"
  quality="$2"
  name=$(basename "$url")
  output_dir="$STORAGE_DIR/$quality"
  mkdir -p "$output_dir"
  output_file="$output_dir/$name"

  echo "Downloading video in quality $quality from $url"
  wget --no-clobber --no-check-certificate "$url" -O "$output_file" || rm "$output_file"
}


# PRAGMA BOOT

if [ "$1" == "--upgrade" ]; then
  upgrade
  echo "Done!"
  exit 0
fi

[ ! -f "$entries_db" ] && {
  echo "Please run $0 --upgrade before running anything else"
  exit 1
}

if [ "$1" == "--download" ]; then
  quality="1080-SDR"
  [ -n "$2" ] && quality="$2"
  for v in $(cat "$entries_db" | jq -r ".assets[] | .\"url-$quality\"" | shuf); do
    download "$v" "$quality"
  done
  echo "Done!"
  exit 0
fi

IFS=$'\n'
trap : SIGTERM SIGINT SIGHUP
while (true)
do
  video=$(find "$STORAGE_DIR/" -type f -name "*.mov" | shuf | head -n 1)
  if [ -z "$video" ]; then
    echo "You haven't downloaded any file, please run this script with --download first"
    exit 1
  fi

  echo "Playing $video"
  cvlc \
    --play-and-exit \
    --fullscreen \
    --no-audio \
    --no-osd \
    --drawable-xid "$XSCREENSAVER_WINDOW" \
    "$video" &

  pid=$!
  wait $pid

  [ $? -gt 128 ] && { 
    kill $pid
    exit 128
  }
done
