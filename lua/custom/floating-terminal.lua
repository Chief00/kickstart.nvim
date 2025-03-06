local M = {}

local state = {
  terminal = {
    buf = -1,
    win = -1,
    job_id = -1,
  },
  ipython = {
    buf = -1,
    win = -1,
    job_id = -1,
  },
}

local function create_floating_window(opts)
  opts = opts or {}

  local width = math.floor(vim.o.columns * 0.8)
  local height = math.floor(vim.o.lines * 0.8)
  local row = math.floor((vim.o.lines - height) / 2)
  local col = math.floor((vim.o.columns - width) / 2)

  local buf = nil
  if not opts.buf or not vim.api.nvim_buf_is_valid(opts.buf) then
    buf = vim.api.nvim_create_buf(false, true)
  else
    buf = opts.buf
  end

  local win_config = {
    relative = 'editor',
    width = width,
    height = height,
    row = row,
    col = col,
    style = 'minimal',
    border = 'rounded',
  }

  local win = vim.api.nvim_open_win(buf, true, win_config)
  return { buf = buf, win = win }
end

-- Function for checking if a file exists, just check that you can open it for reading
local function file_exists(filepath)
  local f = io.open(filepath, 'r')
  if f then
    f:close()
    return true
  end
  return false
end

M.toggle_terminal = function()
  if state.terminal.win == -1 or not vim.api.nvim_win_is_valid(state.terminal.win) then
    state.terminal = create_floating_window { buf = state.terminal.buf }
    if vim.bo[state.terminal.buf].buftype ~= 'terminal' then
      state.terminal.job_id = vim.fn.termopen(vim.o.shell)

      if file_exists '.envrc' then
        vim.defer_fn(function()
          if state.terminal.job_id then
            vim.fn.chansend(state.terminal.job_id, 'direnv reload\n')
          end
        end, 100)
      end
    end
  else
    vim.api.nvim_win_hide(state.terminal.win)
    state.terminal.win = -1
  end
end

M.toggle_ipython_repl = function()
  if state.ipython.win == -1 or not vim.api.nvim_win_is_valid(state.ipython.win) then
    state.ipython = create_floating_window { buf = state.ipython.buf }
    if vim.bo[state.ipython.buf].buftype ~= 'terminal' then
      state.ipython.job_id = vim.fn.termopen('ipython --no-autoindent', {
        on_exit = function()
          state.ipython.win = -1
        end,
      })
    end
  else
    vim.api.nvim_win_hide(state.ipython.win)
    state.ipython.win = -1
  end
end

-- Custom command for opening and closing floating terminal
vim.api.nvim_create_user_command('FloatingTerminal', M.toggle_terminal, {})
vim.keymap.set({ 'n' }, '<leader>tt', M.toggle_terminal)
vim.api.nvim_create_user_command('FloatingIPythonIde', M.toggle_ipython_repl, {})
vim.keymap.set({ 'n' }, '<leader>tp', M.toggle_ipython_repl)

return M
