VERSION = "0.1.0"

-- prettier
-- A micro plugin that automatically formats files using prettier on save

-- Plugin source: https://github.com/gamemaker1/micro-plugin-prettier
-- Prettier source: https://github.com/prettier/prettier

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
	tabWidth = "2",
	useTabs = "false",
	semi = "true",
	singleQuote = "false",
	quoteProps = "as-needed",
	jsxSingleQuotes = "false",
	trailingComma = "es5",
	bracketSpacing = "true",
	bracketSameLine = "false",
	arrowParens = "always",
	proseWrap = "preserve",
	endOfLine = "lf",
	embeddedLanguageFormatting = "auto",
	vueIndentScriptAndStyle = "false",
	htmlWhitespaceSensitivity = "css",
	requirePragma = "false",
	insertPragma = "false"
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
	if string.sub(pathToConfig, 1, 7) == "[error]" then
		for key, value in pairs(preferences) do
			value = file.Buf.Settings["prettier" .. "." .. key] or config.GetGlobalOption("prettier" .. "." .. key) or value

			options = options .. " --" .. key:gsub("%u", function (word)
				return "-" .. string.lower(word)
			end) .. "=" .. tostring(value)
		end
	end

	-- Run prettier
	local message, error = shell.RunCommand(
		"prettier" .. options .. " --no-color --write " .. file.Buf.Path
	)
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
	-- `formatOnSave`, then format away!
	if hasValue(prettierFileTypes, file.Buf:FileType()) and config.GetGlobalOption("prettier.formatOnSave") then
		format(file)
	end

	return true
end

-- Editor initialization hook
function init()
	-- Register prettier specific configuration
	for key, value in ipairs(preferences) do
		config.RegisterCommonOption("prettier", key, value)
	end
	-- Register plugin specific options
	config.RegisterCommonOption("prettier", "formatOnSave", true)
	
	-- Register the `format` command
	config.MakeCommand("format", format, config.NoComplete)
end