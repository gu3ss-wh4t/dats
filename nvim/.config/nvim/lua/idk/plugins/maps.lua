-- &Plugins keymaps for which-key grouping
local wk = require("which-key")
wk.add({{
  -- * Tabs
  "<leader>t",
  group = "[T]abs",
  icon = {
    icon = "󰝜",
    color = "blue"
  },
  expand = function()
    return require("which-key.extras").expand.buf()
  end
}, {
  mode = {"n", "v"},
  icon = {
    icon = "󰝜",
    color = "blue"
  },
  {
    "<leader>tt",
    "<cmd>tabnew<cr>",
    desc = "Create[T]ab"
  },
  {
    "<leader>tc",
    "<cmd>tabclose<cr>",
    desc = "[C]loseTab"
  },
  {
    "<S-Tab>",
    "<cmd>BufferLineCyclePrev<cr>",
    desc = "[P]reviousTab"
  },
  {
    "<Tab>",
    "<cmd>BufferLineCycleNext<cr>",
    desc = "[N]extTab"
  }
}, { -- * Windows
  "<leader>w",
  proxy = "<c-w>",
  group = "[W]indows"
}, { -- * Yazi
  "<leader>y",
  group = "[Y]azi",
  icon = {
    icon = "󰇥",
    color = "orange"
  },
  expand = function()
    return require("which-key.extras").expand.buf()
  end
}, {{
  icon = {
    icon = "󰇥",
    color = "orange"
  },
  "<leader>ye",
  "<cmd>Yazi<cr>",
  desc = "Open Yazi"
}, {
  "<leader>yw",
  "<cmd>Yazi cwd<cr>",
  desc = "[Y]azi [W]orking directory"
}, {
  "<leader>yt",
  "<cmd>Yazi toggle<cr>",
  desc = "[Y]azi [T]oggle"
}}, { -- * Mini Files
  "<leader>m",
  group = "[M]ini",
  icon = {
    icon = "",
    color = "blue"
  },
  expand = function()
    return require("which-key.extras").expand.buf()
  end
}, {{
  icon = {
    icon = "",
    color = "blue"
  },
  "<leader>me",
  "<cmd>lua MiniFiles.open()<cr>",
  desc = "Open MiniFiles"
}}})

return {}

