#!/bin/zsh
# Require: https://github.com/bouk/dark-mode-notify
# Synchronizes themes across applications based on system appearance (light or dark mode).

# Define paths and themes for easy modification
ALA_HOME="${ALA_HOME:-$HOME/.config/alacritty}"
BAT_HOME="${BAT_HOME:-$HOME/.config/bat}"
BORDERS_HOME="${BORDERS_HOME:-$HOME/.config/borders}"
BTOP_HOME="${BTOP_HOME:-$HOME/.config/btop}"
KITTY_HOME="${KITTY_HOME:-$HOME/.config/kitty}"
NVIM_HOME="${NVIM_HOME:-$HOME/.config/nvim}"
SBAR_HOME="${SBAR_HOME:-$HOME/.config/sketchybar}"
YAZI_HOME="${YAZI_HOME:-$HOME/.config/yazi}"

alacritty_light_theme="base16-tomorrow"
alacritty_dark_theme="base16-default-dark"
bat_light_theme="OneHalfLight"
bat_dark_theme="OneHalfDark"
btop_light_theme="whiteout"
btop_dark_theme="TTY"
kitty_light_theme="base16-tomorrow-256"
kitty_dark_theme="base16-default-dark-256"
yazi_light_theme="latte"
yazi_dark_theme="mocha"
borders_active_color_light="0xff4170AE"
borders_active_color_dark="0xff7cafc2"

# Function to set the Alacritty theme
set_alacritty_theme() {
  local mode="$1"
  local theme_file="$ALA_HOME/themes/${alacritty_light_theme}.toml"
  [[ "$mode" == "dark" ]] && theme_file="$ALA_HOME/themes/${alacritty_dark_theme}.toml"

  ln -sf "$theme_file" "$ALA_HOME/theme.toml" && touch "$ALA_HOME/alacritty.toml"
}

# Function to set the Bat theme
set_bat_theme() {
  local mode="$1"
  local theme="$bat_light_theme"
  [[ "$mode" == "dark" ]] && theme="$bat_dark_theme"

  echo "--theme=$theme" >"$BAT_HOME/config"
}

# Function to set the border color
set_border_color() {
  local mode="$1"
  local active_color="$borders_active_color_light"
  [[ "$mode" == "dark" ]] && active_color="$borders_active_color_dark"

  /opt/homebrew/bin/borders active_color=$active_color
}

# Function to set the Btop theme
set_btop_theme() {
  local mode="$1"
  local theme="$btop_light_theme"
  [[ "$mode" == "dark" ]] && theme="$btop_dark_theme"

  sed -i '' "s|^color_theme = .*$|color_theme = \"${theme}\"|" "$BTOP_HOME/btop.conf"
}

# Function to set the Kitty theme
set_kitty_theme() {
  local mode="$1"
  local theme_file="$KITTY_HOME/kitty-themes/themes/${kitty_light_theme}.conf"
  [[ "$mode" == "dark" ]] && theme_file="$KITTY_HOME/kitty-themes/themes/${kitty_dark_theme}.conf"

  ln -sf "$theme_file" "$KITTY_HOME/theme.conf"

  # Extract color values
  local background=$(grep '^background' "$KITTY_HOME/theme.conf" | awk '{print $2}')
  local foreground=$(grep '^foreground' "$KITTY_HOME/theme.conf" | awk '{print $2}')
  local selection_background=$(grep '^selection_background' "$KITTY_HOME/theme.conf" | awk '{print $2}')
  local active_tab_foreground=$(grep '^color4' "$KITTY_HOME/theme.conf" | awk '{print $2}')

  # Create tab.conf
  cat >"$KITTY_HOME/tab.conf" <<EOF
active_tab_font_style   bold
inactive_tab_font_style regular
active_tab_foreground   ${active_tab_foreground}
active_tab_background   ${background}
inactive_tab_foreground ${foreground}
inactive_tab_background ${background}
tab_bar_background      none
active_border_color     ${active_tab_foreground}
EOF

  # Reload Kitty configuration
  is_kitty_running() {
    pgrep -x kitty >/dev/null
  }

  # Function to get Kitty PID
  get_kitty_pid() {
    pgrep -x kitty
  }

  if is_kitty_running; then
    KITTY_PID=$(get_kitty_pid)
    if [ -n "$KITTY_PID" ]; then
      kill -SIGUSR1 "$KITTY_PID"
    fi
  fi
}

# Function to set NeoVim theme
set_neovim_theme() {
  local mode="$1"
  cat >"$NVIM_HOME/lua/config/theme_config.lua" <<EOF
return {
  is_dark_mode = '$mode' == "dark",
}
EOF

  # Send SIGUSR1 to all running Neovim instances
  for pid in $(pgrep nvim); do
    kill -SIGUSR1 "$pid"
  done
}

# Function to set SketchyBar theme
set_sketchybar_theme() {
  local mode="$1"
  echo "return '$mode'" >"$SBAR_HOME/is_dark_mode.lua"
  /opt/homebrew/bin/sketchybar --reload
}

# Function to set the Yazi theme
set_yazi_theme() {
  local mode="$1"
  local theme_file="$YAZI_HOME/themes/${yazi_light_theme}.toml"
  [[ "$mode" == "dark" ]] && theme_file="$YAZI_HOME/themes/${yazi_dark_theme}.toml"

  ln -sf "$theme_file" "$YAZI_HOME/theme.toml"
}

# Main theme_sync function to set themes across applications
theme_sync() {
  local mode_setting="$1"
  local mode="light"

  # Determine current mode if not specified
  if [[ -z "$mode_setting" ]]; then
    if defaults read -g AppleInterfaceStyle &>/dev/null; then
      mode="dark"
    fi
  else
    mode="$mode_setting"
  fi

  set_alacritty_theme "$mode"
  set_bat_theme "$mode"
  set_border_color "$mode"
  set_btop_theme "$mode"
  set_kitty_theme "$mode"
  set_neovim_theme "$mode"
  set_sketchybar_theme "$mode"
  set_yazi_theme "$mode"
}

# Call the main function with the provided argument (if any)
theme_sync "$1"
