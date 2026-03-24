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

-- Nordic Palette
local colors = {
  bg      = "NONE",    -- Transparent background
  base_bg = "#191D24", -- black0 (Dark background for text on colored blocks)
  fg      = "#D8DEE9", -- white1
  gray    = "#4C566A", -- gray4 (Muted text)
  blue    = "#88C0D0", -- blue2
  cyan    = "#8FBCBB", -- cyan.base
  red     = "#BF616A", -- red.base
  orange  = "#D08770", -- orange.base
  yellow  = "#EBCB8B", -- yellow.base
  green   = "#A3BE8C", -- green.base
  magenta = "#B48EAD", -- magenta.base
}

local custom_theme = {
  normal = {
    a = { fg = colors.base_bg, bg = colors.blue, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.gray, bg = colors.bg },
  },
  insert = {
    a = { fg = colors.base_bg, bg = colors.green, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.gray, bg = colors.bg },
  },
  visual = {
    a = { fg = colors.base_bg, bg = colors.magenta, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.gray, bg = colors.bg },
  },
  replace = {
    a = { fg = colors.base_bg, bg = colors.red, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.gray, bg = colors.bg },
  },
  command = {
    a = { fg = colors.base_bg, bg = colors.orange, gui = "bold" },
    b = { fg = colors.fg, bg = colors.bg },
    c = { fg = colors.gray, bg = colors.bg },
  },
  inactive = {
    a = { fg = colors.gray, bg = colors.bg },
    b = { fg = colors.gray, bg = colors.bg },
    c = { fg = colors.gray, bg = colors.bg },
  },
}

local conditions = {
  not_empty = function()
    return vim.fn.empty(vim.fn.expand("%:t")) ~= 1
  end,
  hide_width = function()
    return vim.fn.winwidth(0) > 80
  end,
  check_git_workspace = function()
    local filepath = vim.fn.expand("%:p:h")
    local gitdir = vim.fn.finddir(".git", filepath .. ";")
    return gitdir and #gitdir > 0 and #gitdir < #filepath
  end,
}

-- Force Neovim's default TabLineFill to be transparent just in case
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
        section_separators = { left = "", right = "" },
        disabled_filetypes = { statusline = { "dashboard", "alpha", "starter" } },
        globalstatus = false,
      },
      tabline = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = {
          {
            "buffers",
            show_filename_only = true,
            hide_filename_extension = false,
            show_modified_status = true,

            buffers_color = {
              active = { fg = colors.base_bg, bg = colors.blue, gui = "bold" },
              inactive = { fg = colors.gray, bg = "NONE" },
            },

            symbols = {
              modified = " ●",
              alternate_file = "",
              directory = "",
            },
            color = { gui = "bold" },
            separator = { right = "" },
            right_padding = 2
          },
        },
        lualine_x = {},
        lualine_y = {},
        lualine_z = {},
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
              color_warn  = { fg = colors.yellow, bg = colors.bg },
              color_info  = { fg = colors.cyan, bg = colors.bg },
            },
          },
          {
            "filename",
            path = 1,
            file_status = true,
            color = { fg = colors.fg, bg = colors.bg, gui = "bold" },
            separator = { right = "" },
            cond = conditions.not_empty,
          },
          {
            "branch",
            color = { fg = colors.magenta, bg = colors.bg, gui = "bold" },
            separator = { right = "" },
          },
          {
            "diff",
            symbols = { added = " ", modified = "󰝤 ", removed = " " },
            separator = { right = "", left = "" },
            diff_color = {
              added    = { fg = colors.green, bg = colors.bg },
              modified = { fg = colors.orange, bg = colors.bg },
              removed  = { fg = colors.red, bg = colors.bg },
            },
          },
        },
        lualine_c = {},
        lualine_x = {},
        lualine_y = {
          {
            "filesize",
            color = { gui = "bold", fg = colors.fg, bg = colors.bg },
            cond = conditions.not_empty,
          },
          {
            "filetype",
            color = { gui = "bold", fg = colors.blue, bg = colors.bg },
          },
          {
            "fileformat",
            symbols = {
              unix = "UNIX", -- e712
              dos = "", -- e70f
              mac = "", -- e711
            },
            color = { gui = "bold", fg = colors.orange, bg = colors.bg },
          },
          { "progress", color = { gui = "bold", fg = colors.blue, bg = colors.bg } },
        },
        lualine_z = {
          {
            "location",
            separator = { left = "" },
            left_padding = 2,
            color = { fg = colors.base_bg, bg = colors.blue, gui = "bold" },
          },
        },
      },
      inactive_sections = {
        lualine_a = { "filename" },
        lualine_b = {},
        lualine_c = {},
        lualine_x = {},
        lualine_y = {},
        lualine_z = { "location" },
      },
      extensions = {},
    })

    make_tabline_transparent()

    vim.api.nvim_create_autocmd("ColorScheme", {
      pattern = "*",
      callback = make_tabline_transparent,
    })
  end,
}
