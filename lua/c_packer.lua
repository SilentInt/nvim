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

    -- 启动时间分析
    -- use { "dstein64/vim-startuptime", cmd = "StartupTime" }

    -- 中文help doc
    use { 'yianwillis/vimcdoc', event = 'VimEnter' }

    -- coc-nvim
    -- require('pack/coc').config()
    --use { 'neoclide/coc.nvim', config = "require('pack/coc').config()", branch = 'release' }

    -- Scala
    use({ 'scalameta/nvim-metals', requires = { "nvim-lua/plenary.nvim" } })
    --require'lspconfig'.metals.setup{}

    -- lsp
    use 'neovim/nvim-lspconfig'
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/cmp-path'
    use 'hrsh7th/cmp-cmdline'
    use 'hrsh7th/nvim-cmp'
    -- snip
    use 'L3MON4D3/LuaSnip'
    use 'saadparwaiz1/cmp_luasnip'
    -- auto-pairs
    use {
      "windwp/nvim-autopairs",
      config = function() require("nvim-autopairs").setup {} end
    }

    -- Git
    use {
      'lewis6991/gitsigns.nvim',
      config = function()
        require('gitsigns').setup()
      end
    }
    -- 浮动终端
    -- require('pack/vim-floaterm').config()
    -- use { 'voldikss/vim-floaterm', config = "require('pack/vim-floaterm').setup()" }

    -- tree-sitter
    require('pack/tree-sitter').config()
    use { 'nvim-treesitter/nvim-treesitter', config = "require('pack/tree-sitter').setup()", run = ':TSUpdate',
      event = 'BufRead' }
    use { 'nvim-treesitter/playground', after = 'nvim-treesitter' }

    -- telescope
    use { 'nvim-lua/plenary.nvim' }
    use { 'nvim-telescope/telescope.nvim', tag = '0.1.0' }

    -- leap
    -- require('leap').add_default_mappings()
    use { 'ggandor/leap.nvim', config = "require('leap').add_default_mappings()" }

    -- markdown预览插件 导航生成插件
    require('pack/markdown').config()
    use { 'mzlogin/vim-markdown-toc', ft = 'markdown' }
    use { 'iamcco/markdown-preview.nvim', config = "require('pack/markdown').setup()", run = 'cd app && yarn install',
      cmd = 'MarkdownPreview', ft = 'markdown' }

    -- 文件管理器
    require('pack/nvim-tree').config()
    use { 'kyazdani42/nvim-tree.lua', config = "require('pack/nvim-tree').setup()",
      cmd = { 'NvimTreeToggle', 'NvimTreeFindFileToggle' } }

    -- 图标支持
    use { 'kyazdani42/nvim-web-devicons' }

    -- drakula主题:
    use { 'Mofiqul/dracula.nvim' }
    -- 状态栏 & 标题栏
    use {
      'nvim-lualine/lualine.nvim',
      config = "require('pack/lualine').config()",
      requires = { 'kyazdani42/nvim-web-devicons', opt = true }
    }
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
