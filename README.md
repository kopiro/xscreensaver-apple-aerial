# xscreensaver-apple-aerial

Apple TV Aerial screensaver on XScreensaver for Linux, optimized for Raspberry Pi.

It supports all possible video qualities that Apple provides: H264, 1080 (SDR/HDR) and 4K (SDR/HDR); and and upgradable list of the videos.

## Dependencies

```bash
apt install -y vlc jq xscreensaver
```

### Installation

```bash
# Clone this repo
git clone https://github.com/kopiro/xscreensaver-apple-aerial /usr/local/src/xscreensaver-apple-aerial

# Create a link of the main script to the xscreensaver dir
cd /usr/local/src/xscreensaver-apple-aerial
# Change the following target path to /usr/libexec/xscreensaver/apple-aerial for a Debian based system:
ln -svf /usr/local/src/xscreensaver-apple-aerial/main.sh /usr/lib/xscreensaver/apple-aerial
chmod +x /usr/lib/xscreensaver/apple-aerial
```

Add this line `"Apple Aerial" apple-aerial \n\` in the `programs` section in the file `~/.Xscreensaver`

### Initialization and upgrade

In the beginning, and to download the updated list of the videos, just run:

```bash
/usr/lib/xscreensaver/apple-aerial --upgrade
```

### Download videos

The screen-saver will not stream any video; it insteads relies on these files already be on disk.

But don't worry; download them using `/usr/lib/xscreensaver/apple-aerial --download` and let the script finish, or kill it when you think you have enough videos.

To specify the quality of the video downloaded, you can set these 5 options after `--download`; the default is `1080-SDR`.

- 1080-H264
- 1080-HDR
- 1080-SDR
- 4K-SDR
- 4K-HDR

Example: `/usr/lib/xscreensaver/apple-aerial --download 4K-HDR`

## Change quality to downloaded videos

If you want to change quality of your previously downloaded videos, go to `~/.config/apple-aerial`
and delete the folder corresponding to the old quality, then run the script again with the new quality.
