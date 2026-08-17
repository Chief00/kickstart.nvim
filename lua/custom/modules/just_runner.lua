local M = {}

local hl_groups = { 'Function', 'Type', 'Constant', 'String', 'Keyword', 'Special', 'Identifier', 'Number' }

local function hl_for_group(name)
  local sum = 0
  for i = 1, #name do
    sum = sum + name:byte(i)
  end
  return hl_groups[(sum % #hl_groups) + 1]
end

function M.run()
  local output = vim.fn.system 'just --dump --dump-format json 2>/dev/null'
  if vim.v.shell_error ~= 0 then
    vim.notify('No justfile found (or `just` not on PATH)', vim.log.levels.WARN)
    return
  end

  local ok, data = pcall(vim.json.decode, output)
  if not ok or not data.recipes then
    vim.notify('Failed to parse justfile', vim.log.levels.ERROR)
    return
  end

  local items = {}
  for name, recipe in pairs(data.recipes) do
    if not vim.startswith(name, '_') then
      local doc = recipe.doc
      if doc == vim.NIL then
        doc = nil
      end

      local group = recipe.group
      if group == vim.NIL then
        group = nil
      end

      table.insert(items, {
        text = name,
        name = name,
        doc = doc,
        group = group or 'ungrouped',
      })
    end
  end

  table.sort(items, function(a, b)
    return a.name < b.name
  end)

  Snacks.picker.pick {
    items = items,
    preview = false,
    layout = { preset = 'select' },
    format = function(item)
      local ret = {
        { '[' .. item.group .. '] ', hl_for_group(item.group) },
        { item.name, 'Identifier' },
      }
      if item.doc then
        table.insert(ret, { '  — ' .. item.doc, 'Comment' })
      end
      return ret
    end,
    confirm = function(picker, item)
      picker:close()
      Snacks.terminal('just ' .. item.name)
    end,
  }
end

return M
