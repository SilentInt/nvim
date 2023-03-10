local G = require('G')
local M = {}

function M.config()
  --    G.hi({
  --        ["@variable"] = {fg="NONE"};
  --        ["@function"] = {fg=32};
  --        ["@function.call"] = {fg=32};
  --        ["@operator"] = {fg=166};
  --        ["@keyword.operator"] = {fg=166};
  --
  --        ["@property"] = {fg=172};
  --        ["@field"]= {fg=150};
  --        ["@method"] = {fg=166};
  --        ["@method.call"] = {fg=9};
  --        ["@parameter"] = {fg=9};
  --
  --        ["@keyword"] = {fg=1};
  --        ["@keyword.function"] = {fg=32};
  --        ["@exception"] = {fg=32};
  --
  --        ["@statement"] = {fg=166};
  --        ["@special"] = {fg=172};
  --        ["@comment"]= {fg=71,sp='italic'};
  --        ["@include"] = {fg=1};
  --        ["@type"] = {fg=179};
  --        ["@type.builtin"] = {fg=150};
  --        ["@punctuation.bracket"] = {fg=151};
  --
  --        ["@constructor"] = {fg=172};
  --        ["@namespace"] = {fg=172};
  --
  --        ["@string"] = {fg=37};
  --        ["@number"] = {fg=37};
  --        ["@boolean"] = {fg=37};
  --
  --        ["@tag"] = {fg=172};
  --
  --        ["@text.literal"] = {fg=7};
  --
  --        ["@text.todo.unchecked"] = {fg=172};
  --        ["@text.todo.checked"] = {fg=37};
  --    })
end

function M.setup()
  require('nvim-treesitter.configs').setup {
    ensure_installed = "",
    ignore_install = {},
    highlight = {
      enable = true
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>", -- set to `false` to disable one of the mappings
        node_incremental = "<CR>",
        scope_incremental = "<BS>",
        node_decremental = "<TAB>",
      },
    },
  }
end

return M
