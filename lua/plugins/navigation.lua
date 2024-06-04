--- Holds plugins used mainly for navigation and searching
return {
  -- Telescope
  {
    "telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      { "nvim-treesitter/nvim-treesitter" },
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        build = "cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build",
      },
    },
    cmd = "Telescope",
    init = function()
      local builtin = require("telescope.builtin")
      local map = vim.keymap

      map.set(
        "n",
        "<leader>e",
        "<cmd>Telescope file_browser path=%:p:h select_buffer=true grouped=true hidden=true<CR>",
        { desc = "File browser" }
      )
      map.set("n", "<leader><space>", builtin.find_files, { desc = "Quick find" })
      map.set("n", "<leader>q", builtin.live_grep, { desc = "Grep search" })
    end,
    opts = function()
      return {
        defaults = {
          vimgrep_arguments = {
            "rg",
            "--follow", -- Follow symbolic links
            "--hidden", -- Search for hidden files
            "--no-heading", -- Don't group matches by each file
            "--with-filename", -- Print the file path with the matched lines
            "--line-number", -- Show line numbers
            "--column", -- Show column numbers
            "--smart-case", -- Smart case search
            "--color=never", -- Disable colors

            -- Exclude some patterns from search
            "--glob=!**/.git/*",
            "--glob=!**/.idea/*",
            "--glob=!**/.vscode/*",
            "--glob=!**/build/*",
            "--glob=!**/dist/*",
            "--glob=!**/yarn.lock",
            "--glob=!**/package-lock.json",
          },
          previewer = true,
          file_previewer = require("telescope.previewers").vim_buffer_cat.new,
          grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
          qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
        },
        pickers = {
          find_files = {
            hidden = true,
            -- needed to exclude some files & dirs from general search
            -- when not included or specified in .gitignore
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--glob=!**/.git/*",
              "--glob=!**/.idea/*",
              "--glob=!**/.vscode/*",
              "--glob=!**/build/*",
              "--glob=!**/dist/*",
              "--glob=!**/yarn.lock",
              "--glob=!**/package-lock.json",
            },
          },
        },
        extensions = {
          file_browser = {
            theme = "ivy",
            grouped = true,
            hidden = {
              file_browser = true,
              folder_browser = true,
            },
            no_ignore = true,
            hijack_netrw = true,
            create_from_prompt = false,
          },
          ["ui-select"] = {},
          fzf = {
            fuzzy = true, -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true, -- override the file sorter
            case_mode = "smart_case", -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
        },
        extensions_list = {
          "file_browser",
          "ui-select",
          "fzf",
        },
      }
    end,
    config = function(_, opts)
      local telescope = require("telescope")
      telescope.setup(opts)

      -- Load extensions
      for _, ext in ipairs(opts.extensions_list) do
        telescope.load_extension(ext)
      end
    end,
  },
  -- Telescope file browser
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = {
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim",
    },
  },
  -- Set `vim.ui.select` to telescope
  { "nvim-telescope/telescope-ui-select.nvim" },
  -- Icons
  { "nvim-tree/nvim-web-devicons" },
  -- Harpoon - bookmark files/tabs
  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim",
    },
    config = function()
      local harpoon = require("harpoon")
      -- Setup
      harpoon:setup({})

      -- Telescope integration
      local conf = require("telescope.config").values
      ---@param harpoon_files? table
      local function toggle_telescope(harpoon_files)
        harpoon_files = harpoon_files or {}
        local file_paths = {}
        for _, item in ipairs(harpoon_files.items) do
          table.insert(file_paths, item.value)
        end

        require("telescope.pickers")
          .new({}, {
            prompt_title = "Harpoon",
            finder = require("telescope.finders").new_table({
              results = file_paths,
            }),
            previewer = conf.file_previewer({}),
            sorter = conf.generic_sorter({}),
          })
          :find()
      end

      -- Keymaps
      local map = vim.keymap
      map.set("n", "<leader>a", function()
        harpoon:list():add()
      end, { desc = "Add to harpoon" })
      map.set("n", "<leader>A", function()
        harpoon:list():remove()
      end, { desc = "Remove from harpoon" })
      map.set("n", "<C-e>", function()
        toggle_telescope(harpoon:list())
      end, { desc = "Toggle harpoon menu" })

      map.set("n", "<C-h>", function()
        harpoon:list():select(1)
      end)
      map.set("n", "<C-t>", function()
        harpoon:list():select(2)
      end)
      map.set("n", "<C-n>", function()
        harpoon:list():select(3)
      end)
      map.set("n", "<C-s>", function()
        harpoon:list():select(4)
      end)

      -- Toggle previous & next buffers stored within Harpoon list
      map.set("n", "<C-S-P>", function()
        harpoon:list():prev()
      end)
      map.set("n", "<C-S-N>", function()
        harpoon:list():next()
      end)
    end,
  },
}
