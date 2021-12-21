VERSION = "2.0.0"

-- prettier
-- A micro plugin that automatically formats files using prettier on save

-- plugin source: https://github.com/gamemaker1/micro-plugin-prettier
-- prettier source: https://github.com/prettier/prettier

local micro = import("micro")
local shell = import("micro/shell")
local buffer = import("micro/buffer")
local config = import("micro/config")

-- Run prettier on any of these files
local prettierFileTypes = {
	"javascript",
	"typescript",
	"jsx", "tsx",
	"angular",
	"vue", "svelte",
	"flow",
	"css", "less", "scss",
	"html",
	"json", "yaml",
	"graphql",
	"markdown"
}
-- The default configuration for prettier
-- See https://prettier.io/docs/en/options.html
local preferences = {
	tabwidth = {
		flag = "--tab-width",
		default = 2
	},
	usetabs = {
		flag = "--use-tabs",
		default = false
	},
	semi = {
		flag = "--semi",
		default = true
	},
	singlequote = {
		flag = "--single-quote",
		default = false
	},
	quoteProps = {
		flag = "--quote-props",
		default = "as-needed",
	},
	jsxsinglequote = {
		flag = "--jsx-single-quote",
		default = false
	},
	trailingcomma = {
		flag = "--trailing-comma",
		default = "es5"
	},
	bracketspacing = {
		flag = "--bracket-spacing",
		default = true
	},
	bracketsameline = {
		flag = "--bracket-same-line",
		default = false
	},
	arrowparens = {
		flag = "--arrow-parens",
		default = "always"
	},
	wrap = {
		flag = "--prose-wrap",
		default = "preserve"
	},
	cols = {
		flag = "--print-width",
		default = 80
	},
	eol = {
		flag = "--end-of-line",
		default = "lf"
	},
	formatembeddedcode = {
		flag = "--embedded-language-formatting",
		default = "auto"
	},
	indentvuecode = {
		flag = "--vue-indent-script-and-style",
		default = false
	},
	htmlwhitespacesensitivity = {
		flag = "--html-whitespace-sensitivity",
		default = "css"
	},
	requirepragma = {
		flag = "--require-pragma",
		default = false
	},
	insertpragma = {
		flag = "--insert-pragma",
		default = false
	}
}

-- Check if a table has a certain value
local function hasValue(tab, val)
	for index, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

-- Retrieve a setting
function getOption(file, key, default)
	if file.Buf.Settings["prettier" .. "." .. key] ~= nil then
		-- If the local buffer"s settings has a value set for that option, return it
		return file.Buf.Settings["prettier" .. "." .. key]
	elseif config.GetGlobalOption("prettier" .. "." .. key) ~= nil then
		-- If the global settings has a value set for that option, return it
		return config.GetGlobalOption("prettier" .. "." .. key)
	else
		return default
	end
end

-- Format the given file
function format(file)
	-- Save the file first
	file:Save()

	-- Check if prettier can find user provided configuration
	local pathToConfig, error = shell.RunCommand(
		"prettier" .. " --no-color --find-config-path " .. file.Buf.Path
	)

	-- If not, then use the preferences set for this plugin
	local options = ""
	if error ~= nil then
		-- Loop through the options and create a long options string to pass to the
		-- prettier cli
		for option, value in pairs(preferences) do
			-- Check if the user has set a different value in:
			-- - local settings
			-- - global settings
			-- else use the default value
			value.default = tostring(getOption(file, option, value.default))

			-- Convert the option name to kebab case and append it to the existing
			-- option string
			options = options .. " " .. value.flag  .. "=" .. tostring(value.default)
		end
	end

	-- Run prettier on the file
	local command = "prettier" .. options .. " --no-color --write " .. file.Buf.Path
	local message, error = shell.RunCommand(command)
	-- If we encounter an error, flash a message on the bar at the bottom and dump
	-- the message in the logs
	if error ~= nil then
		micro.InfoBar():Error(
			"Prettier: an error occurred while formatting the file. Check the logs (Ctrl+E > log) for the full error."
		)
		buffer.Log(message)

		return
	end

	file.Buf:ReOpen()
end

-- On file save hook
function onSave(file)
	-- If the current file is of any of the above types and the user has enabled
	-- `autoformat`, then format away!
	if hasValue(prettierFileTypes, file.Buf:FileType()) and config.GetGlobalOption("prettier.autoformat") then
		format(file)
	end

	return true
end

-- Editor initialization hook
function init()
	-- Register prettier specific configuration
	for option, value in pairs(preferences) do
		config.RegisterCommonOption("prettier", option, value.default)
	end
	-- Register plugin specific options
	config.RegisterCommonOption("prettier", "autoformat", true)
	
	-- Register the `format` command
	config.MakeCommand("format", format, config.NoComplete)

	-- Register the help file
	config.AddRuntimeFile("prettier", config.RTHelp, "help/prettier.md")
end
