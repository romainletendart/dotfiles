local function get_github_url()
  local result = vim.system({ "git", "remote", "get-url", "origin" }, { text = true }):wait()
  local url_prefix = result.stdout:gsub("%.git%s*$", "")

  result = vim.system({ "git", "rev-parse", "--short", "HEAD" }, { text = true }):wait()
  local git_revision = result.stdout:gsub("%s", "")

  local relative_path = vim.fn.expand("%:.")
  local line_number = vim.fn.line(".")

  return url_prefix .. "/blob/" .. git_revision .. "/" .. relative_path .. "#L" .. line_number
end

vim.keymap.set("n", "<leader>og", function()
  local url = get_github_url()

  local result = vim.system({ "xdg-open", url }):wait()
  if result.code == 0 then
    vim.notify("Opened: " .. url, vim.log.levels.INFO)
  end
end, { desc = "[o]pen [g]ithub URL" })

vim.keymap.set("n", "<leader>yg", function()
  local url = get_github_url()

  -- Yank to system clipboard
  vim.fn.setreg("+", url)

  vim.notify("Yanked: " .. url, vim.log.levels.INFO)
end, { desc = "[y]ank [g]ithub URL" })

return {}
