return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	dependencies = {
		"nvim-lua/plenary.nvim",
		"saghen/blink.cmp",
	},
	config = function()
		local jdtls = require("jdtls")

		local mason_path = vim.fn.stdpath("data") .. "/mason"

		local jdtls_path = mason_path .. "/packages/jdtls"
		local lombok_jar = jdtls_path .. "/lombok.jar"

		local java_debug_path = mason_path .. "/packages/java-debug-adapter"
		local java_test_path = mason_path .. "/packages/java-test"

		local bundles = {}
		vim.list_extend(
			bundles,
			vim.fn.glob(java_debug_path .. "/extension/server/com.microsoft.java.debug.plugin-*.jar", true, true)
		)

		local java_test_jars = vim.fn.glob(java_test_path .. "/extension/server/*.jar", true, true)
		for _, jar in ipairs(java_test_jars) do
			if not jar:match("runner") and not jar:match("jacocoagent") then
				table.insert(bundles, jar)
			end
		end

		local os_config = "linux"
		if vim.fn.has("mac") == 1 then
			os_config = "mac"
		elseif vim.fn.has("win32") == 1 then
			os_config = "win"
		end

		local root_markers =
			{ ".git", "mvnw", "gradlew", "pom.xml", "build.gradle", "build.gradle.kts", "settings.gradle" }

		local function start_jdtls()
			local root_dir = require("jdtls.setup").find_root(root_markers)
			if not root_dir then
				root_dir = vim.fn.getcwd()
				vim.notify("JDTLS: Project root not found, using " .. root_dir .. " as workspace.", vim.log.levels.WARN)
				return
			end

			local extendedClientCapabilities = jdtls.extendedClientCapabilities

			local config = {
				cmd = {
					"java",
					"-Declipse.application=org.eclipse.jdt.ls.core.id1",
					"-Dosgi.bundles.defaultStartLevel=4",
					"-Declipse.product=org.eclipse.jdt.ls.core.product",
					"-Dlog.protocol=true",
					"-Dlog.level=ALL",
					"-Xmx4g",
					"--add-modules=ALL-SYSTEM",
					"--add-opens",
					"java.base/java.util=ALL-UNNAMED",
					"--add-opens",
					"java.base/java.lang=ALL-UNNAMED",
					"-javaagent:" .. lombok_jar,
					"-jar",
					vim.fn.glob(jdtls_path .. "/plugins/org.eclipse.equinox.launcher_*.jar"),
					"-configuration",
					jdtls_path .. "/config_" .. os_config,
					"-data",
					vim.fn.stdpath("cache") .. "/jdtls/" .. vim.fn.fnamemodify(root_dir, ":p:h:t"),
				},
				root_dir = root_dir,
				capabilities = require("blink.cmp").get_lsp_capabilities(),

				settings = {
					extendedClientCapabilities = extendedClientCapabilities,
					java = {

						eclipse = { downloadSources = true },
						configuration = { updateBuildConfiguration = "interactive" },
						maven = { downloadSources = true },
						gradle = { enabled = true },
						implementationsCodeLens = { enabled = true },
						referencesCodeLens = { enabled = true },
						references = { includeDecompiledSources = true },
						signatureHelp = { enabled = true },
						contentProvider = { preferred = "fernflower" },
						symbols = {
							includeSourceMethodDeclarations = true,
						},
						inlayHints = {
							parameterNames = {
								enabled = "all",
							},
						},

						completion = {
							favoriteStaticMembers = {
								"org.hamcrest.MatcherAssert.assertThat",
								"org.hamcrest.Matchers.*",
								"org.junit.Assert.*",
								"org.junit.jupiter.api.Assertions.*",
								"org.mockito.Mockito.*",
							},
							filteredTypes = {
								"com.sun.*",
								"io.micrometer.shaded.*",
								"java.awt.*",
								"jdk.*",
								"sun.*",
							},
						},
						sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
					},
				},

				init_options = { bundles = bundles },

				on_attach = function(client, bufnr)
					if client:supports_method("textDocument/inlayHint") then
						vim.lsp.inlay_hint.enable(true, { bufnr = bufnr })
					end

					local opts = { buffer = bufnr }

					vim.keymap.set(
						"n",
						"<leader>Jo",
						jdtls.organize_imports,
						vim.tbl_extend("force", opts, { desc = "[J]ava [O]rganize Imports" })
					)
					vim.keymap.set(
						"n",
						"<leader>Jv",
						jdtls.extract_variable_all,
						vim.tbl_extend("force", opts, { desc = "[J]ava Extract [V]ariable" })
					)
					vim.keymap.set(
						"n",
						"<leader>Jc",
						jdtls.extract_constant,
						vim.tbl_extend("force", opts, { desc = "[J]ava Extract [C]onstant" })
					)
					vim.keymap.set(
						"n",
						"<leader>Jm",
						jdtls.extract_method,
						vim.tbl_extend("force", opts, { desc = "[J]ava Extract [M]ethod" })
					)
					vim.keymap.set(
						"n",
						"<leader>Jtc",
						jdtls.test_class,
						vim.tbl_extend("force", opts, { desc = "[J]ava [T]est [C]lass" })
					)
					vim.keymap.set("n", "<leader>Jgt", function()
						require("jdtls.tests").generate()
						vim.notify("Генерирую тестовый класс...", vim.log.levels.INFO)
					end, vim.tbl_extend("force", opts, { desc = "[J]ava [G]enerate [T]est" }))

					vim.keymap.set("n", "<leader>Jgs", function()
						require("jdtls.tests").goto_subjects()
					end, vim.tbl_extend("force", opts, { desc = "[J]ava [G]oto [S]ubjects" }))

					vim.keymap.set(
						"n",
						"<leader>Jtn",
						jdtls.test_nearest_method,
						vim.tbl_extend("force", opts, { desc = "[J]ava [T]est [N]earest" })
					)
					vim.keymap.set("n", "<leader>Jtcd", function()
						jdtls.test_class({ config_overrides = { noDebug = true } })
					end, vim.tbl_extend("force", opts, { desc = "[J]ava [T]est [C]lass (no [d]ebug)" }))

					vim.keymap.set("n", "<leader>Jr", function()
						require("jdtls").update_project_config()
						vim.notify(
							"JDTLS: конфигурация проекта обновлена (Gradle/Maven)",
							vim.log.levels.INFO
						)
					end, vim.tbl_extend("force", opts, { desc = "[J]ava [R]efresh project config" }))
				end,
			}

			jdtls.start_or_attach(config)
		end

		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = start_jdtls,
		})

		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				pcall(function()
					vim.fn.jobstart({ "gradle", "--stop" }, { detach = true })
				end)
				pcall(function()
					vim.fn.jobstart("pkill -f GradleDaemon", { detach = true })
				end)
			end,
		})
	end,
}
