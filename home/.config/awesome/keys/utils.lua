local awful = require("awful")

local modifiers = {
    ["M"] = "Mod4",
    ["A"] = "Mod1",
    ["S"] = "Shift",
    ["C"] = "Control",
}

local function split(s)
    local res = {}
    for m in string.gmatch(s, "([^-]+)") do
        table.insert(res, m)
    end
    return res
end

local function parse_key(keydef)
    local modkeys = {}
    for _, key in ipairs(split(keydef)) do
        if modifiers[key] ~= nil then
            table.insert(modkeys, modifiers[key])
        else
            return modkeys, key
        end
    end
end

local function add_key(keys, description, group, fn)
    local modkeys, key = parse_key(keys)
    return awful.key(modkeys, key, fn, {
        description = description,
        group = group,
    })
end

return {
    add_key = add_key,
}
