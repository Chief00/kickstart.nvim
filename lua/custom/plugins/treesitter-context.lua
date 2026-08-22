-- Shows the enclosing function/class/block pinned to the top of the window
-- while you scroll through code, using treesitter.
return {
  'nvim-treesitter/nvim-treesitter-context',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    enable = true,
    max_lines = 5, -- how many context lines to show at most
    trim_scope = 'outer', -- drop outermost scopes first if space runs out
  },
  keys = {
    {
      'glc',
      function()
        require('treesitter-context').go_to_context(vim.v.count1)
      end,
      desc = '[G]o [L]sp [C]ontext',
    },
  },
}
