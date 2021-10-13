# xscreensaver-apple-aerial

Apple TV Aerial screensaver on XScreensaver for Linux, optimized for Raspberry Pi.

This project is heavily based on [https://github.com/graysky2/xscreensaver-aerial(https://github.com/graysky2/xscreensaver-aerial)]
with some improvements, specifically:

- Run smoother on Raspberry PI devices by using VLC
- Init scripts to download all the videos
- Dynamic list of videos

### Installation of the screen-saver

```
git clone https://github.com/kopiro/xscreensaver-apple-aerial /usr/local/src/xscreensaver-apple-aerial
cd /usr/local/src/xscreensaver-apple-aerial
ln -svf /usr/local/src/xscreensaver-apple-aerial/main.sh /usr/lib/xscreensaver/apple-aerial
chmod +x /usr/lib/xscreensaver/apple-aerial
```

Add this line `"Apple Aerial" apple-aerial \n\` in the `programs` section in the file `~/.Xscreensaver`

### Download videos

The screen-saver will not stream any video; it insteads rely on these files already be on disk.

You can download them using `/usr/lib/xscreensaver/apple-aerial --download` and let the script finish, or kill-it when you think you have enough of them.

Alternatively, also use `--download-night` or `--download-day` to only download specific day/night videos.
