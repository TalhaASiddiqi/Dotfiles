local ts_select_dir_for_grep = function(cb)
  return function(prompt_bufnr)
    local action_state = require "telescope.actions.state"
    local fb = require("telescope").extensions.file_browser
    local current_line = action_state.get_current_line()

    fb.file_browser {
      files = false,
      depth = false,
      attach_mappings = function(prompt_bufnr)
        require("telescope.actions").select_default:replace(function()
          local entry_path = action_state.get_selected_entry().Path
          local dir = entry_path:is_dir() and entry_path or entry_path:parent()
          local relative = dir:make_relative(vim.fn.getcwd())
          local absolute = dir:absolute()

          cb {
            results_title = relative .. "/",
            cwd = absolute,
            default_text = current_line,
          }
        end)

        return true
      end,
    }
  end
end

local add_harpoon_daddy = function()
  local action_state = require "telescope.actions.state"
  local current_line = action_state.get_selected_entry()

  local harpoon = require "harpoon"
  local entry_path = vim.fn.fnamemodify(current_line[1], ":p")
  harpoon:list():add { value = entry_path }
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "prochri/telescope-all-recent.nvim",         dependencies = { "kkharji/sqlite.lua" }, config = function() end },
      { "nvim-telescope/telescope-file-browser.nvim" },
      {
        "nvim-telescope/telescope-live-grep-args.nvim",
        -- This will not install any breaking changes.
        -- For major updates, this must be adjusted manually.
        version = "^1.0.0",
      },
    },
    config = function(plugin, opts)
      local lga_actions = require "telescope-live-grep-args.actions"
      local live_grep = require("telescope.builtin").live_grep
      local grep_string = require("telescope.builtin").grep_string

      local mappings = {
        all_pickers = {
          ["<C-h>"] = add_harpoon_daddy,
        },
        grep_string = {
          ["<C-f>"] = ts_select_dir_for_grep(grep_string),
        },
        live_grep = {
          ["<C-f>"] = ts_select_dir_for_grep(live_grep),
        },
      }
      local pickers = {
        "find_files",
        "live_grep",
        "grep_string",
      }
      local modes = {
        "n",
        "i",
      }

      local picker_settings = {}

      for _, picker in pairs(pickers) do
        local current_picker = {}
        for _, mode in pairs(modes) do
          -- First add all the global mappings
          local current_mode = vim.tbl_extend("error", {}, mappings.all_pickers)

          if mappings[picker] ~= nil then
            -- Then add any mode specific mappings
            if mappings[picker][mode] ~= nil then
              current_mode = vim.tbl_extend("error", current_mode, mappings[picker][mode])
              mappings[picker][mode] = nil
            end

            -- finally add mappings for all modes
            current_mode = vim.tbl_extend("error", current_mode, mappings[picker])
          end

          current_picker[mode] = current_mode
        end
        picker_settings[picker] = { mappings = current_picker }
      end

      local custom_opts = {
        extensions = {
          live_grep_args = {
            auto_quoting = true,
            mappings = {
              i = {
                ["<C-k>"] = lga_actions.quote_prompt(),
                ["<C-i>"] = lga_actions.quote_prompt { postfix = " --iglob " },
                ["<C-space>"] = lga_actions.to_fuzzy_refine,
                ["<C-f>"] = function()
                  ts_select_dir_for_grep(require("telescope").extensions.live_grep_args.live_grep_args)()
                end,
              },
              n = {
                ["<C-f>"] = function()
                  ts_select_dir_for_grep(require("telescope").extensions.live_grep_args.live_grep_args)()
                end,
              },
            },
          },
        },
        pickers = picker_settings,
        defaults = {
          preview = {
            filetype_hook = function(filepath, bufnr, opts)
              local is_image = function(filepath)
                local image_extensions = { "png", "jpg", "svg" } -- Supported image formats
                local split_path = vim.split(filepath:lower(), ".", { plain = true })
                local extension = split_path[#split_path]
                return vim.tbl_contains(image_extensions, extension)
              end
              if is_image(filepath) then
                local term = vim.api.nvim_open_term(bufnr, {})
                local function send_output(_, data, _)
                  for _, d in ipairs(data) do
                    vim.api.nvim_chan_send(term, d .. "\r\n")
                  end
                end
                -- local preview = opts.get_preview_window()
                vim.fn.jobstart({
                  "chafa",
                  "--animate=off",
                  "--center=on",
                  "--clear",
                  -- "--size",
                  -- "" .. preview.width .. "x" .. preview.height,
                  filepath, -- Terminal image viewer command
                }, {
                  on_stdout = send_output,
                  on_stderr = function(_, data, _) print(data) end,
                  stdout_buffered = true,
                  pty = true,
                })
                return false
              else
                return true
              end
            end,
          },
        },
      }

      require "astronvim.plugins.configs.telescope" (plugin, vim.tbl_deep_extend("force", opts, custom_opts))
      require("telescope").load_extension "file_browser"
      require("telescope-all-recent").setup {}
      require("telescope").load_extension "live_grep_args"
    end,
  },
}
