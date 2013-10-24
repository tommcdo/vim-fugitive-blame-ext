Fugitive Blame Extension
========================

This plugin extends the functionality of [tpope's fugitive][f] plugin. When
installed, it shows the first line of the commit message for the commit under
the cursor in a `:Gblame` window.

Installation
------------

Install this plugin alongside the existing [fugitive][f] plugin. If you don't
have a preferred installation method, I recommend installing [pathogen.vim][p],
and then simply copy and paste:

	cd ~/.vim/bundle
	git clone https://github.com/tommcdo/vim-fugitive-blame-ext.git

Usage
-----

When running the `:Gblame` command from fugitive, moving your cursor over lines
in the blame window will display the first line of the commit message at the
bottom of the screen.

There's no documentation for this plugin because there are more words in this
sentence than there would be in that help file.

[f]: https://github.com/tpope/vim-fugitive
[p]: https://github.com/tpope/vim-pathogen
