# #!/usr/bin/env sh

function install_vscode_extensions {
	local extensions=(
		"akamud.vscode-theme-onedark"
		"akamud.vscode-theme-onelight"
		# "bungcip.better-toml"
		"EditorConfig.EditorConfig"
		"eamodio.gitlens"
		"esbenp.prettier-vscode"
		# "GraphQL.vscode-graphql"
		"JakeBecker.elixir-ls"
		# "jetmartin.bats"
		# "josecfreittas.livebook"
		"marp-team.marp-vscode"
		"ms-vscode.atom-keybindings"
		"ms-vscode.makefile-tools"
		# "mtxr.sqltools"
		# "prokopiy.vscode-lfe-workbench"
		# "syler.sass-indented"
		"WallabyJs.quokka-vscode"
		# "XadillaX.viml"
	)

	for extension in $extensions; do
		code --install-extension $extension
	done
}

install_vscode_extensions
