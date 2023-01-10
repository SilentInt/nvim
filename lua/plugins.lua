local G = require('G')
local packer_bootstrap = false
local install_path = G.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
local compiled_path = G.fn.stdpath('config') .. '/plugin/packer_compiled.lua'
if G.fn.empty(G.fn.glob(install_path)) > 0 then
  print('Installing packer.nvim...')
  G.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
  G.fn.system({ 'rm', '-rf', compiled_path })
  G.cmd [[packadd packer.nvim]]
  packer_bootstrap = true
end
-- 所有插件配置分 config 和 setup 部分
-- config 发生在插件载入前 一般为 let g:xxx = xxx 或者 hi xxx xxx 或者 map x xxx 之类的 配置
-- setup  发生在插件载入后 一般为 require('xxx').setup() 之类的配置
require('packer').startup({
  function(use)
    -- packer 管理自己的版本
    use { 'wbthomason/packer.nvim' }

    -- 中文help doc
    use { 'yianwillis/vimcdoc', event = 'VimEnter' }


    -- lsp
    use 'neovim/nvim-lspconfig'
    -- snip
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    -- cmp
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'

    -- auto-pairs
    use {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
    }

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      config = function() require('gitsigns').setup() end
    }
    -- 浮动终端
    -- require('pack/vim-floaterm').config()
    -- use { 'voldikss/vim-floaterm', config = "require('pack/vim-floaterm').setup()" }

    -- tree-sitter
    use {
      'nvim-treesitter/nvim-treesitter',
      config = function() require('pack/tree-sitter').setup() end,
      run = ':TSUpdate', event = 'BufRead'
    }
    use { 'nvim-treesitter/playground', after = 'nvim-treesitter' }

    -- 补全高亮
    use 'folke/lsp-colors.nvim'

    -- telescope
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }

    -- leap
    -- require('leap').add_default_mappings()
    use { 'ggandor/leap.nvim', config = "require('leap').add_default_mappings()" }

    -- markdown预览插件 导航生成插件
    --use({ "iamcco/markdown-preview.nvim",
    --  run = function() G.fn["mkdp#util#install"]() end, })
    use({ "iamcco/markdown-preview.nvim", run = "cd app && npm install",
      setup = function() require('pack/markdown').config() end, ft = { "markdown" }, })
    use { 'mzlogin/vim-markdown-toc', ft = 'markdown' }
    use { 'jghauser/follow-md-links.nvim' }


    -- 文件管理器
    require('pack/nvim-tree').config()
    use { 'nvim-tree/nvim-tree.lua', config = "require('pack/nvim-tree').setup()",
      cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' } }

    -- 图标支持
    use { 'kyazdani42/nvim-web-devicons' }

    -- drakula主题:
    -- use { 'Mofiqul/dracula.nvim' }

    -- tokyoniht主题
    use 'folke/tokyonight.nvim'

    -- 状态栏 & 标题栏
    use {
      'nvim-lualine/lualine.nvim',
      config = function() require('pack/lualine').config() end,
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }

    -- list for showing diagnostics, references, telescope results
    -- 优雅的诊断，引用列表
    use {
      "folke/trouble.nvim",
      requires = "kyazdani42/nvim-web-devicons",
      config = function() require('trouble').setup() end
    }

    -- Scala
    use({ 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } })
  end,
  config = {
    git = { clone_timeout = 120, depth = 1 },
    display = {
      working_sym = '[ ]', error_sym = '[✗]', done_sym = '[✓]', removed_sym = ' - ', moved_sym = ' → ',
      header_sym = '─',
      open_fn = function() return require("packer.util").float({ border = "rounded" }) end
    }
  }
})

if packer_bootstrap then
  require('packer').sync()
end
