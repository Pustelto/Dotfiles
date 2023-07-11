local status_ok, neotest = pcall(require, "neotest")
if not status_ok then
	return
end

neotest.setup({
	status = {
		enabled = true,
		signs = true,
	},
	output = {
		open_on_run = false,
	},
	quickfix = {
		enabled = false,
	},
	adapters = {
		require("neotest-jest")({
			jestCommand = "pnpm jest",
			jestConfigFile = function()
				local file = vim.fn.expand("%:p")
				if string.find(file, "/libs/") or string.find(file, "/apps/") then
					return string.match(file, "(.-/[^/]+/)src") .. "jest.config.ts"
				end

				return vim.fn.getcwd() .. "/jest.config.ts"
			end,
			env = { CI = true },
			cwd = function(path)
				return vim.fn.getcwd()
			end,
		}),
	},
})

vim.diagnostic.config({
	virtual_text = {
		source = false,
		format = function(diagnostic)
			local index = string.find(diagnostic.message, "at Object")
			if index ~= nil then
				return string.sub(diagnostic.message, 1, index - 1)
			end
			return diagnostic.message
		end,
	},
	signs = false,
}, vim.api.nvim_create_namespace("neotest"))
