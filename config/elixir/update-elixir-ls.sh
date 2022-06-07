# #!/usr/bin/env sh

# This script updates VS Code's ElixirLS to the version set below
# It works by

# https://dragoshmocrii.com/fix-vscode-elixirls-intellisense-for-code-imported-with-use/

function elixirls_update() {
	local elixirls_version="v0.9.0"

	if ! ls "${HOME}/.vscode/extensions" | grep "^jakebecker.elixir-ls" >/dev/null 2>&1; then
		echo "Aborting operation - extension not installed."
	else
		local random_suffix="$(head /dev/random | shasum | cut -c 1-8)"
		local timestamp="$(date '+%Y-%m-%dT%H-%M-%S')"

		local extension_dirname="$(ls -1 ${HOME}/.vscode/extensions | grep '^jakebecker.elixir-ls' | head -n 1)"
		local extension_dir="${HOME}/.vscode/extensions/${extension_dirname}"
		local extension_elixirls_dir="${extension_dir}/elixir-ls-release"
		local extension_elixirls_dir_backup="${extension_elixirls_dir}-${timestamp}-${random_suffix}.backup.tar.gz"

		# Backup of prev ElixirLS release dir
		# tar czf "${extension_elixirls_dir_backup}" "${extension_elixirls_dir}"

		local download_url="https://github.com/elixir-lsp/elixir-ls/releases/download/${elixirls_version}/elixir-ls.zip"
		local download_prefix="$(mktemp -d)"
		local elixirls_dir="${download_prefix}/elixir-ls-release"

		wget -P "${download_prefix}" "${download_url}"
		mkdir -p "${elixirls_dir}"
		unzip -d "${elixirls_dir}" "${download_prefix}/elixir-ls.zip"
		rm -fR "${extension_elixirls_dir}"
		mv "${elixirls_dir}" "${extension_dir}"

		# Clean up
		rm -fR "${download_prefix}"
	fi
}

elixirls_update
