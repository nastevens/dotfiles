-- Original from https://github.com/CosmicNvim/CosmicNvim

local actions = require("telescope.actions")
local telescope = require("telescope")
local trouble = require("trouble.providers.telescope")

local default_mappings = {
    i = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<c-v>"] = actions.file_vsplit,
        ["<c-s>"] = actions.file_split,
        ["<c-t>"] = trouble.open_with_trouble,
    },
    n = {
        ["<c-j>"] = actions.move_selection_next,
        ["<c-k>"] = actions.move_selection_previous,
        ["<c-q>"] = actions.smart_send_to_qflist + actions.open_qflist,
        ["<c-v>"] = actions.file_vsplit,
        ["<c-s>"] = actions.file_split,
        ["<c-t>"] = trouble.open_with_trouble,
        ["<cr>"] = actions.file_edit,
    },
}

local opts_cursor = {
    initial_mode = "normal",
    sorting_strategy = "ascending",
    layout_strategy = "cursor",
    results_title = false,
    layout_config = {
        width = 0.5,
        height = 0.4,
    },
}

local opts_vertical = {
    initial_mode = "normal",
    sorting_strategy = "ascending",
    layout_strategy = "vertical",
    results_title = false,
    layout_config = {
        width = 0.3,
        height = 0.5,
        prompt_position = "top",
        mirror = true,
    },
}

telescope.setup {
    defaults = {
        prompt_prefix = "🔍 ",
        mappings = default_mappings,
        dynamic_preview_title = true,
    },
    pickers = {
        buffers = {
            prompt_title = "Buffers",
            mappings = vim.tbl_deep_extend("force", {
                n = {
                    ["d"] = actions.delete_buffer,
                },
            }, default_mappings),
            sort_mru = true,
            preview_title = false,
        },
        lsp_code_actions = vim.tbl_deep_extend("force", opts_cursor, {
            prompt_title = "Code Actions",
        }),
        lsp_range_code_actions = vim.tbl_deep_extend("force", opts_vertical, {
            prompt_title = "Code Actions",
        }),
        lsp_document_diagnostics = vim.tbl_deep_extend("force", opts_vertical, {
            prompt_title = "Document Diagnostics",
            mappings = default_mappings,
        }),
        lsp_implementations = vim.tbl_deep_extend("force", opts_cursor, {
            prompt_title = "Implementations",
            mappings = default_mappings,
        }),
        lsp_definitions = vim.tbl_deep_extend("force", opts_cursor, {
            prompt_title = "Definitions",
            mappings = default_mappings,
        }),
        lsp_references = vim.tbl_deep_extend("force", opts_cursor, {
            prompt_title = "References",
            mappings = default_mappings,
        }),
        find_files = {
            prompt_title = "Files",
            mappings = default_mappings,
        },
        git_files = {
            prompt_title = "Git Files",
            mappings = default_mappings,
        },
        live_grep = {
            prompt_title = "Live Ripgrep",
            mappings = default_mappings,
        },
    },
    extensions = {
        ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
        },
    },
}

telescope.load_extension("ui-select")
telescope.load_extension("luasnip")
telescope.load_extension("neoclip")
