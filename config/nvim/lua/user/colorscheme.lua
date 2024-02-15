vim.cmd([[
try
  " colorscheme material
  colorscheme my-material
  " colorscheme moonrakers
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]])

-- LSP Semantic Token Groups
local links = {
	["@lsp.type.boolean"] = "@boolean",
	["@lsp.type.builtinType"] = "@type.builtin",
	["@lsp.type.comment"] = "@comment",
	["@lsp.type.enum"] = "@type",
	["@lsp.type.enumMember"] = "@constant",
	["@lsp.type.escapeSequence"] = "@string.escape",
	["@lsp.type.formatSpecifier"] = "@punctuation.special",
	["@lsp.type.interface"] = "@type", -- modified by me
	["@lsp.type.keyword"] = "@keyword",
	["@lsp.type.namespace"] = "@namespace",
	["@lsp.type.number"] = "@number",
	["@lsp.type.class"] = "@symbol",
	["@lsp.type.operator"] = "@operator",
	["@lsp.type.parameter"] = "@parameter",
	["@lsp.type.property"] = "@property",
	["@lsp.type.selfKeyword"] = "@variable.builtin",
	["@lsp.type.string.rust"] = "@string",
	["@lsp.type.typeAlias"] = "@type.definition",
	["@lsp.type.variable"] = "@variable", -- use treesitter styles for regular variables

	["@variable.tsx"] = "@variable", -- use treesitter styles for regular variables
	["@type.tsx"] = "@type", -- use treesitter styles for regular variables
	["@lsp.typemod.class.defaultLibrary"] = "@type.builtin",
	["@lsp.typemod.enum.defaultLibrary"] = "@type.builtin",
	["@lsp.typemod.enumMember.defaultLibrary"] = "@constant.builtin",
	["@lsp.typemod.function.defaultLibrary"] = "@function.builtin",
	["@lsp.typemod.keyword.async"] = "@keyword.coroutine",
	["@lsp.typemod.macro.defaultLibrary"] = "@function.builtin",
	["@lsp.typemod.method.defaultLibrary"] = "@function.builtin",
	["@lsp.typemod.operator.injected"] = "@operator",
	["@lsp.typemod.string.injected"] = "@string",
	["@lsp.typemod.type.defaultLibrary"] = "@constant", -- modified by me
	["@lsp.typemod.variable"] = "@type",
	["@lsp.typemod.variable.defaultLibrary"] = "@variable.builtin",
	["@lsp.typemod.variable.injected"] = "@variable",
	["@lsp.typemod.variable.declaration"] = "@type",
	["@lsp.typemod.variable.typescriptreact"] = "@variable",
	["@lsp.typemod.variable.readonly.typescriptreact"] = "@variable",
}

for newgroup, oldgroup in pairs(links) do
	vim.api.nvim_set_hl(0, newgroup, { link = oldgroup, default = true })
end
