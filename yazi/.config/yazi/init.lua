-- ! Plugins
-- # age-badge
-- ya pkg add alchezar/age-badge
require("age-badge"):setup{
  position = "right", -- "left" (default) or "right"
  pad = false, -- add a blank cell on the outer side
  compact = false -- true (default) = 3 cells, false = roomier 5 cells
}
-- # fs-usage
-- ya pkg add walldmtd/fs-usage
require("fs-usage"):setup()
-- # full-border
-- ya pkg add yazi-rs/plugins:full-border
require("full-border"):setup{
  -- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
  type = ui.Border.ROUNDED
}

-- # starship
-- ya pkg add Rolv-Apneseth/starship
require("starship"):setup()

-- # git
-- ya pkg add yazi-rs/plugins:git
require("git"):setup{
  -- Order of status signs showing in the linemode
  order = 1500
}
