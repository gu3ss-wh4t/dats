return {{
  'nvim-mini/mini.nvim',
  version = false,
  config = function()
    require('mini.icons').setup()
    require('mini.files').setup({
      windows = {
        preview = true,
        width_focus = 20,
        width_preview = 20
      },
      options = {
        use_as_default_explorer = true
      }
    })
    require('mini.pairs').setup()
    require('mini.sessions').setup()
    require('mini.ai').setup()
    require('mini.cmdline').setup()
    require('mini.move').setup({
      mappings = {
        left = '<C-h>',
        right = '<C-l>',
        down = '<C-j>',
        up = '<C-k>',

        line_left = '<C-h>',
        line_right = '<C-l>',
        line_down = '<C-j>',
        line_up = '<C-k>'
      }
    })
    require('mini.comment').setup()
    require('mini.surround').setup()
  end
}}

