return {{ -- * Treesitter
  -- Highlight, edit, and navigate code
  "nvim-treesitter/nvim-treesitter",
  event = "VeryLazy",
  build = ":TSUpdate",
  main = "nvim-treesitter.config", -- Sets main module to use for opts
  cmd = {"TSUpdateSync", "TSUpdate", "TSInstall"},
  dependencies = {"nvim-treesitter/nvim-treesitter-textobjects"},
  opts = {
    ensure_installed = {"bash", "c", "diff", "html", "lua", "luadoc", "markdown", "markdown_inline", "query", "vim",
                        "vimdoc", "rust", "regex", "php", "yaml"},
    -- Autoinstall languages that are not installed
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim"s regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = {"ruby"}
    },
    indent = {
      enable = true,
      disable = {"ruby"}
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<M-space>", -- set to `false` to disable one of the mappings
        node_incremental = "<M-space>",
        scope_incremental = false,
        node_decremental = "<Backspace>"
      }
    },
    textobjects = {
      select = {
        enable = true,

        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,

        keymaps = {
          -- You can use the capture groups defined in textobjects.scm
          ["af"] = {
            query = "@function.outer",
            desc = "Select outer part of a function region"
          },
          ["if"] = {
            query = "@function.inner",
            desc = "Select inner part of a function region"
          },
          ["ac"] = {
            query = "@class.outer",
            desc = "Select outer part of a class region"
          },
          ["ic"] = {
            query = "@class.inner",
            desc = "Select inner part of a class region"
          },
          -- You can also use captures from other query groups like `locals.scm`
          ["as"] = {
            query = "@local.scope",
            query_group = "locals",
            desc = "Select language scope"
          }
        }
      },
      swap = {
        enable = true,
        swap_next = {
          ["<leader>xs"] = {
            query = "@parameter.inner",
            desc = "Swap the node under the cursor with the next"
          }
        },
        swap_previous = {
          ["<leader>xS"] = {
            query = "@parameter.inner",
            desc = "swap the node under the cursor with the previous"
          }
        }
      }
    }
  }
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  --
  --    - Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  --    - Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  --    - Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
}, { -- * Conform Formatter
  'stevearc/conform.nvim',
  opts = {
    formatters_by_ft = {
      lua = {"stylua"},
      -- Conform will run multiple formatters sequentially
      python = {"stylua", "black"},
      -- You can customize some of the format options for the filetype (:help conform.format)
      rust = {
        "rustfmt",
        lsp_format = "fallback"
      },
      -- Conform will run the first available formatter
      javascript = {
        "prettierd",
        "prettier",
        stop_after_first = true
      }
    }
  }
}, { -- * Mason
  'mason-org/mason.nvim',
  opts = {
    ui = {
      icons = {
        package_installed = "󱢺",
        package_pending = "󰚰",
        package_uninstalled = "󱢻"
      }
    }
  }
}, { -- * Mason LSP Config
  "mason-org/mason-lspconfig.nvim",
  opts = {
    automatic_enable = true,
    ensure_installed = {}
  },
  dependencies = {"mason-org/mason.nvim", "neovim/nvim-lspconfig"}
}, { -- * Mason null-ls
  "jay-babu/mason-null-ls.nvim",
  event = {"BufReadPre", "BufNewFile"},
  dependencies = {"williamboman/mason.nvim", "nvimtools/none-ls.nvim"},
  opts = {
    ensure_installed = {"clippy", "pylint", "cppcheck", "markdownlint", "pyright", "clangd", "prettierd", "prettier",
                        "black", "codelldb", "rust_analyzer", "stylua", "lual"}
  }
}, {"mfussenegger/nvim-dap"}, {"jay-babu/mason-nvim-dap.nvim"}, { -- * Mason Tool Installer
  'WhoIsSethDaniel/mason-tool-installer.nvim',
  opts = {
    ensure_installed = {},
    auto_update = true,
    run_on_start = true,
    debounce_hours = 5,
    integrations = {
      ['mason-lspconfig'] = true,
      ['mason-null-ls'] = true,
      ['mason-nvim-dap'] = true
    }
  }
}, { -- * Fidget
  'j-hui/fidget.nvim',
  opts = {}
}, -- Allows extra capabilities provided by blink.cmp
{ -- * Blink
  -- For some reason the config below fixed some lua warnings...
  'saghen/blink.cmp',
  event = 'InsertEnter',
  version = '1.*',
  dependencies = { -- Snippet Engine
  { -- * LuaSnip
    'L3MON4D3/LuaSnip',
    version = '2.*',
    build = (function()
      -- Build Step is needed for regex support in snippets.
      -- This step is not supported in many windows environments.
      -- Remove the below condition to re-enable on windows.
      if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
        return
      end
      return 'make install_jsregexp'
    end)(),
    dependencies = { -- `friendly-snippets` contains a variety of premade snippets.
    --    See the README about individual language/framework/plugin snippets:
    --    https://github.com/rafamadriz/friendly-snippets
    { -- * friendly-snippets
      'rafamadriz/friendly-snippets',
      config = function()
        require('luasnip.loaders.from_vscode').lazy_load()
      end
    }},
    opts = {}
  }, 'folke/lazydev.nvim', 'Exafunction/codeium.nvim'},
  --- @module 'blink.cmp'
  --- @type blink.cmp.Config
  opts = {
    keymap = {
      -- 'default' (recommended) for mappings similar to built-in completions
      --   <c-y> to accept ([y]es) the completion.
      --    This will auto-import if your LSP supports it.
      --    This will expand snippets if the LSP sent a snippet.
      -- 'super-tab' for tab to accept
      -- 'enter' for enter to accept
      -- 'none' for no mappings
      --
      -- For an understanding of why the 'default' preset is recommended,
      -- you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --
      -- All presets have the following mappings:
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      --
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = 'default',
      ["<Enter>"] = {"accept", "fallback"}

      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },

    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned
      nerd_font_variant = 'mono'
    },

    completion = {
      -- By default, you may press `<c-space>` to show the documentation.
      -- Optionally, set `auto_show = true` to show the documentation after a delay.
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500
      },
      -- nvim-highlight-colors plugin integration 
      menu = {
        draw = {
          components = {
            -- customize the drawing of kind icons
            kind_icon = {
              text = function(ctx)
                -- default kind icon
                local icon = ctx.kind_icon
                -- if LSP source, check for color derived from documentation
                if ctx.item.source_name == "LSP" then
                  local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, {
                    kind = ctx.kind
                  })
                  if color_item and color_item.abbr ~= "" then
                    icon = color_item.abbr
                  end
                end
                return icon .. ctx.icon_gap
              end,
              highlight = function(ctx)
                -- default highlight group
                local highlight = "BlinkCmpKind" .. ctx.kind
                -- if LSP source, check for color derived from documentation
                if ctx.item.source_name == "LSP" then
                  local color_item = require("nvim-highlight-colors").format(ctx.item.documentation, {
                    kind = ctx.kind
                  })
                  if color_item and color_item.abbr_hl_group then
                    highlight = color_item.abbr_hl_group
                  end
                end
                return highlight
              end
            }
          }
        }
      }
    },

    sources = {
      -- default = { 'lsp', 'path', 'snippets', 'buffer' },
      default = {'lsp', 'path', 'snippets', 'lazydev'},
      providers = {
        lazydev = {
          module = 'lazydev.integrations.blink',
          score_offset = 100
        },
        codeium = {
          name = 'Codeium',
          module = 'codeium.blink',
          async = true
        }
      }
    },

    snippets = {
      preset = 'luasnip'
    },

    -- Blink.cmp includes an optional, recommended rust fuzzy matcher,
    -- which automatically downloads a prebuilt binary when enabled.
    --
    -- By default, we use the Lua implementation instead, but you may enable
    -- the rust implementation via `'prefer_rust_with_warning'`
    --
    -- See :h blink-cmp-config-fuzzy for more information
    fuzzy = {
      implementation = 'prefer_rust_with_warning'
    },

    -- Shows a signature help window while you type arguments for a function
    signature = {
      enabled = true
    }
  }
}, { -- * nvim-lspconfig
  'neovim/nvim-lspconfig',
  event = "VeryLazy",
  dependencies = {'mason-org/mason.nvim', 'mason-org/mason-lspconfig.nvim', 'WhoIsSethDaniel/mason-tool-installer.nvim',
                  'j-hui/fidget.nvim', 'saghen/blink.cmp'},
  config = function()
    -- Brief aside: **What is LSP?**
    --
    -- LSP is an initialism you've probably heard, but might not understand what it is.
    --
    -- LSP stands for Language Server Protocol. It's a protocol that helps editors
    -- and language tooling communicate in a standardized fashion.
    --
    -- In general, you have a "server" which is some tool built to understand a particular
    -- language (such as `gopls`, `lua_ls`, `rust_analyzer`, etc.). These Language Servers
    -- (sometimes called LSP servers, but that's kind of like ATM Machine) are standalone
    -- processes that communicate with some "client" - in this case, Neovim!
    --
    -- LSP provides Neovim with features like:
    --  - Go to definition
    --  - Find references
    --  - Autocompletion
    --  - Symbol Search
    --  - and more!
    --
    -- Thus, Language Servers are external tools that must be installed separately from
    -- Neovim. This is where `mason` and related plugins come into play.
    --
    -- If you're wondering about lsp vs treesitter, you can check out the wonderfully
    -- and elegantly composed help section, `:help lsp-vs-treesitter`

    --  This function gets run when an LSP attaches to a particular buffer.
    --    That is to say, every time a new file is opened that is associated with
    --    an lsp (for example, opening `main.rs` is associated with `rust_analyzer`) this
    --    function will be executed to configure the current buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', {
        clear = true
      }),
      callback = function(event)
        -- NOTE: Remember that Lua is a real programming language, and as such it is possible
        -- to define small helper and utility functions so you don't have to repeat yourself.
        --
        -- In this case, we create a function that lets us more easily define mappings specific
        -- for LSP related items. It sets the mode, buffer and description for us each time.
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, {
            buffer = event.buf,
            desc = 'LSP: ' .. desc
          })
        end

        -- Rename the variable under your cursor.
        --  Most Language Servers support renaming across files, etc.
        map('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute a code action, usually your cursor needs to be on top of an error
        -- or a suggestion from your LSP for this to activate.
        map('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction', {'n', 'x'})

        map('<leader>cd', vim.lsp.buf.hover, '[C]ode [D]ocumentation', {'n', 'x'})

        -- Find references for the word under your cursor.
        map('gr', function()
          Snacks.picker.lsp_references()
        end, '[G]oto [R]eferences')

        -- Jump to the implementation of the word under your cursor.
        --  Useful when your language has ways of declaring types without an actual implementation.
        map('gI', function()
          Snacks.picker.lsp_implementations()
        end, '[G]oto [I]mplementation')

        -- Jump to the definition of the word under your cursor.
        --  This is where a variable was first declared, or where a function is defined, etc.
        --  To jump back, press <C-t>.
        map('gd', function()
          Snacks.picker.lsp_definitions()
        end, '[G]oto [D]efinition')

        -- WARN: This is not Goto Definition, this is Goto Declaration.
        --  For example, in C this would take you to the header.
        map('gD', function()
          Snacks.picker.lsp_declarations()
        end, '[G]oto [D]eclaration')

        -- Fuzzy find all the symbols in your current document.
        --  Symbols are things like variables, functions, types, etc.
        map('<leader>ds', function()
          Snacks.picker.lsp_symbols()
        end, 'Open [D]ocument [S]ymbols')

        -- Fuzzy find all the symbols in your current workspace.
        --  Similar to document symbols, except searches over your entire project.
        map('<leader>ws', function()
          Snacks.picker.lsp_workspace_symbols()
        end, 'Open [W]orkspace [S]ymbols')

        -- Jump to the type of the word under your cursor.
        --  Useful when you're not sure what type a variable is and you want to see
        --  the definition of its *type*, not where it was *defined*.
        map('gt', function()
          Snacks.picker.lsp_type_definitions()
        end, '[G]oto [T]ype Definition')

        -- This function resolves a difference between neovim nightly (version 0.11) and stable (version 0.10)
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, {
              bufnr = bufnr
            })
          end
        end

        -- The following two autocommands are used to highlight references of the
        -- word under your cursor when your cursor rests there for a little while.
        --    See `:help CursorHold` for information about when this is executed
        --
        -- When you move your cursor, the highlights will be cleared (the second autocommand).
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', {
            clear = false
          })
          vim.api.nvim_create_autocmd({'CursorHold', 'CursorHoldI'}, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight
          })

          vim.api.nvim_create_autocmd({'CursorMoved', 'CursorMovedI'}, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references
          })

          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', {
              clear = true
            }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds {
                group = 'kickstart-lsp-highlight',
                buffer = event2.buf
              }
            end
          })
        end

        -- The following code creates a keymap to toggle inlay hints in your
        -- code, if the language server you are using supports them
        --
        -- This may be unwanted, since they displace some of your code
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled {
              bufnr = event.buf
            })
          end, '[T]oggle Inlay [H]ints')
        end
      end
    })

    -- Diagnostic Config
    -- See :help vim.diagnostic.Opts
    vim.diagnostic.config {
      severity_sort = true,
      float = {
        border = 'rounded',
        source = 'if_many'
      },
      -- underline = { severity = vim.diagnostic.severity.ERROR },
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = ' ',
          [vim.diagnostic.severity.WARN] = ' ',
          [vim.diagnostic.severity.INFO] = ' ',
          [vim.diagnostic.severity.HINT] = ' '
        }
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message
          }
          return diagnostic_message[diagnostic.severity]
        end
      }
    }

    -- LSP servers and clients are able to communicate to each other what features they support.
    --  By default, Neovim doesn't support everything that is in the LSP specification.
    --  When you add blink.cmp, luasnip, etc. Neovim now has *more* capabilities.
    --  So, we create new capabilities with blink.cmp, and then broadcast that to the servers.
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Enable the following language servers
    --  Feel free to add/remove any LSPs that you want here. They will automatically be installed.
    --
    --  Add any additional override configuration in the following tables. Available keys are:
    --  - cmd (table): Override the default command used to start the server
    --  - filetypes (table): Override the default list of associated filetypes for the server
    --  - capabilities (table): Override fields in capabilities. Can be used to disable certain LSP features.
    --  - settings (table): Override the default settings passed when initializing the server.
    --        For example, to see the options for `lua_ls`, you could go to: https://luals.github.io/wiki/settings/

    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = {
              callSnippet = 'Replace'
            },
            -- Following runtime, diagnostics & workspace are needed
            -- to explicitly disable lua 'undefined globals' warnings 
            runtime = {
              -- Tell the language server which version of Lua you're using (most likely LuaJIT in the case of Neovim)
              version = "LuaJIT"
            },
            diagnostics = {
              -- Get the language server to recognize the `vim` global
              globals = {"vim"},
              disable = {'missing-fields', 'undefined-field'}
            },
            workspace = {
              -- Make the server aware of Neovim runtime files
              library = vim.api.nvim_get_runtime_file("", true)
            },
            -- Do not send telemetry data containing a randomized but unique identifier
            telemetry = {
              enable = false
            }
          }
        }
      }
    }
    -- Now setup those configurations
    for name, config in pairs(servers) do
      local config = config or {}
      -- This handles overriding only values explicitly passed
      -- by the server configuration above. Useful when disabling
      -- certain features of an LSP (for example, turning off formatting for ts_ls)
      config.capabilities = vim.tbl_deep_extend('force', {}, capabilities, config.capabilities or {})
      vim.lsp.config(name, config)
    end

    -- Ensure the servers and tools above are installed
    --
    -- To check the current status of installed tools and/or manually install
    -- other tools, you can run
    --    :Mason
    --
    -- You can press `g?` for help in this menu.
    --
    -- `mason` had to be setup earlier: to configure its options see the
    -- `dependencies` table for `nvim-lspconfig` above.
    --
    -- You can add other tools here that you want Mason to install
    -- for you, so that they are available from within Neovim.
    -- local ensure_installed = vim.tbl_keys(servers or {})
    -- vim.list_extend(ensure_installed, {'stylua'})

    -- require('mason-tool-installer').setup {
    --   ensure_installed = ensure_installed
    -- }

    -- require('mason-lspconfig').setup {}
  end
}, { -- * nvim-dap
  'mfussenegger/nvim-dap',
  config = function()
    local dap, dapui = require("dap"), require("dapui")
    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    dap.adapters.lldb = {
      type = 'executable',
      command = '/usr/bin/codelldb',
      name = "lldb"
    }

    dap.configurations.rust = {{
      name = "Launch Rust Program",
      type = "lldb",
      request = "launch",
      program = function()
        return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/target/debug/your_program_name')
      end,
      cwd = '${workspaceFolder}',
      stopOnEntry = false
    }}

    vim.keymap.set('n', '<F5>', dap.continue) -- Start or continue debugging
    vim.keymap.set('n', '<F10>', dap.step_over) -- Step over
    vim.keymap.set('n', '<F11>', dap.step_into) -- Step into
    vim.keymap.set('n', '<F12>', dap.step_out) -- Step out
    vim.keymap.set('n', '<F9>', dap.toggle_breakpoint) -- Toggle breakpoint

    vim.keymap.set("n", "<Leader>dl", dap.step_into, {
      desc = "Debugger step into"
    })
    vim.keymap.set("n", "<Leader>dj", dap.step_over, {
      desc = "Debugger step over"
    })
    vim.keymap.set("n", "<Leader>dk", dap.step_out, {
      desc = "Debugger step out"
    })
    vim.keymap.set("n", "<Leader>dc", dap.continue, {
      desc = "Debugger continue"
    })
    vim.keymap.set("n", "<Leader>db", dap.toggle_breakpoint, {
      desc = "Debugger toggle breakpoint"
    })
    vim.keymap.set("n", "<Leader>dd", dap.set_breakpoint, {
      desc = "Debugger set conditional breakpoint"
    })
    vim.keymap.set("n", "<Leader>de", dap.terminate, {
      desc = "Debugger reset"
    })
    vim.keymap.set("n", "<Leader>dr", dap.run_last, {
      desc = "Debugger run last"
    })

  end
}, { -- * nvim-dap-ui
  'rcarriga/nvim-dap-ui',
  dependencies = {"mfussenegger/nvim-dap", "nvim-neotest/nvim-nio"},
  config = function()
    require("dapui").setup()
  end
}, { -- * crates
  'saecki/crates.nvim',
  ft = {"toml"},
  config = function()
    require("crates").setup {
      completion = {
        cmp = {
          enabled = true
        }
      }
    }
    require('cmp').setup.buffer({
      sources = {{
        name = "crates"
      }}
    })
  end
}}
