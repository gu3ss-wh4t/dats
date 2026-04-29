return {{ -- * Which-Key
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {},
  keys = {{
    "<leader>?",
    function()
      require("which-key").show({
        global = false
      })
    end,
    desc = "Buffer Local Keymaps"
  }}
}, { -- * Trouble
  "folke/trouble.nvim",
  opts = {},
  cmd = "Trouble",
  keys = {{
    "<leader>xx",
    "<cmd>Trouble diagnostics toggle<cr>",
    desc = "Diagnostics (Trouble)"
  }, {
    "<leader>xX",
    "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
    desc = "Buffer Diagnostics (Trouble)"
  }, {
    "<leader>cs",
    "<cmd>Trouble symbols toggle focus=false<cr>",
    desc = "Symbols (Trouble)"
  }, {
    "<leader>cl",
    "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
    desc = "LSP Definitions / references / ... (Trouble)"
  }, {
    "<leader>xL",
    "<cmd>Trouble loclist toggle<cr>",
    desc = "Location List (Trouble)"
  }, {
    "<leader>xQ",
    "<cmd>Trouble qflist toggle<cr>",
    desc = "Quickfix List (Trouble)"
  }}
}, { -- * Noice
  "folke/noice.nvim",
  event = "VeryLazy",
  dependencies = { -- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
  "MunifTanjim/nui.nvim", -- OPTIONAL:
  --   `nvim-notify` is only needed, if you want to use the notification view.
  --   If not available, we use `mini` as the fallback
  "rcarriga/nvim-notify", {}},
  config = function()
    require("noice").setup({
      cmdline = {
        format = {
          cmdline = {
            icon = ""
          }
        }
      },
      views = {
        cmdline_popup = {
          position = {
            row = 5,
            col = "50%"
          },
          size = {
            width = 60,
            height = "auto"
          }
        },
        popupmenu = {
          relative = "editor",
          position = {
            row = 8,
            col = "50%"
          },
          size = {
            width = 60,
            height = 10
          },
          border = {
            style = "rounded",
            padding = {0, 1}
          },
          win_options = {
            winhighlight = {
              Normal = "Normal",
              FloatBorder = "DiagnosticInfo"
            }
          }
        }
      },

      lsp = {
        -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true -- requires hrsh7th/nvim-cmp
        }
      },
      -- you can enable a preset for easier configuration
      presets = {
        bottom_search = false, -- use a classic bottom cmdline for search
        command_palette = true, -- position the cmdline and popupmenu together
        long_message_to_split = true, -- long messages will be sent to a split
        inc_rename = false, -- enables an input dialog for inc-rename.nvim
        lsp_doc_border = true -- add a border to hover docs and signature help
      }
    })
  end
}, { -- * Snacks
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    bigfile = {
      enabled = true
    },
    dashboard = {
      enabled = true,
      width = 75,
      row = nil, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      pane_gap = 2, -- empty columns between vertical panes
      autokeys = "1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ",
      preset = {
        keys = {{
          icon = " ",
          key = "f",
          desc = "Find File",
          action = ":lua Snacks.dashboard.pick('files')"
        }, {
          icon = " ",
          key = "r",
          desc = "Recent Files",
          action = ":lua Snacks.dashboard.pick('oldfiles')"
        }, {
          icon = " ",
          key = "c",
          desc = "Config",
          action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})"
        }, {
          icon = " ",
          key = "s",
          desc = "Restore Session",
          section = "session"
        }, {
          icon = "󰒲 ",
          key = "L",
          desc = "Lazy",
          action = ":Lazy",
          enabled = package.loaded.lazy ~= nil
        }, {}, {
          icon = " ",
          key = "l",
          desc = "LazyGit",
          action = ":LazyGit",
          enabled = package.loaded.lazy ~= nil
        }, {
          icon = " ",
          key = "M",
          desc = "Mason",
          action = ":Mason"
        }},
        -- Used by the `header` section
        header = [[
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣸⣇⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢠⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣿⣿⣿⣿⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣷⡄⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⡘⢿⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣶⣽⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⠀⠀⣼⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣧⡀⠀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⠿⠿⣿⣿⣿⣿⣿⣿⣿⡀⠀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⠀⢀⣾⣿⣿⣿⣿⣿⡟⠀⠀⠀⠈⠻⣿⣿⣿⣿⣿⣷⡀⠀⠀⠀⠀⠀
⠀⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⡿⠀⠀⠀⠀⠀⠀⣿⣿⣿⣿⣿⣿⣿⡆⠀⠀⠀⠀
⠀⠀⠀⢠⣾⣿⣿⣿⣿⣿⣿⡷⠀⠀⠀⠀⠀⠀⢸⣿⣿⣿⣿⣷⣽⣛⠀⠀⠀⠀
⠀⠀⢠⣿⣿⣿⣿⣿⣿⠿⠛⠛⠀⠀⠀⠀⠀⠀⠛⠛⠿⣿⣿⣿⣿⣿⣶⡄⠀⠀
⠀⢰⣿⣿⠿⠟⠉⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠙⠛⠿⣿⣿⡆⠀
⡰⠟⠉⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠀⠉⠻⢆
]]
      },
      sections = {{
        section = "header",
        gap = 0,
        padding = 0
      }, {
        section = "startup",
        gap = 0,
        padding = 1
      }, {
        section = "keys",
        gap = 0,
        padding = 0
      }, {
        icon = " ",
        title = "Projects",
        section = "projects",
        indent = 3,
        padding = 0,
        gap = 0
      }, {
        pane = 2,
        icon = " ",
        desc = "Browse Repo",
        padding = 1,
        key = "b",
        action = function()
          Snacks.gitbrowse()
        end
      }, function()
        local in_git = Snacks.git.get_root() ~= nil
        local cmds = {{
          title = "Notifications",
          cmd = "gh notify -s -a -n5",
          action = function()
            vim.ui.open("https://github.com/notifications")
          end,
          key = "n",
          icon = "󰂟 ",
          height = 5,
          enabled = true
        }, {
          title = "Open Issues",
          cmd = "gh issue list -L 3",
          key = "i",
          action = function()
            vim.fn.jobstart("gh issue list --web", {
              detach = true
            })
          end,
          icon = " ",
          height = 7
        }, {
          icon = " ",
          title = "Open PRs",
          cmd = "gh pr list -L 3",
          key = "P",
          action = function()
            vim.fn.jobstart("gh pr list --web", {
              detach = true
            })
          end,
          height = 7
        }, {
          icon = " ",
          title = "Git Status",
          cmd = "git --no-pager diff --stat -B -M -C",
          height = 10
        }}
        return vim.tbl_map(function(cmd)
          return vim.tbl_extend("force", {
            pane = 2,
            section = "terminal",
            enabled = in_git,
            padding = 1,
            ttl = 5 * 60,
            indent = 3
          }, cmd)
        end, cmds)
      end}

    },
    explorer = {
      enabled = false
    },
    indent = {
      priority = 1,
      enabled = true, -- enable indent guides
      char = "."
    },
    animate = {
      enabled = vim.fn.has("nvim-0.10") == 1,
      style = "up_down",
      easing = "bounce"
    },
    scope = {
      enabled = true, -- enable highlighting the current scope
      char = ".",
      underline = true -- underline the start of the scope
    },
    chunk = {
      enabled = true,
      char = {
        corner_top = "╭",
        corner_bottom = "╰",
        horizontal = "─",
        vertical = "│",
        arrow = ">"
      }
    },
    input = {
      enabled = true
    },
    notifier = {
      enabled = true,
      timeout = 3000
    },
    picker = {
      enabled = true
    },
    quickfile = {
      enabled = true
    },
    scroll = {
      enabled = true
    },
    statuscolumn = {
      enabled = true,
      left = {"sign", "mark"}, -- priority of signs on the left (high to low)
      right = {"git", "fold"}, -- priority of signs on the right (high to low)
      folds = {
        open = true, -- show open fold icons
        git_hl = true -- use Git Signs hl for fold icons
      },
      git = {
        -- patterns to match Git signs
        patterns = {"GitSign", "MiniDiffSign"}
      },
      refresh = 50 -- refresh at most every 50ms 
    },
    words = {
      enabled = true
    },
    styles = {
      notification = {
        wo = {
          wrap = true
        } -- Wrap notifications
      }
    }
  },
  keys = { -- Top Pickers & Explorer
  {
    "<leader><space>",
    function()
      Snacks.picker.smart()
    end,
    desc = "Smart Find Files"
  }, {
    "<leader>,",
    function()
      Snacks.picker.buffers()
    end,
    desc = "Buffers"
  }, {
    "<leader>/",
    function()
      Snacks.picker.grep()
    end,
    desc = "Grep"
  }, {
    "<leader>:",
    function()
      Snacks.picker.command_history()
    end,
    desc = "Command History"
  }, {
    "<leader>n",
    function()
      Snacks.picker.notifications()
    end,
    desc = "Notification History"
  }, -- find
  {
    "<leader>fb",
    function()
      Snacks.picker.buffers()
    end,
    desc = "Buffers"
  }, {
    "<leader>fc",
    function()
      Snacks.picker.files({
        cwd = vim.fn.stdpath("config")
      })
    end,
    desc = "Find Config File"
  }, {
    "<leader>ff",
    function()
      Snacks.picker.files()
    end,
    desc = "Find Files"
  }, {
    "<leader>fg",
    function()
      Snacks.picker.git_files()
    end,
    desc = "Find Git Files"
  }, {
    "<leader>fp",
    function()
      Snacks.picker.projects()
    end,
    desc = "Projects"
  }, {
    "<leader>fr",
    function()
      Snacks.picker.recent()
    end,
    desc = "Recent"
  }, -- git
  {
    "<leader>gb",
    function()
      Snacks.picker.git_branches()
    end,
    desc = "Git Branches"
  }, {
    "<leader>gl",
    function()
      Snacks.picker.git_log()
    end,
    desc = "Git Log"
  }, {
    "<leader>gL",
    function()
      Snacks.picker.git_log_line()
    end,
    desc = "Git Log Line"
  }, {
    "<leader>gs",
    function()
      Snacks.picker.git_status()
    end,
    desc = "Git Status"
  }, {
    "<leader>gS",
    function()
      Snacks.picker.git_stash()
    end,
    desc = "Git Stash"
  }, {
    "<leader>gd",
    function()
      Snacks.picker.git_diff()
    end,
    desc = "Git Diff (Hunks)"
  }, {
    "<leader>gf",
    function()
      Snacks.picker.git_log_file()
    end,
    desc = "Git Log File"
  }, -- gh
  {
    "<leader>gi",
    function()
      Snacks.picker.gh_issue()
    end,
    desc = "GitHub Issues (open)"
  }, {
    "<leader>gI",
    function()
      Snacks.picker.gh_issue({
        state = "all"
      })
    end,
    desc = "GitHub Issues (all)"
  }, {
    "<leader>gp",
    function()
      Snacks.picker.gh_pr()
    end,
    desc = "GitHub Pull Requests (open)"
  }, {
    "<leader>gP",
    function()
      Snacks.picker.gh_pr({
        state = "all"
      })
    end,
    desc = "GitHub Pull Requests (all)"
  }, -- Grep
  {
    "<leader>sb",
    function()
      Snacks.picker.lines()
    end,
    desc = "Buffer Lines"
  }, {
    "<leader>sB",
    function()
      Snacks.picker.grep_buffers()
    end,
    desc = "Grep Open Buffers"
  }, {
    "<leader>sg",
    function()
      Snacks.picker.grep()
    end,
    desc = "Grep"
  }, {
    "<leader>sw",
    function()
      Snacks.picker.grep_word()
    end,
    desc = "Visual selection or word",
    mode = {"n", "x"}
  }, -- search
  {
    '<leader>s"',
    function()
      Snacks.picker.registers()
    end,
    desc = "Registers"
  }, {
    '<leader>s/',
    function()
      Snacks.picker.search_history()
    end,
    desc = "Search History"
  }, {
    "<leader>sa",
    function()
      Snacks.picker.autocmds()
    end,
    desc = "Autocmds"
  }, {
    "<leader>sb",
    function()
      Snacks.picker.lines()
    end,
    desc = "Buffer Lines"
  }, {
    "<leader>sc",
    function()
      Snacks.picker.command_history()
    end,
    desc = "Command History"
  }, {
    "<leader>sC",
    function()
      Snacks.picker.commands()
    end,
    desc = "Commands"
  }, {
    "<leader>sd",
    function()
      Snacks.picker.diagnostics()
    end,
    desc = "Diagnostics"
  }, {
    "<leader>sD",
    function()
      Snacks.picker.diagnostics_buffer()
    end,
    desc = "Buffer Diagnostics"
  }, {
    "<leader>sh",
    function()
      Snacks.picker.help()
    end,
    desc = "Help Pages"
  }, {
    "<leader>sH",
    function()
      Snacks.picker.highlights()
    end,
    desc = "Highlights"
  }, {
    "<leader>si",
    function()
      Snacks.picker.icons()
    end,
    desc = "Icons"
  }, {
    "<leader>sj",
    function()
      Snacks.picker.jumps()
    end,
    desc = "Jumps"
  }, {
    "<leader>sk",
    function()
      Snacks.picker.keymaps()
    end,
    desc = "Keymaps"
  }, {
    "<leader>sl",
    function()
      Snacks.picker.loclist()
    end,
    desc = "Location List"
  }, {
    "<leader>sm",
    function()
      Snacks.picker.marks()
    end,
    desc = "Marks"
  }, {
    "<leader>sM",
    function()
      Snacks.picker.man()
    end,
    desc = "Man Pages"
  }, {
    "<leader>sp",
    function()
      Snacks.picker.lazy()
    end,
    desc = "Search for Plugin Spec"
  }, {
    "<leader>sq",
    function()
      Snacks.picker.qflist()
    end,
    desc = "Quickfix List"
  }, {
    "<leader>sR",
    function()
      Snacks.picker.resume()
    end,
    desc = "Resume"
  }, {
    "<leader>su",
    function()
      Snacks.picker.undo()
    end,
    desc = "Undo History"
  }, {
    "<leader>uC",
    function()
      Snacks.picker.colorschemes()
    end,
    desc = "Colorschemes"
  }, -- LSP
  {
    "gd",
    function()
      Snacks.picker.lsp_definitions()
    end,
    desc = "Goto Definition"
  }, {
    "gD",
    function()
      Snacks.picker.lsp_declarations()
    end,
    desc = "Goto Declaration"
  }, {
    "gr",
    function()
      Snacks.picker.lsp_references()
    end,
    nowait = true,
    desc = "References"
  }, {
    "gI",
    function()
      Snacks.picker.lsp_implementations()
    end,
    desc = "Goto Implementation"
  }, {
    "gy",
    function()
      Snacks.picker.lsp_type_definitions()
    end,
    desc = "Goto T[y]pe Definition"
  }, {
    "gai",
    function()
      Snacks.picker.lsp_incoming_calls()
    end,
    desc = "C[a]lls Incoming"
  }, {
    "gao",
    function()
      Snacks.picker.lsp_outgoing_calls()
    end,
    desc = "C[a]lls Outgoing"
  }, {
    "<leader>ss",
    function()
      Snacks.picker.lsp_symbols()
    end,
    desc = "LSP Symbols"
  }, {
    "<leader>sS",
    function()
      Snacks.picker.lsp_workspace_symbols()
    end,
    desc = "LSP Workspace Symbols"
  }, -- Other
  {
    "<leader>z",
    function()
      Snacks.zen()
    end,
    desc = "Toggle Zen Mode"
  }, {
    "<leader>Z",
    function()
      Snacks.zen.zoom()
    end,
    desc = "Toggle Zoom"
  }, {
    "<leader>.",
    function()
      Snacks.scratch()
    end,
    desc = "Toggle Scratch Buffer"
  }, {
    "<leader>S",
    function()
      Snacks.scratch.select()
    end,
    desc = "Select Scratch Buffer"
  }, {
    "<leader>n",
    function()
      Snacks.notifier.show_history()
    end,
    desc = "Notification History"
  }, {
    "<leader>bd",
    function()
      Snacks.bufdelete()
    end,
    desc = "Delete Buffer"
  }, {
    "<leader>cR",
    function()
      Snacks.rename.rename_file()
    end,
    desc = "Rename File"
  }, {
    "<leader>gB",
    function()
      Snacks.gitbrowse()
    end,
    desc = "Git Browse",
    mode = {"n", "v"}
  }, {
    "<leader>gg",
    function()
      Snacks.lazygit()
    end,
    desc = "Lazygit"
  }, {
    "<leader>un",
    function()
      Snacks.notifier.hide()
    end,
    desc = "Dismiss All Notifications"
  }, {
    "<c-/>",
    function()
      Snacks.terminal()
    end,
    desc = "Toggle Terminal"
  }, {
    "<c-_>",
    function()
      Snacks.terminal()
    end,
    desc = "which_key_ignore"
  }, {
    "]]",
    function()
      Snacks.words.jump(vim.v.count1)
    end,
    desc = "Next Reference",
    mode = {"n", "t"}
  }, {
    "[[",
    function()
      Snacks.words.jump(-vim.v.count1)
    end,
    desc = "Prev Reference",
    mode = {"n", "t"}
  }, {
    "<leader>N",
    desc = "Neovim News",
    function()
      Snacks.win({
        file = vim.api.nvim_get_runtime_file("doc/news.txt", false)[1],
        width = 0.6,
        height = 0.6,
        wo = {
          spell = false,
          wrap = false,
          signcolumn = "yes",
          statuscolumn = " ",
          conceallevel = 3
        }
      })
    end
  }},
  init = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "VeryLazy",
      callback = function()
        -- Setup some globals for debugging (lazy-loaded)
        _G.dd = function(...)
          Snacks.debug.inspect(...)
        end
        _G.bt = function()
          Snacks.debug.backtrace()
        end

        -- Override print to use snacks for `:=` command
        if vim.fn.has("nvim-0.11") == 1 then
          vim._print = function(_, ...)
            dd(...)
          end
        else
          vim.print = _G.dd
        end

        -- Create some toggle matrueppings
        Snacks.toggle.option("spell", {
          name = "Spelling"
        }):map("<leader>us")
        Snacks.toggle.option("wrap", {
          name = "Wrap"
        }):map("<leader>uw")
        Snacks.toggle.option("relativenumber", {
          name = "Relative Number"
        }):map("<leader>uL")
        Snacks.toggle.diagnostics():map("<leader>ud")
        Snacks.toggle.line_number():map("<leader>ul")
        Snacks.toggle.option("conceallevel", {
          off = 0,
          on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2
        }):map("<leader>uc")
        Snacks.toggle.treesitter():map("<leader>uT")
        Snacks.toggle.option("background", {
          off = "light",
          on = "dark",
          name = "Dark Background"
        }):map("<leader>ub")
        Snacks.toggle.inlay_hints():map("<leader>uh")
        Snacks.toggle.indent():map("<leader>ug")
        Snacks.toggle.dim():map("<leader>uD")
      end
    })
  end
}}
