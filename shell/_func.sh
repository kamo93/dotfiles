
function export_apps() {
	#version_14=v14.17.5
	#version_12=v12.18.3

	#npm_14_name_file=${version_14//[.]/_}
	#npm_12_name_file=${version_12//[.]/_}

	brew services stop --all
	brew bundle dump --file="$BREW_EXPORT_APPS_PATH" --force
	echo "brew apps & packages exported successfully on $BREW_EXPORT_APPS_PATH"

	#ls -1 /Users/kevin.mancera/.nvm/versions/node/$version_14/lib/node_modules | grep -v npm > "/Users/kevin.mancera/.dotfiles/npm-$npm_14_name_file.txt"
	#ls -1 /Users/kevin.mancera/.nvm/versions/node/$version_12/lib/node_modules | grep -v npm > "/Users/kevin.mancera/.dotfiles/npm-$npm_12_name_file.txt"
	#echo "NPM apps exported!"

	npm_versions=($(ls -1 /Users/kevin.mancera/.nvm/versions/node/))
	for i in $npm_versions
	do 		
		echo "exporting this version $i"
		file_name=${i//[.]/_}
		ls -1 /Users/kevin.mancera/.nvm/versions/node/$i/lib/node_modules | grep -v npm > "/Users/kevin.mancera/.dotfiles/npm-$file_name.txt"
	done
	echo "NPM apps exported!"

	
}

function import_apps() {
	brew services stop --all
	brew bundle --file="$BREW_EXPORT_APPS_PATH" --force
	echo "Brew apps imported correctly!"

	xargs -I_ npm install -g "_" <"/Users/kevin.mancera/.dotfiles/npm-v14_17_5.txt"
	echo "Npm 14 packages installed"
}
