#!/bin/bash

# Source directories
DOTFILES_DIR="$HOME/.config/dotfiles"
CONFIG_SOURCE_DIR="$DOTFILES_DIR/.config"
TARGET_DIR="$HOME"

# Create backup directory with timestamp
BACKUP_DIR="$HOME/.config/dotfiles_backup/$(date +%Y%m%d_%H%M%S)"
mkdir -p "$BACKUP_DIR"

# Function to create symlink with backup
create_symlink() {
  local source="$1"
  local target="$2"

  # If target exists and is not a symlink, back it up
  if [ -e "$target" ] && [ ! -L "$target" ]; then
    echo "Backing up $target to $BACKUP_DIR/$(basename "$target")"
    mv "$target" "$BACKUP_DIR/$(basename "$target")"
  elif [ -L "$target" ]; then
    # If it's already a symlink, remove it
    rm "$target"
  fi

  # Create symlink
  echo "Creating symlink for $(basename "$target")"
  ln -s "$source" "$target"
}

# Handle .config directory contents
mkdir -p "$TARGET_DIR/.config"
for item in "$CONFIG_SOURCE_DIR"/*; do
  # Skip if it's the actual source directory
  if [ "$item" = "$TARGET_DIR/.config/dotfiles" ]; then
    continue
  fi

  item_name=$(basename "$item")
  target_item="$TARGET_DIR/.config/$item_name"
  create_symlink "$item" "$target_item"
done

# Handle root-level configuration files
root_configs=(".p10k.zsh" ".tmux.conf" ".zimrc" ".zshrc")
for config in "${root_configs[@]}"; do
  if [ -f "$DOTFILES_DIR/$config" ]; then
    create_symlink "$DOTFILES_DIR/$config" "$TARGET_DIR/$config"
  fi
done

# Handle scripts directory
if [ -d "$DOTFILES_DIR/scripts" ]; then
  mkdir -p "$TARGET_DIR/.local/bin"
  for script in "$DOTFILES_DIR/scripts"/*; do
    if [ -f "$script" ]; then
      script_name=$(basename "$script")
      create_symlink "$script" "$TARGET_DIR/.local/bin/$script_name"
    fi
  done
fi

echo "Done! Backups are stored in $BACKUP_DIR"
