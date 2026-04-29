require("smart-enter"):setup{
  open_multi = true
}

require("full-border"):setup{
  -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
  type = ui.Border.ROUNDED
}

require("git"):setup{
  -- Order of status signs showing in the linemode
  order = 1500
}
th.git = th.git or {}
th.git.modified_sign = "M"
th.git.deleted_sign = "D"
th.git.added_sign = "A"
th.git.untracked_sign = "U"
th.git.clean_sign = "✔"

if os.getenv("NVIM") then
  require("toggle-pane"):entry("min-preview")
end

require("starship"):setup({
  -- Hide flags (such as filter, find and search). This can be beneficial for starship themes
  -- which are intended to go across the entire width of the terminal.
  hide_flags = false,
  -- Whether to place flags after the starship prompt. False means the flags will be placed before the prompt.
  flags_after_prompt = true,
  -- Custom starship configuration file to use
  config_file = "~/.config/starship.toml", -- Default: nil
  -- Whether to enable support for starship's right prompt (i.e. `starship prompt --right`).
  show_right_prompt = true,
  -- Whether to hide the count widget, in case you want only your right prompt to show up. Only has
  -- an effect when `show_right_prompt = true`
  hide_count = false,
  -- Separator to place between the right prompt and the count widget. Use `count_separator = ""`
  -- to have no space between the widgets.
  count_separator = " "
})

require("yaziline"):setup({
  color = "#7f79c3",
  secondary_color = "#18093c",
  default_files_color = "#7f79c3",
  selected_files_color = "white",
  yanked_files_color = "orange",
  cut_files_color = "red",

  separator_style = "liney",

  select_symbol = "",
  yank_symbol = "󰃕",

  filename_max_length = 24,
  filename_truncate_length = 6,
  filename_truncate_separator = "..."
})
