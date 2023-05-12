-- Name:         Grayspace
-- Description:  Neovim version of spacegray theme
-- Author:       Nick Stevens <nick@bitcurry.com>
-- Maintainer:   Nick Stevens <nick@bitcurry.com>
-- Website:      https://github.com/nastevens/grayspace.nvim
-- License:      Vim License (see `:help license`)

local Color, c, Group, g, s = require("colorbuddy").setup()

Color.new("white", "#cccccc")
Color.new("white_lt", "#ffffff")
Color.new("white_dk", "#999999")
Color.new("gray", "#666666")
Color.new("black", "#191919")
Color.new("black_lt", "#333333")
Color.new("black_dk", "#000000")
Color.new("yellow", "#bf9a59")
Color.new("yellow_lt", "#ffcd77")
Color.new("yellow_dk", "#7f663b")
Color.new("orange", "#bf6d26")
Color.new("orange_lt", "#ff9232")
Color.new("orange_dk", "#7f4919")
Color.new("lime", "#37ff00")
Color.new("green", "#8bbf54")
Color.new("green_lt", "#b9ff70")
Color.new("green_dk", "#5c7f38")
Color.new("red", "#bf4a4a")
Color.new("red_lt", "#ff6363")
Color.new("red_dk", "#7f3131")
Color.new("red_alert", "#ff0019")
Color.new("purple", "#a481bf")
Color.new("purple_lt", "#dbadff")
Color.new("purple_dk", "#6d567f")
Color.new("blue", "#7aabbf")
Color.new("blue_lt", "#a3e4ff")
Color.new("blue_dk", "#8380b2")

-- Vim UI elements
Group.new("Normal", c.white, c.black)
Group.new("NormalNC", c.white, c.black)
Group.new("Bold", c.none, c.none, s.bold)
Group.new("Debug", c.none, c.red)
Group.new("Directory", c.none, c.none)
Group.new("Error", c.red_alert, c.none)
Group.new("ErrorMsg", c.red_alert, c.none)
Group.new("FoldColumn", c.none, c.none)
Group.new("Folded", c.gray, c.none)
Group.new("IncSearch", c.none, c.purple)
Group.new("Italic", c.none, c.none, s.italic)
Group.new("MatchParen", c.none, c.black_lt)
Group.new("ModeMsg", c.none, c.none)
Group.new("MoreMsg", c.none, c.none)
Group.new("Question", c.none, c.none)
Group.new("Search", c.none, c.purple_dk:dark())
Group.new("Substitute", c.none, c.purple_dk:dark())
Group.new("Underlined", c.none, c.none, s.underline)
Group.new("Visual", c.none, c.purple_dk:dark())
Group.new("VisualNOS", c.none, c.purple_dk:dark())
Group.new("WarningMsg", c.yellow, c.none)
Group.new("WildMenu", c.none, c.none)
Group.new("Title", c.blue_dk, c.none, s.bold)
Group.new("Conceal", c.none, c.none)
Group.new("Cursor", c.none, c.none)
Group.new("NonText", c.none, c.none)
Group.new("LineNr", c.white_dk, c.none)
Group.new("SignColumn", c.white, c.black)
-- Interferes with galaxyline for some reason
-- Group.link("StatusLine", c.none, c.none)
-- Group.link("StatusLineNC", c.none, c.none)
Group.new("VertSplit", c.white_dk, c.none)
Group.new("ColorColumn", c.none, c.black_lt)
Group.new("CursorColumn", c.none, c.none)
Group.new("CursorLine", c.none, c.black_lt)
Group.new("CursorLineNr", c.none, c.black_lt)
Group.new("QuickFixLine", c.none, c.black_lt)
Group.new("PMenu", c.none, c.black_lt)
Group.new("PMenuSel", c.none, c.gray)
Group.new("TabLine", c.none, c.none)
Group.new("TabLineFill", c.none, c.none)
Group.new("TabLineSel", c.none, c.none)

-- Standard syntax highlighting
Group.new("Boolean", c.orange_lt, c.none)
Group.new("Character", c.green, c.none)
Group.new("Comment", c.gray, c.none)
Group.new("Conditional", c.purple_lt, c.none)
Group.new("Constant", c.orange_lt, c.none)
Group.new("Define", c.blue_lt)
Group.new("Delimiter", c.purple, c.none)
Group.new("Exception", c.purple_lt, c.none)
Group.new("Float", c.orange_lt, c.none)
Group.new("Function", c.red_lt, c.none)
Group.new("Identifier", c.white_lt, c.none)
Group.new("Include", c.blue_lt, c.none)
Group.new("Keyword", c.purple_lt, c.none)
Group.new("Label", c.blue_dk, c.none)
Group.new("Macro", c.blue_lt, c.none)
Group.new("Number", c.orange_lt, c.none)
Group.new("Operator", c.purple, c.none)
Group.new("PreProc", c.blue_lt, c.none)
Group.new("Repeat", c.purple_lt, c.none)
Group.new("Special", c.blue_dk, c.none)
Group.new("SpecialChar", c.blue_dk, c.none)
Group.new("SpecialKey", c.blue_dk, c.none)
Group.new("Statement", c.purple_lt, c.none)
Group.new("StorageClass", c.purple_lt, c.none)
Group.new("String", c.green, c.none)
Group.new("Structure", c.purple_lt, c.none)
Group.new("Tag", c.yellow_lt, c.none)
Group.new("Todo", c.black, c.white)
Group.new("Type", c.white_lt, c.none)
Group.new("Typedef", c.purple_lt, c.none)

-- Treesitter highlighting
Group.new("TSAnnotation", c.white_lt, c.none)
Group.new("TSAttribute", c.white_lt, c.none)
Group.link("TSBoolean", g.Boolean)
Group.link("TSCharacter", g.Character)
Group.link("TSComment", g.Comment)
Group.link("TSConditional", g.Conditional)
Group.new("TSConstBuiltin", c.yellow_lt, c.none)
Group.new("TSConstMacro", c.yellow_lt, c.none)
Group.link("TSConstant", g.Constant)
Group.new("TSConstructor", c.red_lt, c.none)
Group.new("TSDanger", c.white, c.red_alert)
Group.new("TSEmphasis", c.none, c.none, s.bold)
Group.new("TSEnvironment", c.purple_lt, c.none)
Group.new("TSEnvironmentName", c.purple_lt, c.none)
Group.new("TSError", c.red_alert, c.none)
Group.link("TSException", g.Keyword)
Group.link("TSField", g.Normal)
Group.link("TSFloat", g.Float)
Group.link("TSFunction", g.Function)
Group.link("TSFuncBuiltin", g.Function)
Group.link("TSFuncMacro", g.PreProc)
Group.link("TSInclude", g.Include)
Group.link("TSKeyword", g.Keyword)
Group.link("TSKeywordFunction", g.Keyword)
Group.link("TSKeywordOperator", g.Keyword)
Group.link("TSKeywordReturn", g.Keyword)
Group.link("TSLabel", g.Label)
Group.new("TSLiteral", c.none, c.none)
Group.new("TSMath", c.blue_dk, c.none)
Group.new("TSMethod", g.TSFunction, c.none)
Group.new("TSNamespace", c.blue_lt, c.none)
Group.link("TSNone", g.Normal)
Group.new("TSNote", c.blue_lt, c.none)
Group.link("TSNumber", g.Number)
Group.link("TSOperator", g.Operator)
Group.link("TSParameter", g.Normal)
Group.link("TSParameterReference", g.Normal)
Group.link("TSProperty", g.Normal)
Group.link("TSPunctBracket", g.Normal)
Group.link("TSPunctDelimiter", g.Delimiter)
Group.new("TSPunctSpecial", c.purple, c.none)
Group.link("TSRepeat", g.Keyword)
Group.new("TSStrike", c.none, c.none, s.strikethrough)
Group.link("TSString", g.String)
Group.new("TSStringEscape", c.blue_dk, c.none)
Group.new("TSStringRegex", c.green_lt, c.none)
Group.new("TSStringSpecial", c.blue_dk, c.none)
Group.new("TSStrong", c.none, c.none, s.bold)
Group.link("TSSymbol", g.Normal)
Group.link("TSTag", g.Tag)
Group.link("TSTagAttribute", g.Normal)
Group.link("TSTagDelimiter", g.Normal)
Group.new("TSText", c.blue_dk, c.none)
Group.new("TSTextReference", c.none, c.none, s.italic)
Group.new("TSTitle", g.TSText, c.none, s.bold)
Group.new("TSType", g.Type)
Group.new("TSTypeBuiltin", c.yellow_lt, c.none)
Group.new("TSURI", g.Normal, c.none, s.underline)
Group.new("TSUnderline", g.Normal, c.none, s.underline)
Group.new("TSVariable", g.Normal, c.none)
Group.new("TSVariableBuiltin", c.purple, c.none)
Group.new("TSWarning", c.yellow_lt, c.none)
Group.new("@text.literal", c.white_lt, c.none)

-- Diff highlighting
Group.new("DiffAdd", c.green, c.none)
Group.new("DiffChange", c.yellow, c.none)
Group.new("DiffDelete", c.red, c.none)
Group.new("DiffText", c.white, c.none)
Group.new("DiffAdded", c.green, c.none)
Group.new("DiffFile", c.white, c.none)
Group.new("DiffNewFile", c.green, c.none)
Group.new("DiffLine", c.red, c.none)
Group.new("DiffRemoved", c.red, c.none)

-- Spelling highlighting
Group.new("SpellBad", c.red)
Group.new("SpellLocal", c.red)
Group.new("SpellCap", c.red)
Group.new("SpellRare", c.red)

-- Vimwiki
Color.new("VimwikiTitle", "#b3b8c4")
Color.new("VimwikiLink", "#5f8787")
Group.new("VimwikiHeader1", c.VimwikiTitle, c.none, s.bold)
Group.new("VimwikiHeader2", c.VimwikiTitle, c.none, s.bold)
Group.new("VimwikiHeader3", c.VimwikiTitle, c.none, s.bold)
Group.new("VimwikiListTodo", c.yellow, c.none)
Group.new("VimwikiLink", c.VimwikiLink, c.none, s.underline)
