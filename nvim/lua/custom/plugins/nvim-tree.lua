return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {}
    local nvimtree = require 'nvim-tree.api'
    function NvimRefreshAndToggle()
      nvimtree.tree.reload()
      nvimtree.tree.toggle()
    end
    vim.keymap.set('n', '<leader>t', NvimRefreshAndToggle, { desc = 'Nvim-[T]ree toggle' })
  end,
}
