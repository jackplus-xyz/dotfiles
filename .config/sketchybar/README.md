# SketchyBar

Adapted from [FelixKratz/dotfiles: My personal macOS configuration](https://github.com/FelixKratz/dotfiles)

## Features

- `todo.lua`:

  - Displays a single todo item in the menu bar.
  - It stores and retrieves the todo text from `/tmp/sketchy_todo.txt`, ensuring that the todo persist across sessions.
  - Users can interact with the todo by clicking on it to add or complete the item.
  - It plays sounds from `/System/Library/Sounds/` when a new item is created or completed.

- `pomodoro_timer.lua`:

  - Displays a [Pomodoro Timer](https://en.wikipedia.org/wiki/Pomodoro_Technique) in the menu bar.
  - Each session will be 25 minutes long, followed by a 5-minute break. After completing 4 sessions, it will have a longer break of 15 minutes.
