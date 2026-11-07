
return {
    {
        "rcasia/neotest-java",
        ft = "java",
        dependencies = {
            "mfussenegger/nvim-jdtls",
            "mfussenegger/nvim-dap",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
        },
    },
    {
        "nvim-neotest/neotest",
        dependencies = {
            "nvim-neotest/nvim-nio",
            "nvim-lua/plenary.nvim",
            "nvim-treesitter/nvim-treesitter",
        },
        config = function()
            local neotest = require("neotest")

            neotest.setup({
                adapters = {
                    require("neotest-java")({
                        incremental_build = true,
                    }),
                },

                summary = {
                    enabled = true,
                    follow = true,
                    expand_errors = true,
                },

                output = {
                    enabled = true,
                },

                output_panel = {
                    enabled = true,
                    open = "botright split | resize 15",
                },

                status = {
                    enabled = true,
                    signs = true,
                    virtual_text = true,
                },

                diagnostic = {
                    enabled = true,
                    severity = vim.diagnostic.severity.ERROR,
                },
            })

            -- =========================================
            -- Java Keymaps
            -- =========================================

            local group = vim.api.nvim_create_augroup(
                "NeotestJavaKeymaps",
                { clear = true }
            )

            local mappings = {
                {
                    "<leader>JtS",
                    function()
                        neotest.summary.toggle()
                    end,
                    "[J]ava [T]est [S]ummary",
                },
                {
                    "<leader>JtA",
                    function()
                        neotest.run.run({ suite = true })
                    end,
                    "[J]ava [T]est [A]ll",
                },
                {
                    "<leader>JtF",
                    function()
                        neotest.run.run(vim.fn.expand("%:p"))
                    end,
                    "[J]ava [T]est [F]ile",
                },
                {
                    "<leader>JtN",
                    function()
                        neotest.run.run()
                    end,
                    "[J]ava [T]est [N]earest",
                },
                {
                    "<leader>JtD",
                    function()
                        neotest.run.run({
                            strategy = "dap",
                        })
                    end,
                    "[J]ava [T]est [D]ebug",
                },
                {
                    "<leader>JtL",
                    function()
                        neotest.run.run_last()
                    end,
                    "[J]ava [T]est [L]ast",
                },
                {
                    "<leader>JtO",
                    function()
                        neotest.output.open({
                            enter = true,
                            last_run = true,
                        })
                    end,
                    "[J]ava [T]est [O]utput",
                },
                {
                    "<leader>Jto",
                    function()
                        neotest.output_panel.toggle()
                    end,
                    "[J]ava [T]est [o]utput panel",
                },
                {
                    "<leader>JtC",
                    function()
                        neotest.output_panel.clear()
                    end,
                    "[J]ava [T]est [C]lear output",
                },
                {
                    "<leader>JtX",
                    function()
                        neotest.run.stop({
                            interactive = true,
                        })
                    end,
                    "[J]ava [T]est Stop",
                },
            }

            -- =========================================
            -- Helpers
            -- =========================================

            local function has_jdtls(bufnr)
                local clients = vim.lsp.get_clients({
                    bufnr = bufnr,
                    name = "jdtls",
                })

                return #clients > 0
            end

            local function set_keymaps(bufnr)
                if not vim.api.nvim_buf_is_valid(bufnr) then
                    return
                end

                if vim.bo[bufnr].filetype ~= "java" then
                    return
                end

                if not has_jdtls(bufnr) then
                    return
                end

                for _, mapping in ipairs(mappings) do
                    vim.keymap.set(
                        "n",
                        mapping[1],
                        mapping[2],
                        {
                            buffer = bufnr,
                            silent = true,
                            desc = mapping[3],
                        }
                    )
                end
            end

            local function remove_keymaps(bufnr)
                for _, mapping in ipairs(mappings) do
                    pcall(
                        vim.keymap.del,
                        "n",
                        mapping[1],
                        { buffer = bufnr }
                    )
                end
            end

            -- =========================================
            -- LSP Attach / Detach
            -- =========================================

            vim.api.nvim_create_autocmd("LspAttach", {
                group = group,
                callback = function(args)
                    local client = vim.lsp.get_client_by_id(
                        args.data.client_id
                    )

                    if not client or client.name ~= "jdtls" then
                        return
                    end

                    set_keymaps(args.buf)
                end,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = group,
                callback = function(args)
                    local bufnr = args.buf

                    vim.schedule(function()
                        if not vim.api.nvim_buf_is_valid(bufnr) then
                            return
                        end

                        -- Another JDTLS client is still attached.
                        if has_jdtls(bufnr) then
                            return
                        end

                        remove_keymaps(bufnr)
                    end)
                end,
            })

            -- Handle already attached Java buffers.
            for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
                if vim.api.nvim_buf_is_valid(bufnr)
                    and vim.bo[bufnr].filetype == "java"
                then
                    set_keymaps(bufnr)
                end
            end
        end,
    },
}

