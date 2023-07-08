local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep

-- some shorthands...
local snip = ls.snippet
local node = ls.snippet_node
local text = ls.text_node
local insert = ls.insert_node
local func = ls.function_node
local choice = ls.choice_node
local dynamicn = ls.dynamic_node

ls.config.set_config({
	history = true,
	-- treesitter-hl has 100, use something higher (default is 200).
	ext_base_prio = 200,
	-- minimal increase in priority.
	ext_prio_increase = 1,
	enable_autosnippets = false,
	store_selection_keys = "<c-s>",
})

-- Use Js snippets in react and TypeScript as well
ls.filetype_extend("javascriptreact", { "javascript" })
ls.filetype_extend("typescript", { "javascript" })
ls.filetype_extend("typescriptreact", { "typescript", "javascriptreact", "javascript" })

local filename = function()
	return { vim.fn.expand("%:r") }
end

ls.add_snippets(nil, {
	markdown = {
		-- Select link, press C-s, enter link to receive snippet
		snip({
			trig = "link",
			namr = "markdown_link",
			dscr = "Create markdown link [txt](url)",
		}, {
			text("["),
			insert(1),
			text("]("),
			func(function(_, snip)
				return snip.env.TM_SELECTED_TEXT[1] or {}
			end, {}),
			text(")"),
			insert(0),
		}),
	},
	javascript = {
		snip({
			trig = "efn",
			namr = "export function",
		}, {
			text("export function "),
			insert(1, filename()),
			text("("),
			insert(2),
			text(") {"),
			insert(0),
			text("}"),
		}),
		snip({
			trig = "log",
			namr = "console.log",
		}, {
			text("console.log("),
			insert(1),
			text(")"),
		}),
		snip({
			trig = "/**",
			namr = "JSDoc comment",
		}, {
			text({ "/**", " * " }),
			insert(1),
			text({ "", " */" }),
		}),
		snip({ trig = "setTimeout", name = "setTimeout" }, {
			text("setTimeout(() => {"),
			text({ "", "\t" }),
			insert(1, "// Callback code"),
			text({ "", "}," }),
			insert(2, "delay"),
			text(");"),
			insert(0),
		}),
	},
	javascriptreact = {
		snip({ trig = "uss", namr = "useState" }, {
			text("const ["),
			insert(1, "state"),
			text(", "),
			func(function(args)
				-- Get the value of the first insert point
				local state = args[1][1]
				local transformedState = "set"
					-- Transform the state value to generate the second insert point
					.. state:gsub("^%l", string.upper)
				return transformedState
			end, { 1 }),
			text("] = useState("),
			insert(2, "defaultValue"),
			text(")"),
		}),
		snip({ trig = "usf", namr = "useEffect" }, {
			text({ "useEffect(() => {", "" }),
			insert(1, "\t// Add your code here"),
			text({ "", "}, [" }),
			insert(2),
			text("])"),
			insert(0),
		}),
		snip({ trig = "usc", namr = "useCallback" }, {
			text({ "useCallback(() => {", "" }),
			insert(1, "\t// Add your code here"),
			text({ "", "}, [" }),
			insert(2),
			text("])"),
			insert(0),
		}),
	},
	typescript = {
		snip({ trig = "intf", namr = "interface" }, {
			text("interface "),
			insert(1),
			text(" {"),
			insert(2),
			text("}"),
		}),
	},
})
