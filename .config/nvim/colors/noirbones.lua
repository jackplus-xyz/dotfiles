local colors_name = "noirbones"
vim.g.colors_name = colors_name -- Required when defining a colorscheme

local lush = require("lush")
local hsluv = lush.hsluv -- Human-friendly hsl
local util = require("zenbones.util")

local bg = vim.o.background

-- Define a palette. Use `palette_extend` to fill unspecified colors
local palette
if bg == "light" then
  palette = util.palette_extend({
    bg = hsluv("#f8f8f8"),
    fg = hsluv("#000000"),
    -- bg_secondary = hsluv("#e8e8e8"),
    -- fg_secondary = hsluv("#383838"),
    -- rose = hsluv("#c82829"),
    -- leaf = hsluv("#718c00"),
    -- wood = hsluv("#eab700"),
    -- water = hsluv("#3e999f"),
    -- blossom = hsluv("#8959ab"),
    -- sky = hsluv("#4271ae"),
  }, bg)
else
  palette = util.palette_extend({
    bg = hsluv("#181818"),
    -- bg_secondary = hsluv("#383838"),
    fg = hsluv("#f8f8f8"),
    -- fg_secondary = hsluv("#e8e8e8"),
    -- rose = hsluv("#ab4642"),
    -- leaf = hsluv("#a1b56c"),
    -- wood = hsluv("#f7ca88"),
    -- water = hsluv("#86c1b9"),
    -- blossom = hsluv("#BA8BAF"),
    -- sky = hsluv("#7cafc2"),
  }, bg)
end

-- Generate the lush specs using the generator util
local generator = require("zenbones.specs")
local base_specs = generator.generate(palette, bg, generator.get_global_config(colors_name, bg))

-- Optionally extend specs using Lush
local specs = lush.extends({ base_specs }).with(function()
  return {
    -- TreesitterContext({ bg = palette.bg_secondary }),
    -- NormalFloat({ bg = palette.bg_secondary }),
    -- Constant({ fg = palette.fg, gui = "regular" }),
    -- Special({ base_specs.Special, fg = palette.fg, gui = "regular" }),
    -- Identifier({ base_specs.Identifier, fg = palette.fg, gui = "regular" }),
    -- Delimiter({ base_specs.Delimiter, fg = palette.fg, gui = "regular" }),
    -- Statement({ base_specs.Statement, fg = palette.fg, gui = "regular" }),
    -- NotifyBackground({ base_specs.Statement, fg = palette.fg, bg = palette.bg, gui = "regular" }),
  }
end)

-- Pass the specs to lush to apply
lush(specs)

-- vim.api.nvim_set_hl(0, "@constant", { link = "Constant" })
-- vim.api.nvim_set_hl(0, "@type", { link = "Comment" })
-- vim.api.nvim_set_hl(0, "@variable", { link = "Comment" })

-- Optionally set term colors
require("zenbones.term").apply_colors(palette)
