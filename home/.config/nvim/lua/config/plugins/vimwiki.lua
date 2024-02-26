local vimp = require("vimp")

if vim.env.DROPBOX then
    local wiki_base = {
        template_path = vim.env.DROPBOX .. "/vimwiki-html/assets/",
        template_default = "default",
        template_ext = ".tpl",
        auto_export = 0,
        nested_syntaxes = {
            bash = "bash",
            ebnf = "ebnf",
            groovy = "groovy",
            markdown = "markdown",
            python = "python",
            rust = "rust",
            sh = "sh",
            toml = "toml",
            verilog = "verilog",
            xml = "xml",
            zsh = "zsh",
        },
    }
    local wiki_personal = vim.tbl_deep_extend("force", wiki_base, {
        path = vim.env.DROPBOX .. "/vimwiki/",
        path_html = vim.env.DROPBOX .. "/vimwiki-html/",
    })

    local wiki_work = vim.tbl_deep_extend("force", wiki_base, {
        path = vim.env.DROPBOX .. "/work/vimwiki/",
        path_html = vim.env.DROPBOX .. "/work/vimwiki-html/",
    })
    vim.g.vimwiki_list = { wiki_personal, wiki_work }

    vim.g.vimwiki_global_ext = 0

    vim.cmd([[
        augroup vimwikiscratch
            autocmd!
            autocmd BufRead scratchpad.wiki setfiletype vimwiki
        augroup END
    ]])
end

-- Vimwiki mappings
vimp.nmap({ "override" }, "<leader>wp", "<cmd>norm 1<leader>ww<cr>")
vimp.nmap({ "override" }, "<leader>wo", "<cmd>norm 2<leader>ww<cr>")
vimp.nnoremap("<leader>sc", function()
    local path = vim.env.DROPBOX .. "/scratchpad.wiki"
    util.smart_open_file(path)
end)
