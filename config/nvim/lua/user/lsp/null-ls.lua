local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  return
end

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

vim.g.null_ls_formatters_enabled = true

null_ls.setup({
  debug = true,
  diagnostics_format = "#{m} [#{c}]",
  sources = {
    null_ls.builtins.formatting.prettier.with({ prefer_local = "node_modules/.bin" }),
    null_ls.builtins.diagnostics.eslint_d.with({ prefer_local = "node_modules/.bin" }),
    null_ls.builtins.code_actions.eslint_d.with({ prefer_local = "node_modules/.bin" }),
    -- null_ls.builtins.formatting.eslint_d.with({ prefer_local = "node_modules/.bin" }),
    null_ls.builtins.formatting.stylua,
    null_ls.builtins.formatting.rustfmt,
    -- null_ls.builtins.diagnostics.eslint.with({ prefer_local = "node_modules/.bin", }),
    -- null_ls.builtins.code_actions.eslint.with({ prefer_local = "node_modules/.bin" }),
  },

  on_attach = function(client, bufnr)
    if client.supports_method("textDocument/formatting") and vim.g.null_ls_formatters_enabled then
      vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      vim.api.nvim_create_autocmd("BufWritePre", {
        group = augroup,
        buffer = bufnr,
        callback = function()
          vim.lsp.buf.format(({ bufnr = bufnr }))
        end,
      })
    end
  end,
})

local toggle_formatters = function()
  null_ls.toggle({ methods = null_ls.methods.FORMATTING })
  vim.g.null_ls_formatters_enabled = not vim.g.null_ls_formatters_enabled
end

vim.api.nvim_create_user_command("ToggleFormatters", toggle_formatters, {})
