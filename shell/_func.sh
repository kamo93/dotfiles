
function export_apps() {
	version_14=v14.17.5
	version_12=v12.18.3

	npm_14_name_file=${version_14//[.]/_}
	npm_12_name_file=${version_12//[.]/_}

	brew services stop --all
	brew bundle dump --file="$BREW_EXPORT_APPS_PATH" --force
	echo "brew apps & packages exported successfully on $BREW_EXPORT_APPS_PATH"

	ls -1 /Users/kevin.mancera/.nvm/versions/node/$version_14/lib/node_modules | grep -v npm > "/Users/kevin.mancera/.dotfiles/npm-$npm_14_name_file.txt"
	ls -1 /Users/kevin.mancera/.nvm/versions/node/$version_12/lib/node_modules | grep -v npm > "/Users/kevin.mancera/.dotfiles/npm-$npm_12_name_file.txt"
	echo "NPM apps exported!"
	
}
