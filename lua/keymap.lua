local G = require('G')
local key_default = { silent = true, noremap = true }
G.map({
  { 'i', 'jk', '<ESC>', key_default },
  { 'n', 'ff', [[:Telescope find_files <enter>]], key_default },
})
G.map({
  { "n", "ge", "<cmd>TroubleToggle<cr>", key_default },
  { "n", "gd", "<cmd>TroubleToggle lsp_definitions<cr>", key_default },
  { "n", "gr", "<cmd>TroubleToggle lsp_references<cr>", key_default }
})
G.map({ { 'n', 'H', ':TSHighlightCapturesUnderCursor<CR>', { silent = true, noremap = true } } })
