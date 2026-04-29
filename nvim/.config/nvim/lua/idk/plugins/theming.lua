return {{ -- * Bearded Theme
  "Ferouk/bearded-nvim",
  name = "bearded",
  priority = 1000,
  build = function()
    -- Generate helptags so :h bearded-theme works
    local doc = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "bearded", "doc")
    pcall(vim.cmd, "helptags " .. doc)
  end,
  config = function()
    require("bearded").setup({
      flavor = "black-&-gold",
      transparent = true,
      bold = true,
      italic = true,
      dim_inactive = true,
      terminal_colors = true,
      vim.cmd.colorscheme("bearded")
    })
  end
}, { -- * LuaLine with a theme
  'nvim-lualine/lualine.nvim',
  dependencies = {'nvim-tree/nvim-web-devicons'},
  config = function()
    globalstatus = true
    local lualine = require('lualine')
    local colors = {
      bg = '#000000',
      fg = '#3600aa',
      yellow = '#e4d729',
      cyan = '#59f6ff',
      darkblue = '#224996',
      green = '#65be9d',
      orange = '#ff7800',
      violet = '#7aa2f7',
      magenta = '#bb9af7',
      blue = '#02a6ff',
      red = '#ff0586'
    }

    local conditions = {
      buffer_not_empty = function()
        return vim.fn.empty(vim.fn.expand('%:t')) ~= 1
      end,
      hide_in_width = function()
        return vim.fn.winwidth(0) > 80
      end,
      check_git_workspace = function()
        local filepath = vim.fn.expand('%:p:h')
        local gitdir = vim.fn.finddir('.git', filepath .. ';')
        return gitdir and #gitdir > 0 and #gitdir < #filepath
      end
    }

    -- Config
    local config = {
      options = {
        component_separators = '',
        section_separators = '',
        theme = {
          normal = {
            c = {
              fg = colors.fg,
              bg = colors.bg
            }
          },
          inactive = {
            c = {
              fg = colors.fg,
              bg = colors.bg
            }
          }
        }
      },
      sections = {
        -- Remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        -- Filled later
        lualine_c = {},
        lualine_x = {}
      },
      inactive_sections = {
        -- Remove the defaults
        lualine_a = {},
        lualine_b = {},
        lualine_y = {},
        lualine_z = {},
        lualine_c = {},
        lualine_x = {}
      }
    }

    -- Inserts a component in lualine_c at left section
    local function ins_left(component)
      table.insert(config.sections.lualine_c, component)
    end

    -- Inserts a component in lualine_x at right section
    local function ins_right(component)
      table.insert(config.sections.lualine_x, component)
    end

    ins_left {
      function()
        return ''
      end,
      color = {
        fg = colors.orange
      }, -- Sets highlighting of component
      padding = {
        left = 0,
        right = 1
      }
    }

    ins_left {
      -- mode component
      function()
        return '󰋟'
      end,
      color = function()
        local mode_color = {
          n = colors.red,
          i = colors.green,
          v = colors.blue,
          [''] = colors.blue,
          V = colors.blue,
          c = colors.magenta,
          no = colors.red,
          s = colors.orange,
          S = colors.orange,
          [''] = colors.orange,
          ic = colors.yellow,
          R = colors.violet,
          Rv = colors.violet,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ['r?'] = colors.cyan,
          ['!'] = colors.red,
          t = colors.red
        }
        return {
          fg = mode_color[vim.fn.mode()]
        }
      end,
      padding = {
        left = 0,
        right = 0
      }
    }

    ins_left {
      'filesize',
      cond = conditions.buffer_not_empty
    }

    ins_left {
      'filename',
      cond = conditions.buffer_not_empty,
      color = {
        fg = colors.violet,
        gui = 'italic'
      }
    }

    ins_left {'location'}

    ins_left {
      'progress',
      color = {
        fg = colors.fg,
        gui = 'bold'
      }
    }

    ins_left {
      'diagnostics',
      sources = {'nvim_diagnostic'},
      symbols = {
        error = ' ',
        warn = ' ',
        info = ' '
      },
      diagnostics_color = {
        error = {
          fg = colors.red
        },
        warn = {
          fg = colors.orange
        },
        info = {
          fg = colors.cyan
        }
      }
    }

    -- -- Insert mid section aka empty space
    -- ins_left {function()
    --   return '%='
    -- end}

    ins_right {
      -- LSP
      function()
        local msg = 'MissingLSP'
        local buf_ft = vim.api.nvim_get_option_value('filetype', {
          buf = 0
        })
        local clients = vim.lsp.get_clients()
        if next(clients) == nil then
          return msg
        end
        for _, client in ipairs(clients) do
          local filetypes = client.config.filetypes
          if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
            return client.name
          end
        end
        return msg
      end,
      -- icon = '',
      color = {
        fg = '#a24b00'
      }
    }

    ins_right {
      'o:encoding',
      fmt = string.upper,
      cond = conditions.hide_in_width,
      color = {
        fg = colors.red,
        gui = 'italic'
      }
    }

    ins_right {
      'fileformat',
      fmt = string.upper,
      icons_enabled = true,
      color = {
        fg = colors.cyan
      }
    }

    ins_right {
      'branch',
      icon = '',
      color = {
        fg = colors.magenta,
        gui = 'italic'
      }
    }

    ins_right {
      'diff',
      -- Is it me or the symbol for modified us really weird
      symbols = {
        added = ' ',
        modified = ' ',
        removed = ' '
      },
      diff_color = {
        added = {
          fg = colors.green
        },
        modified = {
          fg = colors.orange
        },
        removed = {
          fg = colors.red
        }
      },
      cond = conditions.hide_in_width
    }

    ins_right {
      function()
        return ''
      end,
      color = {
        fg = colors.orange
      },
      padding = {
        left = 1
      }
    }

    -- Initialize lualine
    lualine.setup(config)

  end
}, { -- * Bufferline
  'akinsho/bufferline.nvim',
  version = "*",
  dependencies = 'nvim-tree/nvim-web-devicons',
  config = function()
    local bufferline = require('bufferline')
    bufferline.setup {
      options = {
        mode = "tabs",
        style_preset = {bufferline.style_preset.no_italic, bufferline.style_preset.no_bold},
        themable = true, -- allows highlight groups to be overriden i.e. sets highlights as default
        numbers = "none",
        indicator = {
          style = 'none'
        },
        modified_icon = '● ',
        left_trunc_marker = ' ',
        right_trunc_marker = ' ',
        --- name_formatter can be used to change the buffer's label in the bufferline.
        --- Please note some names can/will break the
        --- bufferline so use this at your discretion knowing that it has
        --- some limitations that will *NOT* be fixed.
        name_formatter = function(buf) -- buf contains:
          -- name                | str        | the basename of the active file
          -- path                | str        | the full path of the active file
          -- bufnr               | int        | the number of the active buffer
          -- buffers (tabs only) | table(int) | the numbers of the buffers in the tab
          -- tabnr (tabs only)   | int        | the "handle" of the tab, can be converted to its ordinal number using: `vim.api.nvim_tabpage_get_number(buf.tabnr)`
        end,
        max_name_length = 18,
        max_prefix_length = 3, -- prefix used when a buffer is de-duplicated
        truncate_names = true,
        tab_size = 15,
        diagnostics = "nvim_lsp",
        diagnostics_update_on_event = true, -- use nvim's diagnostic handler
        -- The diagnostics indicator can be set to nil to keep the buffer name highlight but delete the highlighting
        diagnostics_indicator = function(count, level, diagnostics_dict, context)
          return "(" .. count .. ")"
        end,
        -- NOTE: this will be called a lot so don't do any heavy processing here
        custom_filter = function(buf_number, buf_numbers)
          -- filter out filetypes you don't want to see
          if vim.bo[buf_number].filetype ~= "<i-dont-want-to-see-this>" then
            return true
          end
          -- filter out by buffer name
          if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
            return true
          end
          -- filter out based on arbitrary rules
          -- e.g. filter out vim wiki buffer from tabline in your work repo
          if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
            return true
          end
          -- filter out by it's index number in list (don't show first buffer)
          if buf_numbers[1] ~= buf_number then
            return true
          end
        end,
        color_icons = true,
        get_element_icon = function(element)
          -- element consists of {filetype: string, path: string, extension: string, directory: string}
          -- This can be used to change how bufferline fetches the icon
          -- for an element e.g. a buffer or a tab.
          -- e.g.
          local icon, hl = require('nvim-web-devicons').get_icon_by_filetype(element.filetype, {
            default = false
          })
          return icon, hl
        end,
        show_buffer_icons = true,
        show_buffer_close_icons = false,
        show_close_icon = false,
        show_tab_indicators = false,
        show_duplicate_prefix = true,
        duplicates_across_groups = true,
        persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
        move_wraps_at_ends = false, -- whether or not the move command "wraps" at the first or last position
        -- can also be a table containing 2 custom separators
        -- [focused and unfocused]. eg: { '|', '|' }
        separator_style = {"", ""}, -- "slant" | "slope" | "thick" | "thin" | {'any', 'any'}
        enforce_regular_tabs = true,
        always_show_bufferline = true,
        auto_toggle_bufferline = false
        -- hover = {
        --   enabled = true,
        --   delay = 200,
        --   reveal = {'close'}
        -- },
        -- ! Highlights doesn't work - Look for vim overrides
      }
    }
  end
}, { --- * Web Devicons
  "nvim-tree/nvim-web-devicons",
  opts = {
    color_icons = true,
    default = true,
    strict = true,
    variant = "light|dark"
  }
}}
