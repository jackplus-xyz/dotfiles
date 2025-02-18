#!/bin/bash
# Require: https://github.com/bouk/dark-mode-notify
# Synchronizes themes across applications based on system appearance (light or dark mode).

ALA_HOME="${ALA_HOME:-$HOME/.config/alacritty}"
BAT_HOME="${BAT_HOME:-$HOME/.config/bat}"
HELIX_HOME="${HELIX_HOME:-$HOME/.config/helix}"
KAK_HOME="${KAK_HOME:-$HOME/.config/kak}"
KITTY_HOME="${KITTY_HOME:-$HOME/.config/kitty}"
NVIM_HOME="${NVIM_HOME:-$HOME/.config/nvim}"
ZELLIJ_HOME="${ZELLIJ_HOME:-$HOME/.config/zellij}"

alacritty_light_theme="flexoki-light"
alacritty_dark_theme="flexoki-dark"
bat_light_theme="OneHalfLight"
bat_dark_theme="OneHalfDark"
helix_light_theme="flexoki_light"
helix_dark_theme="flexoki_dark"
kak_light_theme="flexoki-light"
kak_dark_theme="flexoki-dark"
kitty_light_theme="flexoki-light"
kitty_dark_theme="flexoki-dark"
zellij_light_theme="flexoki-light"
zellij_dark_theme="flexoki-dark"

set_alacritty_theme() {
  local mode="$1"
  local theme_file="$ALA_HOME/themes/${alacritty_light_theme}.toml"
  [[ "$mode" == "dark" ]] && theme_file="$ALA_HOME/themes/${alacritty_dark_theme}.toml"

  ln -sf "$theme_file" "$ALA_HOME/theme.toml" && touch "$ALA_HOME/alacritty.toml"
}

set_bat_theme() {
  local mode="$1"
  local theme="$bat_light_theme"
  [[ "$mode" == "dark" ]] && theme="$bat_dark_theme"

  echo "--theme=$theme" >"$BAT_HOME/config"
}

set_helix_theme() {
  local mode="$1"
  local theme="$helix_light_theme"
  [[ "$mode" == "dark" ]] && theme="$helix_dark_theme"

  local theme_file="$HELIX_HOME/themes/${theme}.toml"
  ln -sf "$theme_file" "$HELIX_HOME/themes/theme.toml"

  # Send USR1 signal to all running helix instances to reload config
  pkill -USR1 hx || true
}

set_kak_theme() {
  local mode="$1"
  local theme="$kak_light_theme"
  [[ "$mode" == "dark" ]] && theme="$kak_dark_theme"

  local config_dir
  if [[ -n "$KAKOUNE_CONFIG_DIR" ]]; then
    config_dir="$KAKOUNE_CONFIG_DIR"
  elif [[ -n "$XDG_CONFIG_HOME" ]]; then
    config_dir="$XDG_CONFIG_HOME/kak"
  else
    config_dir="$HOME/.config/kak"
  fi

  local theme_link="$config_dir/colors/$theme.kak"

  local kak="/opt/homebrew/bin/kak"
  # kill dead sessions
  "$kak" -clear
  ln -sf "$theme_link" "$config_dir/colors/theme.kak"
  for session in $("$kak" -l); do
    echo "colorscheme theme" | "$kak" -p "$session"
  done
}

set_kitty_theme() {
  ln -sf "$KITTY_HOME/custom-themes/${kitty_light_theme}.conf" "$KITTY_HOME/no-preference-theme.auto.conf"
  ln -sf "$KITTY_HOME/custom-themes/${kitty_light_theme}.conf" "$KITTY_HOME/light-theme.auto.conf"
  ln -sf "$KITTY_HOME/custom-themes/${kitty_dark_theme}.conf" "$KITTY_HOME/dark-theme.auto.conf"

  # ln -sf "$KITTY_HOME/kitty-themes/themes/${kitty_light_theme}.conf" "$KITTY_HOME/no-preference-theme.auto.conf"
  # ln -sf "$KITTY_HOME/kitty-themes/themes/${kitty_light_theme}.conf" "$KITTY_HOME/light-theme.auto.conf"
  # ln -sf "$KITTY_HOME/kitty-themes/themes/${kitty_dark_theme}.conf" "$KITTY_HOME/dark-theme.auto.conf"
}

set_nvim_theme() {
  local mode="$1"
  mkdir -p "$NVIM_HOME/lua/cache"
  echo "return '$mode'" >"$NVIM_HOME/lua/cache/mode.lua"
}

set_zellij_theme() {
  local mode="$1"
  local theme="$zellij_light_theme"
  [[ "$mode" == "dark" ]] && theme="$zellij_dark_theme"

  zellij options --theme theme
}

theme_sync() {
  local mode_setting="$1"
  local mode="light"

  # Fallback mode if not specified
  if [[ -z "$mode_setting" ]]; then
    if defaults read -g AppleInterfaceStyle &>/dev/null; then
      mode="dark"
    fi
  else
    mode="$mode_setting"
  fi

  set_alacritty_theme "$mode"
  set_bat_theme "$mode"
  set_helix_theme "$mode"
  set_kak_theme "$mode"
  set_kitty_theme
  set_nvim_theme "$mode"
  set_zellij_theme "$mode"
}

theme_sync "$1"
