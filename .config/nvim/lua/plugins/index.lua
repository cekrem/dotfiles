return {
  {
    "shaunsingh/solarized.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd([[colorscheme solarized]])
    end,
  },
  { "dbeniamine/todo.txt-vim" },
  {
    "vlime/vlime",
    -- config = function()
    --   vim.o.rtp = "vim/"
    -- end,
  },
  { "wlangstroth/vim-racket" },
  { "Olical/conjure" },

  -- disabled plugins
  { "goolord/alpha-nvim", enabled = false },
}
