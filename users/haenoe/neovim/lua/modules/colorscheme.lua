return {
    -- {
    --   -- Pretty colorscheme
    --   'ellisonleao/gruvbox.nvim',
    --   priority = 1000,
    --   config = function()
    --     require("gruvbox").setup({})
    --     vim.cmd.colorscheme "gruvbox"
    --   end,
    -- },

    -- {
    --   'catppuccin/nvim',
    --   priority = 1000,
    --   config = function()
    --     require("catppuccin").setup({
    --       flavour = "macchiato",
    --       show_end_of_buffer = true,
    --       term_colors = true,
    --       integrations = {
    --         native_lsp = {
    --           enabled = true,
    --           virtual_text = {
    --             errors = { "italic" },
    --             hints = { "italic" },
    --             warnings = { "italic" },
    --             information = { "italic" },
    --           },
    --           underlines = {
    --             errors = { "undercurl" },
    --             hints = { "undercurl" },
    --             warnings = { "undercurl" },
    --             information = { "undercurl" },
    --           },
    --           inlay_hints = {
    --             background = true,
    --           },
    --         },
    --       },
    --     })
    --
    --     vim.cmd.colorscheme "catppuccin"
    --   end
    -- },

    {
        "blazkowolf/gruber-darker.nvim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("gruber-darker")
        end,
    },

}
