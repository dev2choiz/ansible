-- if true then return {} end -- WARN: REMOVE THIS LINE TO ACTIVATE THIS FILE

-- AstroCommunity: import any community modules here
-- We import this file in `lazy_setup.lua` before the `plugins/` folder.
-- This guarantees that the specs are processed before any user plugins.

---@type LazySpec
return {
	"AstroNvim/astrocommunity",
	{ import = "astrocommunity.pack.lua" },
	-- import/override with your plugins folder
	{ import = "astrocommunity.colorscheme.dracula-nvim" },
	{ import = "astrocommunity.colorscheme.gruvbox-nvim" },
	{ import = "astrocommunity.colorscheme.catppuccin" },
	{ import = "astrocommunity.pack.go" },
	{ import = "astrocommunity.pack.typescript" },
	{ import = "astrocommunity.pack.eslint" },
	{ import = "astrocommunity.pack.html-css" },
	{ import = "astrocommunity.pack.docker" },
	{ import = "astrocommunity.utility.noice-nvim" },
	{ import = "astrocommunity.git.diffview-nvim" },
	--- https://github.com/mg979/vim-visual-multi/blob/a6975e7c1ee157615bbc80fc25e4392f71c344d4/doc/visual-multi.txt
	{ import = "astrocommunity.editing-support.vim-visual-multi" },
}
