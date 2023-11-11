<div align="center">
      <h1> <img src="https://i.postimg.cc/WpQzgxVh/plugin-Icon.png" width="80px"><br/>gruvllama.nvim</h1>
     </div>
<p align="center">
      <a href="https://twitter.com/intent/user?screen_name=petergi" target="_blank"><img alt="Twitter Follow" src="https://img.shields.io/twitter/follow/petergi?style=for-the-badge" style="vertical-align:center" ></a>
      <a href="#"><img alt="Made with Lua" src="https://img.shields.io/badge/Made%20with%20Lua-blueviolet.svg?style=for-the-badge&logo=lua" style="vertical-align:center" /></a>
</p>

My personal tweaked version of the amazing gruvbox theme found here (use it, it's far better than mine): [https://github.com/ellisonleao/gruvbox.nvim](https://github.com/ellisonleao/gruvbox.nvim)

<p align="center">
    <img src="https://i.postimg.cc/fy3tnGFt/gruvllama-themes.png" />
</p>

# Prerequisites

Neovim 0.9.0+

# Installing

## Using `packer`

```lua
use { "petergi/gruvllama.nvim" }
```

## Using `lazy.nvim`

```lua
{ "petergi/gruvllama.nvim", priority = 1000 , config = true, opts = ...}
```

# Basic Usage

Inside `init.vim`

```vim
set background=dark " or light if you want light mode
colourscheme gruvllama
```

Inside `init.lua`

```lua
vim.o.background = "dark" -- or "light" for light mode
vim.cmd([[colourscheme gruvllama]])
```

# Configuration

Additional settings for gruvllama are:

```lua
-- Default options:
require("gruvllama").setup({
  terminal_colours = true, -- add neovim terminal colors
  undercurl = true,
  underline = true,
  bold = true,
  italic = {
    strings = true,
    emphasis = true,
    comments = true,
    operators = false,
    folds = true,
  },
  strikethrough = true,
  invert_selection = false,
  invert_signs = false,
  invert_tabline = false,
  invert_intend_guides = false,
  inverse = true, -- invert background for search, diffs, statuslines and errors
  contrast = "", -- can be "hard", "soft" or empty string
  palette_overrides = {},
  overrides = {},
  dim_inactive = false,
  transparent_mode = false,
})
vim.cmd("colourscheme gruvllama")
```

**VERY IMPORTANT**: Make sure to call setup() **BEFORE** calling the colourscheme command, to use your custom configs

## Overriding

### Palette

You can specify your own palette colours. For example:

```lua
require("gruvllama").setup({
    palette_overrides = {
        bright_green = "#990000",
    }
})
vim.cmd("colourscheme gruvllama")
```

### Highlight groups

If you don't enjoy the current colour for a specific highlight group, now you can just override it in the setup. For
example:

```lua
require("gruvllama").setup({
    overrides = {
        SignColumn = {bg = "#ff9900"}
    }
})
vim.cmd("colourscheme gruvllama")
```

It also works with treesitter groups and lsp semantic highlight tokens

```lua
require("gruvllama").setup({
    overrides = {
        ["@lsp.type.method"] = { bg = "#ff9900" },
        ["@comment.lua"] = { bg = "#000000" },
    }
})
vim.cmd("colourscheme gruvllama")
```
