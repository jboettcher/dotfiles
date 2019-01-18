#!/bin/bash
CCLS_VERSION := c2cc556
CCLS_REPO_DIR := ~/.ccls/repo
CCLS_BUILD_DIR := ~/.ccls/build
CCLS_INSTALL_PREFIX := ~/.local
FZF_DIR := ~/.fzf
#---------------------------------------------------------------------------
install-packages:
	sudo apt-get install libncurses5-dev ninja-build python3-pip tmux cmake gdb
#---------------------------------------------------------------------------
install-config:
	cp git.conf ~/.gitconfig
	cp gdb.conf ~/.gdbinit
	cp tmux.conf ~/.tmux.conf
	mkdir -p ~/.ssh && cp ssh.conf ~/.ssh/config
	cp vim.conf ~/.vimrc
	cp vim.conf ~/.config/nvim/init.vim
	cp bash.conf ~/.bashrc
#---------------------------------------------------------------------------
install-ccls:
	pip3 install --user --upgrade pynvim
	rm -rf $(CCLS_REPO_DIR) $(CCLS_BUILD_DIR)
	git clone --recursive https://github.com/MaskRay/ccls $(CCLS_REPO_DIR)
	cd $(CCLS_REPO_DIR) && git checkout $(CCLS_VERSION)
	cd $(CCLS_REPO_DIR) && git submodule update --init --recursive
	mkdir -p $(CCLS_BUILD_DIR) $(CCLS_INSTALL_PREFIX)
	cd $(CCLS_BUILD_DIR) && cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=$(CCLS_INSTALL_PREFIX) $(CCLS_REPO_DIR)
	cd $(CCLS_BUILD_DIR) && ninja
	cd $(CCLS_BUILD_DIR) && ninja install
#---------------------------------------------------------------------------
install-fzf:
	if [ ! -d $(FZF_DIR) ]; then \
		git clone --depth 1 https://github.com/junegunn/fzf.git $(FZF_DIR); \
	fi
	$(FZF_DIR)/install
#---------------------------------------------------------------------------
install-neovim:
	sudo add-apt-repository ppa:neovim-ppa/stable -y
	sudo apt-get update -y
	sudo apt-get install neovim -y
#---------------------------------------------------------------------------
install-vim-plug:
	# Vim
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	# NeoVim
	curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#---------------------------------------------------------------------------
install-monokai:
	mkdir -p ~/.vim/colors
	cd ~/.vim/colors && wget https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim
	mkdir -p ~/.config/nvim/colors
	cd ~/.config/nvim/colors && wget https://raw.githubusercontent.com/sickill/vim-monokai/master/colors/monokai.vim
