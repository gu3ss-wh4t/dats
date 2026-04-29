return {{ -- * Highlight-colors
  'brenoprata10/nvim-highlight-colors',
  config = function()
    require("nvim-highlight-colors").setup {
      render = 'foreground'
    }
  end
}, { -- * Dropbar
  'Bekaboo/dropbar.nvim',
  -- optional, but required for fuzzy finder support
  dependencies = {
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make'
  },
  config = function()
    local dropbar_api = require('dropbar.api')
    vim.keymap.set('n', '<Leader>;', dropbar_api.pick, {
      desc = 'Pick symbols in winbar'
    })
    vim.keymap.set('n', '[;', dropbar_api.goto_context_start, {
      desc = 'Go to start of current context'
    })
    vim.keymap.set('n', '];', dropbar_api.select_next_context, {
      desc = 'Select next context'
    })
    -- Replacement for Neovim's builtin vim.ui.select menu
    vim.ui.select = require('dropbar.utils.menu').select
  end
}, { -- * Yazi
  "mikavilpas/yazi.nvim",
  version = "*",
  event = "VeryLazy",
  dependencies = {{
    "nvim-lua/plenary.nvim",
    lazy = true
  }},
  opts = {
    open_for_directories = true,
    keymaps = {
      show_help = "<f1>"
    }
  },
  init = function()
    vim.g.loaded_netrwPlugin = 1
  end
}, { -- * Neoclip
  "AckslD/nvim-neoclip.lua",
  dependencies = {{
    'kkharji/sqlite.lua',
    module = 'sqlite'
  }, {'ibhagwan/fzf-lua'}},
  config = function()
    require('neoclip').setup({
      history = 1000,
      enable_persistent_history = true,
      length_limit = 1048576,
      continuous_sync = false,
      db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
      filter = nil,
      preview = true,
      prompt = nil,
      default_register = '"',
      default_register_macros = 'q',
      enable_macro_history = true,
      content_spec_column = false,
      disable_keycodes_parsing = false,
      dedent_picker_display = false,
      initial_mode = 'insert',
      on_select = {
        move_to_front = false,
        close_telescope = true
      },
      on_paste = {
        set_reg = false,
        move_to_front = false,
        close_telescope = true
      },
      on_replay = {
        set_reg = false,
        move_to_front = false,
        close_telescope = true
      },
      on_custom_action = {
        close_telescope = true
      },
      keys = {
        telescope = {
          i = {
            select = '<cr>',
            paste = '<c-p>',
            paste_behind = '<c-k>',
            replay = '<c-q>', -- replay a macro
            delete = '<c-d>', -- delete an entry
            edit = '<c-e>', -- edit an entry
            custom = {}
          },
          n = {
            select = '<cr>',
            paste = 'p',
            --- It is possible to map to more than one key.
            -- paste = { 'p', '<c-p>' },
            paste_behind = 'P',
            replay = 'q',
            delete = 'd',
            edit = 'e',
            custom = {}
          }
        },
        fzf = {
          select = 'default',
          paste = 'ctrl-p',
          paste_behind = 'ctrl-k',
          custom = {}
        }
      }
    })

  end
}, { -- * Smear Cursor
  "sphamba/smear-cursor.nvim",
  opts = {
    -- Smear cursor when switching buffers or windows.
    smear_between_buffers = true,

    -- Smear cursor when moving within line or to neighbor lines.
    -- Use `min_horizontal_distance_smear` and `min_vertical_distance_smear` for finer control
    smear_between_neighbor_lines = true,

    -- Draw the smear in buffer space instead of screen space when scrolling
    scroll_buffer_space = true,

    -- Set to `true` if your font supports legacy computing symbols (block unicode symbols).
    -- Smears and particles will look a lot less blocky.
    legacy_computing_symbols_support = false,

    -- Smear cursor in insert mode.
    -- See also `vertical_bar_cursor_insert_mode` and `distance_stop_animating_vertical_bar`.
    smear_insert_mode = true,
    stiffness = 0.8, -- 0.6      [0, 1]
    trailing_stiffness = 0.6, -- 0.45     [0, 1]
    stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
    trailing_stiffness_insert_mode = 0.7, -- 0.5      [0, 1]
    damping = 0.95, -- 0.85     [0, 1]
    damping_insert_mode = 0.95, -- 0.9      [0, 1]
    distance_stop_animating = 0.5, -- 0.1      > 0
    time_interval = 7 -- milliseconds

  }
}, { -- * Git Signs
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup {
      signs = {
        add = {
          text = '┃'
        },
        change = {
          text = '┃'
        },
        delete = {
          text = '_'
        },
        topdelete = {
          text = '‾'
        },
        changedelete = {
          text = '~'
        },
        untracked = {
          text = '┆'
        }
      },
      signs_staged = {
        add = {
          text = '┃'
        },
        change = {
          text = '┃'
        },
        delete = {
          text = '_'
        },
        topdelete = {
          text = '‾'
        },
        changedelete = {
          text = '~'
        },
        untracked = {
          text = '┆'
        }
      },
      signs_staged_enable = true,
      signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
      numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
      on_attach = function(bufnr)
        local gitsigns = require('gitsigns')

        local function map(mode, l, r, opts)
          opts = opts or {}
          opts.buffer = bufnr
          vim.keymap.set(mode, l, r, opts)
        end

        -- Navigation
        map('n', ']c', function()
          if vim.wo.diff then
            vim.cmd.normal({
              ']c',
              bang = true
            })
          else
            gitsigns.nav_hunk('next')
          end
        end)

        map('n', '[c', function()
          if vim.wo.diff then
            vim.cmd.normal({
              '[c',
              bang = true
            })
          else
            gitsigns.nav_hunk('prev')
          end
        end)

        -- Actions
        map('n', '<leader>hs', gitsigns.stage_hunk)
        map('n', '<leader>hr', gitsigns.reset_hunk)

        map('v', '<leader>hs', function()
          gitsigns.stage_hunk({vim.fn.line('.'), vim.fn.line('v')})
        end)

        map('v', '<leader>hr', function()
          gitsigns.reset_hunk({vim.fn.line('.'), vim.fn.line('v')})
        end)

        map('n', '<leader>hS', gitsigns.stage_buffer)
        map('n', '<leader>hR', gitsigns.reset_buffer)
        map('n', '<leader>hp', gitsigns.preview_hunk)
        map('n', '<leader>hi', gitsigns.preview_hunk_inline)

        map('n', '<leader>hb', function()
          gitsigns.blame_line({
            full = true
          })
        end)

        map('n', '<leader>hd', gitsigns.diffthis)

        map('n', '<leader>hD', function()
          gitsigns.diffthis('~')
        end)

        map('n', '<leader>hQ', function()
          gitsigns.setqflist('all')
        end)
        map('n', '<leader>hq', gitsigns.setqflist)

        -- Toggles
        map('n', '<leader>tb', gitsigns.toggle_current_line_blame)
        map('n', '<leader>tw', gitsigns.toggle_word_diff)

        -- Text object
        map({'o', 'x'}, 'ih', gitsigns.select_hunk)
      end
    }
  end
}, { -- * LazyGit
  "kdheepak/lazygit.nvim",
  lazy = true,
  cmd = {"LazyGit", "LazyGitConfig", "LazyGitCurrentFile", "LazyGitFilter", "LazyGitFilterCurrentFile"},
  -- optional for floating window border decoration
  dependencies = {"nvim-lua/plenary.nvim"},
  -- setting the keybinding for LazyGit with 'keys' is recommended in
  -- order to load the plugin when the command is run for the first time
  keys = {{
    "<leader>lg",
    "<cmd>LazyGit<cr>",
    desc = "LazyGit"
  }}
}, { -- * Markdown
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons'},
  opts = {
    render_modes = true,
    completions = {
      lsp = {
        enabled = true
      }
    },
    file_types = {'markdown', 'vimwiki'},
    heading = {
      icons = false,
      position = 'inline',
      width = 'block',
      left_margin = 0.5,
      left_pad = 0.2,
      right_pad = 0.2

    }
  },
  vim.treesitter.language.register('markdown', 'vimwiki')
}}
