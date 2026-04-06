local mode_map = {
  ["n"] = "NOR",
  ["no"] = "O·P",
  ["nov"] = "O·P",
  ["noV"] = "O·P",
  ["no\22"] = "O·P",
  ["niI"] = "N·I",
  ["niR"] = "N·R",
  ["niV"] = "N",
  ["nt"] = "N·T",
  ["v"] = "VIS",
  ["vs"] = "V",
  ["V"] = "VIS·L",
  ["Vs"] = "VIS·L",
  ["\22"] = "VIS·B",
  ["\22s"] = "VIS·B",
  ["s"] = "S",
  ["S"] = "S·L",
  ["\19"] = "S·B",
  ["i"] = "INS",
  ["ic"] = "I·C",
  ["ix"] = "I·X",
  ["R"] = "R",
  ["Rc"] = "R·C",
  ["Rx"] = "R·X",
  ["Rv"] = "V·R",
  ["Rvc"] = "RVC",
  ["Rvx"] = "RVX",
  ["c"] = "C",
  ["cv"] = "EX",
  ["ce"] = "EX",
  ["r"] = "R",
  ["rm"] = "M",
  ["r?"] = "C",
  ["!"] = "SH",
  ["t"] = "T",
}

local function modes()
  return mode_map[vim.api.nvim_get_mode().mode] or "__"
end

-- Xcode Monochrome Palette
local colors = {
  bg      = "NONE",     -- Transparent background
  base_bg = "#101112",  -- Deep dark (for text on colored blocks)
  fg      = "#D8DEE9",  -- Main text
  muted   = "#4C566A",  -- Gray/Muted
  cyan    = "#6BDFFF",  -- Xcode Cyan (Normal)
  green   = "#A3D38C",  -- Xcode Green (Insert)
  purple  = "#D5B4E2",  -- Xcode Purple (Visual)
  red     = "#FF8170",  -- Xcode Red (Replace)
  orange  = "#DAB275",  -- Xcode Gold (Command)
  blue    = "#78C2B3",  -- Xcode Blue/Teal
}

local custom_theme = {
  normal = {
    a = { fg = colors.base_bg, bg = colors.cyan, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.muted, bg = colors.bg },
  },
  insert = {
    a = { fg = colors.base_bg, bg = colors.green, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.muted, bg = colors.bg },
  },
  visual = {
    a = { fg = colors.base_bg, bg = colors.purple, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.muted, bg = colors.bg },
  },
  replace = {
    a = { fg = colors.base_bg, bg = colors.red, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.muted, bg = colors.bg },
  },
  command = {
    a = { fg = colors.base_bg, bg = colors.orange, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.muted, bg = colors.bg },
  },
  inactive = {
    a = { fg = colors.muted, bg = colors.bg },
    b = { fg = colors.muted, bg = colors.bg },
    c = { fg = colors.muted, bg = colors.bg },
  },
}

local conditions = {
  not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
}

local function make_tabline_transparent()
  vim.api.nvim_set_hl(0, "TabLineFill", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "TabLine", { bg = "NONE", ctermbg = "NONE" })
  vim.api.nvim_set_hl(0, "TabLineSel", { bg = "NONE", ctermbg = "NONE" })
end

return {
  "nvim-lualine/lualine.nvim",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    require("lualine").setup({
      options = {
        theme = custom_theme,
        component_separators = "|",
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        globalstatus = false,
      },
      tabline = {
        lualine_c = {
          {
            "buffers",
            show_filename_only = true,
            show_modified_status = true,
            buffers_color = {
              active = { fg = colors.base_bg, bg = colors.cyan, gui = "bold" },
              inactive = { fg = colors.muted, bg = "NONE" },
            },
            symbols = { modified = " ●", directory = "" },
            separator = { right = "" },
            right_padding = 2
          },
        },
      },
      sections = {
        lualine_a = {
          { modes, color = { gui = "bold" }, separator = { right = "" }, right_padding = 2 },
        },
        lualine_b = {
          {
            "diagnostics",
            sources = { "nvim_diagnostic" },
            symbols = { error = " ", warn = " ", info = " " },
            diagnostics_color = {
              color_error = { fg = colors.red, bg = colors.bg },
              color_warn  = { fg = colors.orange, bg = colors.bg },
              color_info  = { fg = colors.cyan, bg = colors.bg },
            },
          },
          {
            "filename",
            path = 1,
            color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
            cond = conditions.not_empty,
          },
          {
            "branch",
            color = { fg = colors.purple, bg = colors.bg, gui = "bold" },
          },
        },
        lualine_c = {},
        lualine_x = {
          {
            "diff",
            symbols = { added = " ", modified = "󰝤 ", removed = " " },
            diff_color = {
              added    = { fg = colors.green, bg = colors.bg },
              modified = { fg = colors.orange, bg = colors.bg },
              removed  = { fg = colors.red, bg = colors.bg },
            },
          },
        },
        lualine_y = {
          { "filetype", color = { gui = "bold", fg = colors.blue, bg = colors.bg } },
          { "progress", color = { gui = "bold", fg = colors.cyan, bg = colors.bg } },
        },
        lualine_z = {
          {
            "location",
            separator = { left = "" },
            color = { fg = colors.base_bg, bg = colors.cyan, gui = "bold" },
          },
        },
      },
    })

    make_tabline_transparent()
    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = make_tabline_transparent,
    })
  end,
}
