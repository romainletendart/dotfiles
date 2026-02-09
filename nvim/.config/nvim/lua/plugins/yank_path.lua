vim.keymap.set("n", "<leader>yp", ":let @+=expand('%:.')<CR>", { desc = "Relative [p]ath" })
vim.keymap.set("n", "<leader>yP", ":let @+=expand('%:p')<CR>", { desc = "Absolute [P]ath" })
vim.keymap.set("n", "<leader>yn", ":let @+=expand('%:t')<CR>", { desc = "File [n]ame" })
vim.keymap.set("n", "<leader>yN", ":let @+=expand('%:t:r')<CR>", { desc = "File base[N]ame" })

return {}
