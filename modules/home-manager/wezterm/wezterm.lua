local wezterm = require 'wezterm'
local home = wezterm.home_dir;
local config = wezterm.config_builder()

wezterm.add_to_config_reload_watch_list(home.."/.cache/wal/colors-wezterm.toml")

config.default_prog = { "fish" }
config.enable_scroll_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.color_scheme_dirs = { home.."/.cache/wal" }
config.color_scheme = "colors-wezterm"

return config
