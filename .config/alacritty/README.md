# Alacritty Config

## Issues

1.  Auto switch to dark mode when the system is in dark mode

    Solution:

    1.  Add the following to `~/.config/alacritty/alacritty.toml`

        ```toml
        import = ["~/.config/alacritty/active_theme.toml"]

        [env]
        ALACRITTY = "true"
        ```

    2.  Add the following to `~/.zshrc`

        ```zsh

          if [ "$ALACRITTY" = "true" ]
          then
            local ALA_HOME=$HOME/.config/alacritty
            local light_theme="github_light"
            local dark_theme="base16-tomorrow-night-256"

            local system_appearance=$(defaults read -g AppleInterfaceStyle 2>/dev/null || echo "Light")
            local ALA_THEME=$(echo $system_appearance | tr '[:upper:]' '[:lower:]')

            if [ "$ALA_THEME" = "dark" ]; then
              local active_theme=$dark_theme
            else
              local active_theme=$light_theme
            fi

            ln -sf $ALA_HOME/themes/themes/${active_theme}.toml $ALA_HOME/active_theme.toml

            touch $ALA_HOME/alacritty.toml
          fi
        ```

1.  `Control + /` triggers the system alert sound on macOS

    Solutions:

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

```

```
