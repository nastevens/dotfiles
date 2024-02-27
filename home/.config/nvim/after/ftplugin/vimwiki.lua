local vimp = require("vimp")

local function project_link(name)
    return "* [[/projects/" .. name .. "|" .. name .. "]]"
end

local function project_template(name)
    return {
        "= " .. name .. " =",
        "",
        "== Reference ==",
    }
end

-- Creates a new project
vimp.nnoremap({ "buffer", "override" }, "<leader>wn", function()
    local name = vim.ui.input({ prompt = "New project name: " }, function(input)
        if input then
            local path = vim.call("vimwiki#vars#get_wikilocal", "path")
            local ext = vim.call("vimwiki#vars#get_wikilocal", "ext")
            local ft_is_vw = vim.call("vimwiki#u#ft_is_vw")
            local wiki_file = path .. "projects/" .. input .. ext

            -- When we return put the cursor on the link we create (one line
            -- below the current line)
            local pos = vim.fn.getpos(".")
            pos[2] = pos[2] + 1
            local prev_link = {
                vim.call("vimwiki#path#current_wiki_file"),
                pos,
            }

            -- Add link below current cursor position
            vim.fn.append(vim.fn.line("."), project_link(input))

            -- Write out the template and open it
            if vim.fn.filereadable(wiki_file) == 0 then
                vim.fn.writefile(project_template(input), wiki_file)
            end
            vim.call(
                "vimwiki#base#edit_file",
                "edit",
                wiki_file,
                "",
                prev_link,
                ft_is_vw
            )
        end
    end)
end)
