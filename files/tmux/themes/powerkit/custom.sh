#!/usr/bin/env bash

## a simple copy of the abyss them
declare -gA THEME_COLORS=(
  # =========================================================================
  # CORE (terminal background - used for transparent mode separators)
  # =========================================================================
  ["background"]="#000000" # core

  # =========================================================================
  # STATUS BAR
  # =========================================================================
  ["statusbar-bg"]="#080808" # mantle
  ["statusbar-fg"]="#f0ebe6" # fg

  # =========================================================================
  # SESSION (status-left)
  # =========================================================================
  ["session-bg"]="#e26e6e"         # strong_primary
  ["session-bg"]="#71b8ff"         # strong_primary
  ["session-fg"]="#000000"         # core
  ["session-prefix-bg"]="#81c0b6"  # prefix
  ["session-copy-bg"]="#5a3824"    # indigo
  ["session-search-bg"]="#f0e68c"  # yellow
  ["session-command-bg"]="#8fd1c7" # teal

  # =========================================================================
  # WINDOW (active)
  # =========================================================================
  # ["window-active-base"]="#f8b471" # secondary
  ["window-active-base"]="#0088ff" # blue (distinctive)
  ["window-active-style"]="bold"

  # =========================================================================
  # WINDOW (inactive)
  # =========================================================================
  ["window-inactive-base"]="#1a1a1a" # surface
  ["window-inactive-style"]="none"

  # =========================================================================
  # WINDOW STATE (activity, bell, zoomed)
  # =========================================================================
  ["window-activity-style"]="italics"
  ["window-bell-style"]="bold"
  ["window-zoomed-bg"]="#71b8ff" # blue

  # =========================================================================
  # PANE
  # =========================================================================
  # ["pane-border-active"]="#f8b471"   # secondary
  ["pane-border-active"]="#71b8ff"   # secondary
  ["pane-border-inactive"]="#1a1a1a" # surface

  # =========================================================================
  # STATUS COLORS (health/state-based for plugins)
  # =========================================================================
  # ["ok-base"]="#1a1a1a"       # surface
  ["ok-base"]="#0088ff"       # surface
  ["good-base"]="#53d390"     # green
  ["info-base"]="#71b8ff"     # blue
  ["warning-base"]="#f0e68c"  # yellow
  ["error-base"]="#e26e6e"    # strong_primary
  ["disabled-base"]="#080808" # mantle

  # =========================================================================
  # MESSAGE COLORS
  # =========================================================================
  ["message-bg"]="#1a1a1a" # surface
  ["message-fg"]="#f0ebe6" # fg

  # =========================================================================
  # POPUP & MENU
  # =========================================================================
  ["popup-bg"]="#1a1a1a"         # surface
  ["popup-fg"]="#f0ebe6"         # fg
  ["popup-border"]="#0088ff"     # strong_primary
  ["menu-bg"]="#1a1a1a"          # surface
  ["menu-fg"]="#f0ebe6"          # fg
  ["menu-selected-bg"]="#0088ff" # strong_primary
  ["menu-selected-fg"]="#000000" # core
  ["menu-border"]="#0088ff"      # strong_primary
)
