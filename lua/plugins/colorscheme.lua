--- Holds plugins which adds colorschemes
return {
  -- OneNord :: Mix of Nord and Atom One Dark
  {
    "rmehri01/onenord.nvim",
    opts = function()
      local gen = require("libs.statusline.generate")

      -- Source: https://github.com/rmehri01/onenord.nvim/blob/main/lua/onenord/colors/onenord.lua
      local colors = {
        fg = "#C8D0E0",
        fg_light = "#E5E9F0",
        bg = "#2C303A",
        bg_dark = "2E3440",
        bg_light = "#363C4A",
        gray = "#646A76",
        gray_light = "#6C7A96",
        cyan = "#88C0D0",
        teal = "#6484A4",
        blue = "#81A1C1",
        blue_dark = "#5E81AC",
        green = "#A3BE8C",
        green_light = "#8FBCBB",
        red = "#D57780",
        red_dark = "#BF616A",
        red_light = "#DE878F",
        pink = "#E85B7A",
        pink_dark = "#E44675",
        orange = "#D08F70",
        yellow = "#EBCB8B",
        purple = "#B988B0",
        purple_light = "#B48EAD",
      }

      local hls = {
        custom_highlights = {
          --- Telescope
          -- General
          TelescopeNormal = { fg = colors.fg, bg = colors.bg },
          TelescopeBorder = { fg = colors.bg, bg = colors.bg },
          TelescopeSelection = { fg = colors.cyan, bg = colors.bg },
          TelescopeSelectionCaret = { fg = colors.cyan, bg = colors.bg },
          -- Preview
          TelescopePreviewBorder = { fg = colors.bg, bg = colors.bg },
          TelescopePreviewTitle = { fg = "#0D1416", bg = colors.cyan },
          -- Prompt
          TelescopePromptBorder = { fg = colors.bg_light, bg = colors.bg_light },
          TelescopePromptNormal = { fg = colors.fg, bg = colors.bg_light },
          TelescopePromptPrefix = { fg = colors.red, bg = colors.bg_light },
          TelescopePromptTitle = { fg = "#0E0405", bg = colors.red },
          -- Results
          TelescopeResultsTitle = { fg = "#1D0C05", bg = colors.orange },
          TelescopeResultsBorder = { fg = colors.bg, bg = colors.bg },
          TelescopeResultsDiffAdd = { fg = colors.green, bg = "#394E3D" },
          TelescopeResultsDiffChange = { fg = colors.dark_blue, bg = "#39495D" },
          TelescopeResultsDiffDelete = { fg = colors.red, bg = "#4D2B2E" },
        },
      }

      local hls_extra = {
        StatusLine = { bg = colors.bg_dark },
      }

      local function hl_mode(mode, color, theme)
        hls_extra["St_" .. mode .. "Mode"] = { fg = theme.bg, bg = color, bold = true }
        hls_extra["St_" .. mode .. "ModeSep"] = { fg = color, bg = theme.gray }
      end

      local function hl_other(name, opts)
        hls_extra["St_" .. name] = opts
      end

      -- VIM-modes
      hl_mode("Normal", colors.blue, colors)
      hl_mode("Visual", colors.cyan, colors)
      hl_mode("Insert", colors.purple, colors)
      hl_mode("Terminal", colors.green, colors)
      hl_mode("NTerminal", colors.yellow, colors)
      hl_mode("Replace", colors.orange, colors)
      hl_mode("Confirm", colors.teal, colors)
      hl_mode("Command", colors.green, colors)
      hl_mode("Select", colors.blue, colors)

      -- Components
      hl_other("file", { fg = colors.fg, bg = colors.bg_light })
      hl_other("file_sep", { fg = colors.bg_light, bg = colors.bg_dark })
      hl_other("gitIcons", { fg = colors.gray_light, bg = colors.bg_dark })
      hl_other("EmptySpace", { fg = colors.gray, bg = colors.bg_light })
      hl_other("Lsp", { fg = colors.blue, bg = colors.bg_dark })
      hl_other("LspMsg", { fg = colors.green, bg = colors.bg_dark })
      hl_other("lspError", { fg = colors.red, bg = colors.bg_dark })
      hl_other("lspWarning", { fg = colors.yellow, bg = colors.bg_dark })
      hl_other("LspHints", { fg = colors.purple, bg = colors.bg_dark })
      hl_other("LspInfo", { fg = colors.green, bg = colors.bg_dark })
      hl_other("cwd_text", { fg = colors.fg, bg = colors.bg_light })
      hl_other("cwd_icon", { fg = colors.bg_light, bg = colors.red })
      hl_other("cwd_sep", { fg = colors.red, bg = colors.bg_dark })
      hl_other("pos_sep", { fg = colors.green, bg = colors.bg })
      hl_other("pos_icon", { fg = colors.bg_light, bg = colors.green })
      hl_other("pos_text", { fg = colors.green, bg = colors.bg_light })

      gen.append_to_table(hls.custom_highlights, hls_extra)

      return hls
    end,
    config = function(_, opts)
      require("onenord").setup(opts)
      vim.cmd([[colorscheme onenord]])
    end,
  },
}
