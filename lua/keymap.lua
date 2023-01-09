local G = require('G')
G.map({
    { 'i', 'jk', '<ESC>', { noremap = true, silent = true } },
    { 'n', 'ff', [[:Telescope find_files <enter>]], { noremap = true, silent = true } },
})
