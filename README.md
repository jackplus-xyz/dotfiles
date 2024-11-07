# dotfiles

My personal collection of dotfiles for macOS with automatic dark mode update across terminal applications.

> [!WARNING]
> These dotfiles are tailored to my specific workflow and setup. Before using these files, review each script carefully and proceed at your own risk. Some configurations may not be compatible with other systems or setups, and unintended side effects are possible.

## Requirements

- **OS:** macOS (developed on macOS Sequoia 15.1)
- **Shells Supported:** Zsh
- **Dependencies:** Some features rely on third-party tools (e.g., [bouk/dark-mode-notify](https://github.com/bouk/dark-mode-notify) for automatic dark mode switching)
- Neovim >= 0.9.0
- Git >= 2.19.0

## Installation

> [!WARNING]
> Before installing, user should review the code and use at their own risk.

### Install with `install.sh`

```sh
git clone https://github.com/jackplus-xyz/dotfiles.git ~/.config
cd ~/.config/dotfiles
chmod +x install.sh
./install.sh
```

The `install.sh` will create symbolic links of all the applications in `~/.config/dotfiles/.config`.
If a symbolic link already exists, it will create a backup in `~/.config/dotfiles_backup`.

### Manual Setup

To install selectively:

Clone the repo and copy only the configurations you need into the corresponding system directories.

## Automatic dark mode on MacOS

Inspired and adapted the `fish` script to `zsh` from [Automatic dark mode for terminal applications](https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/)

Requirements:

- [bouk/dark-mode-notify: Run a script whenever dark mode changes in macOS](https://github.com/bouk/dark-mode-notify)

### Dark Mode Notify

1. Compile the program:
   Follow the instructions on the [bouk/dark-mode-notify](https://github.com/bouk/dark-mode-notify) or `cd ~/.config/dotfiles/scripts/dark-mode-notify && make install`
1. Setup background agent:
1. Create the following file at `~/Library/LaunchAgents/ke.bou.dark-mode-notify.plist`

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
   "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
   <key>Label</key>
   <string>ke.bou.dark-mode-notify</string>
   <key>KeepAlive</key>
   <true/>
   <key>StandardErrorPath</key>
   <string>----Path to a location----/dark-mode-notify-stderr.log</string>
   <key>StandardOutPath</key>
   <string>----Path to a location----/dark-mode-notify-stdout.log</string>
   <key>ProgramArguments</key>
   <array>
       <string>/usr/local/bin/dark-mode-notify</string>
       <string>--- Path to your script ---</string>
   </array>
   </dict>
   </plist>
   ```

   > [!Note]
   > Make sure to change the path accordingly
   > The script path will be: `$HOME/.config/dotfiles/scripts/theme_sync.sh`

1. Run `launchctl load -w ~/Library/LaunchAgents/ke.bou.dark-mode-notify.plist` to keep it running on boot.

### `theme_sync.sh`

This script adjusts theme settings for various applications based on macOS dark mode status. If necessary, it restarts or reloads applications for the changes to take effect.

## Miscs

### Alacritty

Issues:

1.  `Control + /` triggers the system alert sound on macOS

    **Solutions**:

    1. [Change the `DefaultKeyBind.dict`](https://github.com/alacritty/alacritty/issues/3014#issuecomment-1659329460)

       1. Create a file `~/Library/KeyBindings/DefaultKeyBinding.dict` if it doesn't exist yet
       2. Add the snippet below into `DefaultKeyBinding.dict`

          ```dict
          {
            "^/" = "noop:";
          }
          ```

    1. [Remap the key](https://github.com/alacritty/alacritty/issues/7608#issuecomment-1975006973)(Didn't work for me.)

       ```toml
       bindings = [
       { key = "Slash", mods = "Control", chars = "\u001f" },
       ]
       ```

## Credits

### dotfiles

Awesome dotfiles that inspire my current config.

- [FelixKratz/dotfiles: My personal macOS configuration](https://github.com/FelixKratz/dotfiles)
- [craftzdog/dotfiles-public: My personal dotfiles](https://github.com/craftzdog/dotfiles-public)

### Related

The tools used in my config.

- [bouk/dark-mode-notify: Run a script whenever dark mode changes in macOS](https://github.com/bouk/dark-mode-notify)
- [nikitabobko/AeroSpace: AeroSpace is an i3-like tiling window manager for macOS](https://github.com/nikitabobko/AeroSpace)
- [alacritty/alacritty: A cross-platform, OpenGL terminal emulator.](https://github.com/alacritty/alacritty)
- [sharkdp/bat: A cat(1) clone with wings.](https://github.com/sharkdp/bat)
- [FelixKratz/JankyBorders: A lightweight window border system for macOS](https://github.com/FelixKratz/JankyBorders)
- [FelixKratz/SketchyBar: A highly customizable macOS status bar replacement](https://github.com/FelixKratz/SketchyBar)
- [aristocratos/btop: A monitor of resources](https://github.com/aristocratos/btop)
- [pqrs-org/Karabiner-Elements: Karabiner-Elements is a powerful utility for keyboard customization on macOS Sierra (10.12) or later.](https://github.com/pqrs-org/Karabiner-Elements)
- [kovidgoyal/kitty: Cross-platform, fast, feature-rich, GPU based terminal](https://github.com/kovidgoyal/kitty)
- [sxyazi/yazi: 💥 Blazing fast terminal file manager written in Rust, based on async I/O.](https://github.com/sxyazi/yazi)
- [ajeetdsouza/zoxide: A smarter cd command. Supports all major shells.](https://github.com/ajeetdsouza/zoxide)
- [tmux/tmux: tmux source code](https://github.com/tmux/tmux)
- Zsh:

  - [zimfw/zimfw: Zim: Modular, customizable, and blazing fast Zsh framework](https://github.com/zimfw/zimfw)
  - [romkatv/powerlevel10k: A Zsh theme](https://github.com/romkatv/powerlevel10k)

- NeoVim:
  - [neovim/neovim: Vim-fork focused on extensibility and usability](https://github.com/neovim/neovim)
  - [LazyVim/LazyVim: Neovim config for the lazy](https://github.com/LazyVim/LazyVim)

#### Readings

- [Automatic dark mode for terminal applications](https://arslan.io/2021/02/15/automatic-dark-mode-for-terminal-applications/)
- [LazyVim for Ambitious Developers](https://lazyvim-ambitious-devs.phillips.codes/)

## License

This repository is licensed under the MIT License. You are free to use, modify, and distribute these dotfiles, provided the original attribution is retained.
