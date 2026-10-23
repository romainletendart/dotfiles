Use GNU stow to install:

cd dotfiles
stow bash X git nvim postgresql waybar --target=$HOME
mkdir --parents ~/.config/hypr && stow hypr --target=$HOME

On Debian only:

stow debian --target=$HOME

Auto-start services:

```console
systemctl --user enable hyprpaper.service
systemctl --user enable waybar.service
```
