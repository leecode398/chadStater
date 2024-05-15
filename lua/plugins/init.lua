local overrides = require "configs.overrides"
return {
    {
        "stevearc/conform.nvim",
        -- event = 'BufWritePre', -- uncomment for format on save
        config = function()
            require "configs.conform"
        end,
    },

    -- These are some examples, uncomment them if you want to see them work!
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            -- format & linting
            {
                "jose-elias-alvarez/null-ls.nvim",
                config = function()
                    require "configs.null-ls"
                end,
            },
        },
        config = function()
            -- require("configs.lspconfig_default").defaults()
            require "configs.lspconfig"
        end,
    },
    {
        "nvim-telescope/telescope.nvim",
        cmd = "Telescope",

        opts = overrides.telescope,
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "telescope")
            local telescope = require "telescope"
            telescope.setup(opts)

            -- load extensions
            for _, ext in ipairs(opts.extensions_list) do
                telescope.load_extension(ext)
            end
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        event = "InsertEnter",
        dependencies = {
            {
                -- snippet plugin
                "L3MON4D3/LuaSnip",
                dependencies = "rafamadriz/friendly-snippets",
                config = function()
                    overrides.luasnip()
                end,
            },

            -- autopairing of (){}[] etc
            {
                "windwp/nvim-autopairs",
                opts = {
                    fast_wrap = {},
                    disable_filetype = { "TelescopePrompt", "vim" },
                },
                config = function(_, opts)
                    require("nvim-autopairs").setup(opts)

                    -- setup cmp for autopairs
                    local cmp_autopairs = require "nvim-autopairs.completion.cmp"
                    require("cmp").event:on("confirm_done", cmp_autopairs.on_confirm_done())
                end,
            },

            -- cmp sources plugins
            {
                "saadparwaiz1/cmp_luasnip",
                "hrsh7th/cmp-nvim-lua",
                "hrsh7th/cmp-nvim-lsp",
                "hrsh7th/cmp-buffer",
                "hrsh7th/cmp-path",
            },
        },

        opts = function()
            return require "configs.cmp"
        end,
        config = function(_, opts)
            require("cmp").setup(opts)
        end,
    },
    {
        "nvim-tree/nvim-tree.lua",
        opts = overrides.nvimtree,
    },
    {
        "williamboman/mason.nvim",
        opts = overrides.mason,
    },
    {
        "lewis6991/gitsigns.nvim",
        ft = "gitcommit",
        init = function()
            -- load gitsigns only when a git file is opened
            vim.api.nvim_create_autocmd({ "BufRead" }, {
                group = vim.api.nvim_create_augroup("GitSignsLazyLoad", { clear = true }),
                callback = function()
                    vim.fn.system("git -C " .. vim.fn.expand "%:p:h" .. " rev-parse")
                    if vim.v.shell_error == 0 then
                        vim.api.nvim_del_augroup_by_name "GitSignsLazyLoad"
                        vim.schedule(function()
                            require("lazy").load { plugins = { "gitsigns.nvim" } }
                        end)
                    end
                end,
            })
        end,
        opts = function()
            return overrides.gitsigns
        end,
        config = function(_, opts)
            dofile(vim.g.base46_cache .. "git")
            require("gitsigns").setup(opts)
        end,
    },
    { "mbriggs/mark.vim",   lazy = false },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = overrides.treesitter,
    },
    { "github/copilot.vim", branch = "release", lazy = false },
    {
        "phaazon/hop.nvim",
        branch = "v2", -- optional but strongly recommended
        lazy = false,
        config = function()
            -- you can configure Hop the way you like here; see :h hop-config
            require("hop").setup { keys = "etovxqpdygfblzhckisuran" }
        end,
    },
    {
        "akinsho/toggleterm.nvim",
        lazy = false,
        config = function()
            require "configs.toggleterm"
        end,
    },
    -- {
    --     "LintaoAmons/scratch.nvim",
    --     lazy = false,
    --     --config = function()
    --     --require("scratch").setup {
    --     --filetypes = { "json", "xml", "go", "lua", "log", "py", "sh" },
    --     --}
    --     --end,
    -- },
    { "tpope/vim-repeat", lazy = false },
    {
        "rafamadriz/friendly-snippets",
        lazy = false,
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    {
        "smoka7/multicursors.nvim",
        event = "VeryLazy",
        dependencies = {
            "smoka7/hydra.nvim",
        },
        opts = {},
        cmd = { "MCstart", "MCvisual", "MCclear", "MCpattern", "MCvisualPattern", "MCunderCursor" },
        keys = {
            {
                mode = { "v", "n" },
                "<Leader>m",
                "<cmd>MCstart<cr>",
                desc = "Create a selection for selected text or word under the cursor",
            },
        },
    },
    {
        "folke/todo-comments.nvim",
        lazy = false,
        config = function()
            require "configs.todo-comments"
        end,
    },
    {
        "Shatur/neovim-session-manager",
        lazy = false,
        config = function()
            require "configs.session-manager"
        end,
    },
    {
        "Pocco81/true-zen.nvim",
        lazy = false,
        config = function()
            require("true-zen").setup {
                -- your config goes here
                -- or just leave it empty :)
            }
        end,
    },
    { "preservim/tagbar", lazy = false },
    --{ "ddollar/nerdcommenter", lazy = false },
    {
        "numToStr/Comment.nvim",
        opts = {
            toggler = {
                ---Line-comment toggle keymap
                line = "gc",
                ---Block-comment toggle keymap
                --[[ block = ",cc", ]]
            },
            opleader = {
                ---Line-comment keymap
                line = "gc",
                ---Block-comment keymap
                --[[ block = ",cc", ]]
            },
            -- add any options here
        },
        lazy = false,
    },
    { "tpope/vim-fugitive", lazy = false },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup {
                -- Configuration here, or leave empty to use defaults
            }
        end,
    },
    {
        "folke/trouble.nvim",
        lazy = false,
        requires = "nvim-tree/nvim-web-devicons",
        config = function()
            require("trouble").setup {
                -- your configuration comes here
                -- or leave it empty to use the default settings
                -- refer to the configuration section below
            }
        end,
    },
    {
        "jghauser/fold-cycle.nvim",
        config = function()
            require("fold-cycle").setup {
                open_if_max_closed = true, -- closing a fully closed fold will open it
                close_if_max_opened = true, -- opening a fully open fold will close it
                softwrap_movement_fix = false, -- see below
            }
        end,
    },
}
