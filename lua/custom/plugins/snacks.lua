return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    -- your configuration comes here
    -- or leave it empty to use the default settings
    -- refer to the configuration section below
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    explorer = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    picker = { enabled = true },
    notifier = { enabled = true },
    quickfile = { enabled = true },
    scope = { enabled = true },
    scroll = { enabled = true },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    lazygit = { enabled = true },
    terminal = { enabled = true },
    scratch = {
      enabled = true,
    },
    toggle = { enabled = true },
  },
  keys = {
    {
      '<leader>sf',
      function()
        Snacks.picker.files()
      end,
      desc = '[S]earch [F]iles',
    },
    {
      '<leader>sh',
      function()
        Snacks.picker.help()
      end,
      desc = '[S]earch [H]elp',
    },
    {
      '<leader>sk',
      function()
        -- Dont know why preview false doesnt work
        Snacks.picker.keymaps { layout = 'select' }
      end,
      desc = '[S]earch [K]eymaps',
    },
    {
      '<leader>s/',
      function()
        Snacks.picker.lines()
      end,

      desc = '[S]earch [/]',
    },
    {
      '<leader>sg',
      function()
        Snacks.picker.grep()
      end,

      desc = '[S]earch [G]rep',
    },
    {
      '<leader>s.',
      function()
        Snacks.picker.recent()
      end,

      desc = '[S]earch [.]',
    },
    {
      '<leader>sd',
      function()
        Snacks.picker.diagnostics()
      end,

      desc = '[S]earch [D]iagnostics',
    },
    {
      '<leader><leader>',
      function()
        Snacks.picker.buffers {
          win = {
            input = {
              keys = {
                ['d'] = 'bufdelete',
              },
            },
            list = {
              keys = {
                ['d'] = 'bufdelete',
              },
            },
          },
        }
      end,

      desc = '[ ] Find existing buffers',
    },
    {
      '<leader>tt',
      function()
        Snacks.terminal(nil, { win = { position = 'float', border = 'rounded' } })
      end,
      desc = '[T]erminal',
    },
    {
      '<leader>tp',
      function()
        Snacks.terminal('ipython', { win = { position = 'float', border = 'rounded' } })
      end,
      desc = '[T]erminal [P]ython',
    },
    {
      '<leader>.',
      function()
        Snacks.scratch()
      end,
      desc = 'Scratch',
    },
    {
      '<leader>sc',
      function()
        Snacks.picker.scratch()
      end,
      desc = '[S]earch S[c]cratches',
    },
  },
}
