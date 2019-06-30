## TODO:
* [ ] Automating Saving and Loading layouts using i3-layout-manager
* [ ] Layouts for Latex, Mpv-Ytdl-Jupyter
* [ ] Mod+Shift+Enter to launch terminal in `$PWD` directory
* [ ] Refresh/reset all terminal instances in current workspace

## Useful snippets / codes
* youtube-dl
    - to download playlist bestvideo + bestaudio:
        ```sh
            youtube-dl -f bestvideo+bestaudio -i "PLZbbT5o_s2xoWNVdDudn51XM8lOuZ_Njv"
        ```
    - to download only playlist info
        ```sh
            youtube-dl -i --get-filename --skip-download "PLZbbT5o_s2xoWNVdDudn51XM8lOuZ_Njv" >> courselist.md
        ```
    - configure names of saved videos
        ```sh
            youtube-dl -o "%(playlist_index)s-%(title)s.%(ext)s" <playlist_link>
        ```

## Setup details:
* vim-plug:
    curl -fLo ~/.config/nvim/autoload/plug.vim  --create-dirs \
                https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
* Touchpad [Source](https://cravencode.com/post/essentials/enable-tap-to-click-in-i3wm):
    ```
    Section "InputClass"
        Identifier "touchpad"
        MatchIsTouchpad "on"
        Driver "libinput"
        Option "Tapping" "on"
        Option "TappingButtonMap" "lrm"
        Option "NaturalScrolling" "on"
        Option "ScrollMethod" "twofinger"
    EndSection
    # paste in /etc/X11/xorg.conf.d/90-touchpad.conf
    ```

* Backup for bare-repository:
    - Create alias:
        ```
        alias baredot="git --git-dir=$HOME/mydotfiles --work-tree=$HOME"
        ```
	- Checkout + Backup:
        ```
		baredot checkout 2>&1 | egrep "\s+\." | awk "{print $1}" | xargs -I{} mv {} {}.bak
        ```
* Install packages given in [required-after-install.md](mydotfiles/required-after-install.md)
