return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Rich deep background with subtle blue tint
      local bg = "#0D1117"
      local bg_dark = "#0A0E14"
      local bg_highlight = "#1A2333"
      local bg_search = "#3B5380"
      local bg_visual = "#2E3C52"
      local fg = "#E1E4EA"
      local fg_dark = "#CDD3DE"
      local fg_gutter = "#627E97"
      local border = "#3B4261"

      -- Enhanced syntax colors for better contrast and readability
      local keyword_color = "#79B8FF" -- Vibrant blue for keywords
      local type_color = "#4EC9B0" -- Teal for types (int, void)
      --local variable_color = "#9FBBF3" -- Soft blue for variables
      local variable_color = "#00FFFF" -- Cyan for variables
      local struct_member_color = "#36CCA8" -- Mint green for struct members
      local function_color = "#F4D35E" -- Rich gold for functions
      local string_color = "#E9967A" -- Warm salmon for strings
      local comment_color = "#7C9A78" -- Muted sage green for comments
      local number_color = "#F0C674" -- Amber for numbers
      --local operator_color = "#E1E4EA" -- Light gray for operators
      local bracket_color = "#00FFFF" -- cyan for operators
      local builtin_function = "#90EE90" -- Green color for builtin_function
      local operator_color = "#DA70D6" -- operator_color

      --HTML , js Tags related variables
      local tag_color = "#4682B4" -- Steel blue
      local tag_name_color = "#5F9EA0" -- Cadet blue
      local attr_color = "#008080" -- teel blue
      local attr_value_color = "#32CD32" -- Lime green

      require("tokyonight").setup({
        style = "night",
        transparent = true, -- solid background for better readability
        on_colors = function(colors)
          colors.bg = bg
          colors.bg_dark = bg_dark
          colors.bg_float = bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = bg_dark
          colors.bg_statusline = bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark
        end,
        on_highlights = function(highlights, colors)
          -- Enhanced syntax highlighting
          highlights.cType = { fg = type_color, bold = true } -- Types with bold for emphasis
          highlights.cStructure = { fg = keyword_color, bold = true } -- struct keyword
          highlights.cStorageClass = { fg = type_color } -- static, extern
          highlights.cInclude = { fg = keyword_color } -- #include

          -- Variable and struct member colors with clear distinction
          highlights.cVariable = { fg = variable_color }
          highlights["@variable"] = { fg = variable_color }
          highlights["@variable.c"] = { fg = variable_color }

          -- Make struct members stand out
          highlights["@field.c"] = { fg = struct_member_color }
          highlights["@property"] = { fg = struct_member_color }

          -- Function colors with subtle emphasis
          highlights.cFunction = { fg = function_color, italic = false }
          highlights["@function"] = { fg = function_color, italic = false }
          highlights["@function.call"] = { fg = function_color, italic = false }
          -- Builtin function colors
          highlights["@function.builtin"] = { fg = builtin_function }

          -- String colors with enhanced readability
          highlights.cString = { fg = string_color }
          highlights["@string"] = { fg = string_color }

          -- Comments that are easier to read
          highlights.Comment = { fg = comment_color, italic = true }
          highlights["@comment"] = { fg = comment_color, italic = true }

          -- Operators and syntax characters
          --highlights.cOperator = { fg = operator_color }
          --highlights.Delimiter = { fg = operator_color }
          --highlights.cBraces = { fg = operator_color }
          --highlights.cParens = { fg = operator_color }
          highlights["@operator"] = { fg = operator_color }

          -- Braces, brackets, parentheses
          highlights["@punctuation.bracket"] = { fg = bracket_color } -- for (), [], {}
          highlights["@punctuation.delimiter"] = { fg = bracket_color } -- for ; , .
          highlights.Delimiter = { fg = bracket_color } -- fallback
          highlights["@punctuation.special"] = { fg = "#00BFFF" } -- DeepSkyBlue for `->`, `::`, `=>`

          -- HTML Tags <>
          highlights["@tag"] = { fg = tag_color, bold = true }
          highlights["@tag.delimiter"] = { fg = attr_color } -- < or />
          highlights["@tag.attribute"] = { fg = bracket_color }
          highlights["@tag.name"] = { fg = tag_name_color }
          highlights["@string.html"] = { fg = attr_value_color } -- values inside ""
          highlights["@type.tag"] = { fg = tag_color } -- when tags are treated as types

          -- Keywords with emphasis
          highlights["@keyword"] = { fg = keyword_color }
          highlights["@keyword.c"] = { fg = keyword_color }
          highlights["@conditional.c"] = { fg = keyword_color }
          highlights["@repeat.c"] = { fg = keyword_color }

          -- Numbers
          highlights.cNumber = { fg = number_color }
          highlights["@number"] = { fg = number_color }

          -- Enhanced cursor and navigation
          highlights.Cursor = { bg = "#F2F4F8", fg = "#0D1117" } -- High-contrast cursor
          highlights.iCursor = { bg = "#E9967A", fg = "#0D1117" } -- Different color for insert mode
          highlights.vCursor = { bg = "#F4D35E", fg = "#0D1117" } -- Different color for visual mode
          highlights.CursorLine = { bg = "#1A2333" } -- Subtle line highlighting

          -- Make current line number stand out
          highlights.CursorLineNr = { fg = "#F2F4F8", bold = true }

          -- Search highlighting
          highlights.Search = { bg = "#3B5380", fg = "#F2F4F8" }

          -- Matching parentheses
          highlights.MatchParen = { bg = "#35495E", fg = "#F2F4F8", bold = true }
        end,
      })

      -- Load the colorscheme
      vim.cmd([[colorscheme tokyonight]])

      -- Additional quality-of-life settings
      vim.o.synmaxcol = 240 -- Only highlight 240 columns for better performance
      vim.o.lazyredraw = true -- Don't redraw while executing macros
      vim.o.ttyfast = true -- Faster terminal redraw
    end,
  },
}
