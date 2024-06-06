-- Convenient way of storing all options without shorthand var assignments
local options = {
  opt = {
    showmode = false, -- Disable default statusline
    lazyredraw = true, -- Screen will not be redrawn while executing macros, registers, etc.
    backup = false, -- Don't create backup files
    undofile = true, -- Track 'undo's between sessions
    undolevels = 10000,
    clipboard = "unnamedplus", -- Allows neovim to access the system clipboard
    cmdheight = 0, -- More space in the neovim command line for displaying messages
    completeopt = { "menu", "menuone", "noselect" },
    conceallevel = 0, -- So that `` is visible in markdown files
    fileencoding = "utf-8", -- The encoding used when writing to files
    foldmethod = "manual", -- Folding, set to "expr" for treesitter based folding
    foldexpr = "", -- Set to "nvim_treesitter#foldexpr()" for treesitter based folding
    hidden = true, -- Required to keep multiple buffers and open multiple buffers
    hlsearch = true, -- Highlight all matches on previous search pattern
    inccommand = "nosplit", -- Preview %s while typing
    incsearch = true, -- Update highlights/search while typing
    ignorecase = true, -- Ignore case in search patterns
    smartcase = true, -- Smart case
    wildmenu = true, -- Tab completion on command line
    wildmode = "longest:full,full", -- Command-line completion mode
    mouse = "nv", -- Only enable mouse in normal and visual mode
    mousescroll = "ver:3,hor:0", -- Scroll vertically by 3 lines, disable horizontal scrolling
    pumheight = 10, -- Popup menu height
    pumblend = 10, -- Popup blend
    grepformat = "%f:%l:%c:%m", -- filename:line number:column number:error message
    grepprg = "rg --vimgrep --smart-case --no-heading", -- Search using rg
    splitbelow = true, -- Force all horizontal splits to go below current window
    splitright = true, -- Force all vertical splits to go on the right of current window
    splitkeep = "screen", -- Keep current window position
    swapfile = false, -- Disable the use of swapfiles
    termguicolors = true, -- Set term gui colors (most terminals support this)
    timeoutlen = 1000, -- Time to wait for a mapped sequence to complete (in milliseconds)
    title = true, -- Set the title of windoww to the value of the titlestring
    -- titlestring = "%<%F%=%l/%L - nvim" -- Format of what the window title will be set to
    updatetime = 100, -- Faster completion
    writebackup = false, -- If a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
    expandtab = true, -- Convert tabs to spaces
    smarttab = true, -- <Tab> at the start of a line behaves as expected
    autoindent = true, -- Keep indentation on new line
    smartindent = true, -- Add extra indent where it makes sense
    shiftwidth = 2, -- >>, << shift line by 2 spaces
    tabstop = 2, -- Insert 2 spaces for a tab
    softtabstop = 2, -- <Tab> behaves as 2 spaces when editing
    cursorline = false, -- Don't highlight the current line
    number = true, -- Show numbered lines
    numberwidth = 4, -- Set the width of the numbers column, default: 4
    relativenumber = true, -- Make the numbered lines relative to current line
    signcolumn = "yes", -- Always show the sign column, otherwise it would shift the text each time
    wrap = false, -- Display lines as one long line
    linebreak = true, -- IF `opt.wrap` is enabled, only break between words
    scrolloff = 8, -- Minimum number of lines to keep both above and below current line
    sidescrolloff = 8, -- Minimum number of columns to keep both infront and behind the cursor
    spelllang = { "en", "sv" },
    showcmd = false,
    ruler = false,
    laststatus = 3,
  },
}

-- Additional settings which cannot be set via `options` above
vim.opt.spelllang:append("cjk") -- Disable spellchecking for asian characters (VIM algorithm does not support it)
vim.opt.shortmess:append("a") -- Decrease message size, make them shorter
vim.opt.shortmess:append("c") -- Don't show redundant messages from ins-completion-menu
vim.opt.shortmess:append("I") -- Don't show the default intro message
vim.opt.whichwrap:append("<,>,[,],h,l")

-- Add filetype aliases
vim.filetype.add({
  extension = {
    tex = "tex",
    zir = "zir",
    cr = "crystal",
  },
  pattern = {
    ["[jt]sconfig.*.json"] = "jsonc",
  },
})

vim.o.statusline = "%!v:lua.require('libs.statusline')()"

-- Iterate K-V table options above to assign values
--  scope = g, o, opts, etc.
--  collection = all options within scope
--  key, value = K-V within collection
for scope, collection in pairs(options) do
  for key, value in pairs(collection) do
    vim[scope][key] = value
  end
end
