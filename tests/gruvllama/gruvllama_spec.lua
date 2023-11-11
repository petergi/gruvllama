require("plenary.reload").reload_module("gruvllama", true)
local gruvllama = require("gruvllama")
local default = gruvllama.config

local function clear_term_colours()
    for item = 0, 15 do vim.g["terminal_color_" .. item] = nil end
end

describe("tests", function()
    it("works with default values", function()
        gruvllama.setup()
        assert.are.same(gruvllama.config, default)
    end)

    it("works with config overrides", function()
        local expected = {
            terminal_colors = true,
            undercurl = false,
            underline = false,
            bold = true,
            italic = {
                strings = true,
                emphasis = true,
                comments = true,
                operators = false,
                folds = true
            },
            strikethrough = true,
            inverse = true,
            invert_selection = false,
            invert_signs = false,
            invert_tabline = false,
            invert_intend_guides = false,
            contrast = "",
            palette_overrides = {},
            overrides = {},
            dim_inactive = false,
            transparent_mode = false
        }

        gruvllama.setup({undercurl = false, underline = false})
        assert.are.same(gruvllama.config, expected)
    end)

    it("should override a highlight colour", function()
        local config = {
            overrides = {
                Search = {fg = "#ff9900", bg = "#000000"},
                ColorColumn = {bg = "#ff9900"}
            }
        }

        gruvllama.setup(config)
        gruvllama.load()

        local search_group_id = vim.api.nvim_get_hl_id_by_name("Search")
        local search_values = {
            background = vim.fn.synIDattr(search_group_id, "bg", "gui"),
            foreground = vim.fn.synIDattr(search_group_id, "fg", "gui")
        }

        assert.are.same(search_values,
                        {background = "#000000", foreground = "#ff9900"})

        local colour_column_group_id = vim.api.nvim_get_hl_id_by_name(
                                           "ColorColumn")
        local colour_column_values = {
            background = vim.fn.synIDattr(colour_column_group_id, "bg", "gui")
        }

        assert.are.same(colour_column_values, {background = "#ff9900"})
    end)

    it("should create new highlight colours if they dont exist", function()
        local config = {
            overrides = {
                Search = {fg = "#ff9900", bg = "#000000"},
                New = {bg = "#ff9900"}
            }
        }

        gruvllama.setup(config)
        gruvllama.load()

        local search_group_id = vim.api.nvim_get_hl_id_by_name("Search")
        local search_values = {
            background = vim.fn.synIDattr(search_group_id, "bg", "gui"),
            foreground = vim.fn.synIDattr(search_group_id, "fg", "gui")
        }

        assert.are.same(search_values,
                        {background = "#000000", foreground = "#ff9900"})

        local new_group_id = vim.api.nvim_get_hl_id_by_name("New")
        local new_group_values = {
            background = vim.fn.synIDattr(new_group_id, "bg", "gui")
        }

        assert.are.same(new_group_values, {background = "#ff9900"})
    end)

    it("should override links", function()
        local config = {
            overrides = {TelescopePreviewBorder = {fg = "#990000", bg = nil}}
        }
        gruvllama.setup(config)
        gruvllama.load()

        local group_id = vim.api
                             .nvim_get_hl_id_by_name("TelescopePreviewBorder")
        local values = {fg = vim.fn.synIDattr(group_id, "fg", "gui")}

        local expected = {fg = "#990000"}
        assert.are.same(expected, values)
    end)

    it("should override palette", function()
        local config = {palette_overrides = {gray = "#ff9900"}}

        gruvllama.setup(config)
        gruvllama.load()

        local group_id = vim.api.nvim_get_hl_id_by_name("Comment")
        local values = {fg = vim.fn.synIDattr(group_id, "fg", "gui")}
        assert.are.same(values, {fg = "#ff9900"})
    end)

    it("does not set terminal colours when terminal_colours is false",
       function()
        clear_term_colours()
        gruvllama.setup({terminal_colors = false})
        gruvllama.load()
        assert.is_nil(vim.g.terminal_color_0)
    end)

    it("sets terminal colours when terminal_colors is true", function()
        clear_term_colours()
        gruvllama.setup({terminal_colors = true})
        gruvllama.load()

        -- dark bg
        local colours = require("lua.gruvllama").palette
        vim.opt.background = "dark"
        assert.are.same(vim.g.terminal_color_0, colours.dark0)

        -- light bg
        clear_term_colours()
        gruvllama.load()
        vim.opt.background = "light"
        assert.are.same(vim.g.terminal_color_0, colours.light0)
    end)
end)
