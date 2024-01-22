return {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",

    dependencies = { "nvim-lua/plenary.nvim", "nvim-neorg/neorg-telescope" },
    config = function()
        vim.opt.conceallevel = 3

        require("neorg").setup {
            load = {
                ["core.defaults"] = {},
                ["core.concealer"] = {
                    config = {
                        icon_preset = "diamond",
                    },
                },
                ["core.dirman"] = {
                    config = {
                        workspaces = {
                            notes = "~/notes",
                        },
                        default_workspace = "notes",
                        index = "index.norg",
                    },
                },
                ["core.summary"] = {},
                ["core.export"] = {},
                ["core.export.markdown"] = {},
                ["core.integrations.telescope"] = {},
                ["core.ui.calendar"] = {},
            },
        }
    end,
}
