return {
	"mfussenegger/nvim-jdtls",
	ft = { "java" },
	dependencies = { "nvim-lua/plenary.nvim" },
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
			-- === ГЛАВНЫЙ ФИКС: не запускаем без настоящего проекта ===
			local root_dir = require("jdtls.setup").find_root(root_markers)
			if not root_dir then
				vim.notify(
					"No Java project root found (no pom.xml/gradlew/.git etc.). jdtls skipped.",
					vim.log.levels.WARN
				)
				return
			end

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
				capabilities = require("cmp_nvim_lsp").default_capabilities(),

				settings = {
					java = {
						eclipse = { downloadSources = true },
						configuration = { updateBuildConfiguration = "interactive" },
						maven = { downloadSources = true },
						gradle = { enabled = true },
						implementationsCodeLens = { enabled = true },
						referencesCodeLens = { enabled = true },
						references = { includeDecompiledSources = true },
						signatureHelp = { enabled = true },
						completion = {
							favoriteStaticMembers = {
								"org.hamcrest.MatcherAssert.assertThat",
								"org.hamcrest.Matchers.*",
								"org.junit.Assert.*",
								"org.junit.jupiter.api.Assertions.*",
								"org.mockito.Mockito.*",
							},
						},
						sources = { organizeImports = { starThreshold = 9999, staticStarThreshold = 9999 } },
					},
				},

				init_options = { bundles = bundles },

				on_attach = function(client, bufnr)
					jdtls.setup_dap({ hotcodereplace = "auto" })
					require("jdtls.dap").setup_dap_main_class_configs()

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
						"<leader>Jt",
						jdtls.test_class,
						vim.tbl_extend("force", opts, { desc = "[J]ava [T]est Class" })
					)
					vim.keymap.set(
						"n",
						"<leader>Jn",
						jdtls.test_nearest_method,
						vim.tbl_extend("force", opts, { desc = "[J]ava Test [N]earest" })
					)
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

		-- Запуск только при открытии Java-файла
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "java",
			callback = start_jdtls,
		})

		-- === ГЛАВНЫЙ ФИКС №2: убиваем GradleDaemon при выходе ===
		vim.api.nvim_create_autocmd("VimLeavePre", {
			callback = function()
				-- Неблокирующие команды
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
