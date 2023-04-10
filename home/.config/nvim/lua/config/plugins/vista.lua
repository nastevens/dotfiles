local ICON_MAP = {
    { "", "class" },
    { "", "const", "constant" },
    { "略", "constructor" },
    { " ", "augroup", "default", "map" },
    { "", "enum", "enumerator" },
    { "", "field", "fields" },
    { "", "func", "function", "functions" },
    { "", "implementation", "interface" },
    { "", "macro", "macros" },
    { "", "enummember", "member" },
    { "", "method", "subroutine" },
    { " ", "module", "modules", "package", "packages" },
    { "", "namespace" },
    { "襁", "property" },
    { "", "struct" },
    { "", "target" },
    { "", "type", "typeParameter", "typedef", "types" },
    { "", "union" },
    { "", "var", "variable", "variables" },
}

local icon
local icons = {}
for _, kind in ipairs(ICON_MAP) do
    for i, v in ipairs(kind) do
        if i == 1 then
            icon = v
        else
            icons[v] = icon
        end
    end
end

vim.g["vista#renderer#icons"] = icons
