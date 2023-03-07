return {
  -- add solarized theme
  { "shaunsingh/solarized.nvim" },

  -- Configure LazyVim to load solarized
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "solarized",
    },
  },

  -- add todo.txt
  { "dbeniamine/todo.txt-vim" },

  -- disable plugins
  { "folke/noice.nvim", enabled = false },
  { "goolord/alpha-nvim", enabled = false },
}
