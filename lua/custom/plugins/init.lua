-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'bluz71/vim-moonfly-colors',
    lazy = true,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme 'moonfly'
    end,
  },
  {
    'nvim-neotest/nvim-nio',
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
  },
  {
    'rebelot/kanagawa.nvim',
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
  },
  {
    'vague-theme/vague.nvim',
    lazy = true, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other plugins
    config = function()
      -- NOTE: you do not need to call setup if you don't want to.
      require('vague').setup {
        -- optional configuration here
      }
      vim.cmd 'colorscheme vague'
    end,
  },
  {
    'uhs-robert/oasis.nvim',
    lazy = true,
    priority = 1000,
    config = function()
      require('oasis').setup() -- (see Configuration below for all customization options)
      vim.cmd.colorscheme 'oasis-abyss' -- After setup, apply theme (or any style like "oasis-night")
    end,
  },
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 999,

    config = function()
      vim.cmd.colorscheme 'carbonfox'
    end,
  }, -- lazy
}
