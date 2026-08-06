local function tmux_msg(fmt)
  return vim.fn.systemlist("env -u TMUX tmux display-message -p '" .. fmt .. "'")
end

local function fix_tmux_env()
  if vim.fn.executable("tmux") == 0 then
    return
  end
  vim.env.TMUX = nil
  local socket = tmux_msg("#{socket_path}")[1]
  local sid = tmux_msg("#{session_id}")[1]
  if not socket or not sid or socket == "" or sid == "" then
    return
  end
  local num = sid:match("%$(%d+)") or sid:gsub("%$", "")
  vim.env.TMUX = socket .. "," .. sid .. "," .. num
end

local function set_tpipeline_size()
  if not vim.env.TMUX then
    return
  end
  local lines = vim.fn.systemlist("env -u TMUX tmux show -g status-left-length \\; show -g status-right-length")
  local left = tonumber(lines[1] and lines[1]:match("(%d+)")) or 320
  local right = tonumber(lines[2] and lines[2]:match("(%d+)")) or 280
  -- Keep %= padding small so left bridge doesn't bloat past status-left budget.
  local battery_budget = 45
  vim.g.tpipeline_size = math.min(left - battery_budget, 160) + math.min(right, 140)
end

local function fix_statusline_hls()
  if not vim.env.TMUX then
    return
  end
  for _, name in ipairs({ "StatusLine", "StatusLineNC", "StatusLineTerm", "StatusLineTermNC" }) do
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = name, link = false })
    if ok and hl and hl.bg == nil then
      vim.api.nvim_set_hl(0, name, { bg = "#3f4551", fg = hl.fg or "#abb2bf" })
    end
  end
end

local function is_avante_buf(buf)
  buf = buf or vim.api.nvim_get_current_buf()
  local ok, ft = pcall(vim.api.nvim_buf_get_option, buf, "filetype")
  if not ok or ft == "" then
    return false
  end
  return ft == "Avante" or ft:match("^Avante") ~= nil
end

local function refresh_tpipeline()
  if not vim.env.TMUX or is_avante_buf() then
    return
  end
  pcall(vim.fn["tpipeline#state#thaw"])
  pcall(vim.fn["tpipeline#forceupdate"])
end

local function pause_tpipeline_for_avante()
  vim.g.tpipeline_avante_pause = true
  vim.g.tpipeline_statusline = " "
  vim.wo.statusline = " "
  vim.o.laststatus = 0
  pcall(vim.fn["tpipeline#update"])
end

local function resume_tpipeline_after_avante()
  if not vim.g.tpipeline_avante_pause then
    return
  end
  vim.g.tpipeline_avante_pause = nil
  vim.g.tpipeline_statusline = ""
  refresh_tpipeline()
end

return {
  "vimpostor/vim-tpipeline",
  lazy = false,
  cond = function()
    if vim.fn.executable("tmux") == 0 then
      return false
    end
    fix_tmux_env()
    return vim.env.TMUX ~= nil and vim.env.TMUX:find(",") ~= nil
  end,
  init = function()
    fix_tmux_env()

    vim.g.tpipeline_preservebg = 1
    vim.g.tpipeline_autoembed = 0
    vim.g.tpipeline_split = 1

    vim.api.nvim_create_autocmd("User", {
      pattern = "TpipelineSize",
      callback = set_tpipeline_size,
    })
    set_tpipeline_size()
  end,
  config = function()
    fix_tmux_env()

    vim.o.laststatus = 0
    vim.o.ruler = false
    vim.o.showmode = false

    vim.g.tpipeline_avante_pause = nil
    vim.g.tpipeline_statusline = ""
    pcall(vim.fn["tpipeline#state#thaw"])

    -- Re-init so filepath/job match the reconciled TMUX value.
    pcall(vim.fn["tpipeline#state#reload"])

    local group = vim.api.nvim_create_augroup("TpipelineAvante", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "WinEnter" }, {
      group = group,
      callback = function()
        if vim.env.TMUX then
          vim.o.laststatus = 0
        end

        vim.schedule(function()
          if is_avante_buf() then
            pause_tpipeline_for_avante()
          else
            resume_tpipeline_after_avante()
          end
        end)
      end,
    })

    vim.api.nvim_create_autocmd("FocusGained", {
      group = group,
      callback = function()
        fix_tmux_env()
        refresh_tpipeline()
      end,
    })

    for _, ms in ipairs({ 500, 2000, 5000 }) do
      vim.defer_fn(function()
        fix_statusline_hls()
        if is_avante_buf() then
          pause_tpipeline_for_avante()
        else
          refresh_tpipeline()
        end
      end, ms)
    end

    vim.api.nvim_create_autocmd("ColorScheme", {
      group = group,
      callback = function()
        fix_statusline_hls()
        refresh_tpipeline()
      end,
    })
  end,
}
