
function create_links() {
	ln -sf "$DOTFILES_PATH/.zshrc" "~/.zshrc"
	ln -sf "$DOTFILES_PATH/.tmux.config" "~/.tmux.config"
	ln -sf "$DOTFILES_PATH/.ideavimrc" "~/.ideavimrc"
	ln -sf "$DOTFILES_PATH/.gitconfig" "~/.gitconfig"
	ln -sf "$DOTFILES_PATH/.alacritty" "~/.alacritty"
	ln -sf "$DOTFILES_PATH/nvim/" "~/.config"
}
