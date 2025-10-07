return {
	"mfussenegger/nvim-lint",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		local lint = require("lint")

		local severities = {
			error = vim.diagnostic.severity.ERROR,
			warning = vim.diagnostic.severity.WARN,
			refactor = vim.diagnostic.severity.INFO,
			convention = vim.diagnostic.severity.HINT,
		}

		local function log_to_file(label, value)
			local log_dir = vim.fn.stdpath("cache")
			local log_path = log_dir .. "/golangci-lint-debug.log"
			vim.fn.mkdir(log_dir, "p")
			local f, err = io.open(log_path, "a")
			if not f then
				vim.api.nvim_err_writeln("log open failed: " .. tostring(err))
				return
			end
			f:write(("-%s-\n"):format(string.rep("-", 30)))
			f:write(os.date("%Y-%m-%d %H:%M:%S") .. " [" .. label .. "]\n")
			if type(value) == "table" then
				f:write(vim.inspect(value) .. "\n")
			else
				f:write(tostring(value) .. "\n")
			end
			f:close()
		end

		-- position extractor: prefer item.Pos if valid, else parse item.Text
		local function extract_pos(item, cwd)
			-- 1) Prefer structured Pos when it has non-trivial numbers
			if
				item.Pos
				and tonumber(item.Pos.Line)
				and tonumber(item.Pos.Line) > 1
				and tonumber(item.Pos.Column)
				and tonumber(item.Pos.Column) > 0
			then
				local abs = vim.fn.fnamemodify(item.Pos.Filename, ":p")
				return abs, tonumber(item.Pos.Line) - 1, tonumber(item.Pos.Column) - 1
			end

			-- 2) Fallback: parse a "path:line:col:" pattern inside Text
			-- e.g. "./main.go:10:2: declared and not used: a"
			local fname, line, col = string.match(item.Text or "", "([^:]+):(%d+):(%d+):")
			if fname and line and col then
				-- normalize path, make absolute if relative to cwd
				local candidate = fname
				if not vim.loop.fs_realpath(candidate) then
					candidate = cwd and (cwd .. "/" .. candidate) or candidate
				end
				local abs = vim.fn.fnamemodify(candidate, ":p")
				return abs, tonumber(line) - 1, tonumber(col) - 1
			end

			-- 3) Some issues may include LineRange (a Range object). Try that:
			if item.LineRange and item.LineRange.Start and item.LineRange.Start.Line then
				local ln = tonumber(item.LineRange.Start.Line)
				if ln then
					local filename = item.Pos and item.Pos.Filename
						or (cwd and cwd .. "/" .. (item.Filename or "") or "")
					local abs = vim.fn.fnamemodify(filename, ":p")
					return abs, ln - 1, 0
				end
			end

			-- 4) nothing reliable
			return nil
		end

		local getArgs = function()
			local ok, output = pcall(vim.fn.system, { "golangci-lint", "version" })
			if not ok then
				return
			end

			-- The golangci-lint install script and prebuilt binaries strip the v from the version
			--   tag so both strings must be checked
			if string.find(output, "version v1") or string.find(output, "version 1") then
				return {
					"run",
					"--out-format",
					"json",
					"--issues-exit-code=0",
					"--show-stats=false",
					"--print-issued-lines=false",
					"--print-linter-name=false",
					function()
						return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
					end,
				}
			end

			-- Omit --path-mode=abs, as it was added on v2.1.0
			-- Make sure it won't break v2.0.{0,1,2}
			if string.find(output, "version v2.0.") or string.find(output, "version 2.0.") then
				-- If the linter is not working as expected, users should explicitly add
				-- `run.relative-path-mode: wd` to their .golangci.yaml as a workaround to preserve the previous behavior.
				-- Prior to v2.0.0, the default for `run.relative-path-mode` was "wd".
				-- See: https://golangci-lint.run/product/migration-guide/#runrelative-path-mode

				return {
					"run",
					"--output.json.path=stdout",
					-- Overwrite values possibly set in .golangci.yml
					"--output.text.path=",
					"--output.tab.path=",
					"--output.html.path=",
					"--output.checkstyle.path=",
					"--output.code-climate.path=",
					"--output.junit-xml.path=",
					"--output.teamcity.path=",
					"--output.sarif.path=",
					"--issues-exit-code=0",
					"--show-stats=false",
					function()
						return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
					end,
				}
			end

			return {
				"run",
				"--output.json.path=stdout",
				-- Overwrite values possibly set in .golangci.yml
				"--output.text.path=",
				"--output.tab.path=",
				"--output.html.path=",
				"--output.checkstyle.path=",
				"--output.code-climate.path=",
				"--output.junit-xml.path=",
				"--output.teamcity.path=",
				"--output.sarif.path=",
				"--issues-exit-code=0",
				"--show-stats=false",
				-- Get absolute path of the linted file
				"--path-mode=abs",
				function()
					return vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":h")
				end,
			}
		end

		lint.linters_by_ft = {
			go = { "golangcilint" },
		}

		local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
		vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
			group = lint_augroup,
			callback = function()
				lint.try_lint()
			end,
		})

		lint.linters.golangcilint = {
			cmd = "golangci-lint",
			append_fname = false,
			args = getArgs(),
			stream = "stdout",
			parser = function(output, bufnr, cwd)
				if not output or output == "" then
					return {}
				end
				log_to_file("RAW OUTPUT (truncated)", output:sub(1, 2000))

				local ok, decoded = pcall(vim.json.decode, output)
				if not ok or not decoded or type(decoded) ~= "table" then
					log_to_file("JSON-DECODE-FAIL", decoded)
					return {}
				end

				log_to_file("DECODED OUTPUT", decoded)

				local diagnostics = {}
				for _, item in ipairs(decoded["Issues"] or {}) do
					-- get absolute path + zero-based line/col
					local file_abs, lnum0, col0 = extract_pos(item, cwd)

					log_to_file("POSITION PARAMETERS", { file_abs, lnum0, col0 })

					if file_abs then
						-- only keep diagnostics for the current buffer
						local curfile = vim.api.nvim_buf_get_name(bufnr)
						local curfile_abs = vim.fn.fnamemodify(curfile, ":p")

						log_to_file("CURFILE VALUES", { curfile, curfile_abs })

						-- if file_abs == curfile_abs then
						local sv = (severities and severities[item.Severity]) or vim.diagnostic.severity.WARN
						table.insert(diagnostics, {
							lnum = math.max(lnum0 or 0, 0),
							col = math.max(col0 or 0, 0),
							end_lnum = math.max(lnum0 or 0, 0),
							end_col = math.max((col0 and (col0 + 1)) or 1, 1),
							severity = sv,
							source = item.FromLinter,
							message = item.Text,
						})
						-- end
					else
						-- optionally log items we couldn't position
						log_to_file("UNPOSITIONED ITEM", item)
					end
				end

				log_to_file("DIAGNOSTICS", diagnostics)
				return diagnostics
			end,
		}
	end,
}
