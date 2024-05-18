local ts_select_dir_for_grep = function(prompt_bufnr)
  local action_state = require "telescope.actions.state"
  local fb = require("telescope").extensions.file_browser
  local live_grep = require("telescope.builtin").live_grep
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

        live_grep {
          results_title = relative .. "/",
          cwd = absolute,
          default_text = current_line,
        }
      end)

      return true
    end,
  }
end

return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      { "prochri/telescope-all-recent.nvim", dependencies = { "kkharji/sqlite.lua" }, config = function() end },
      { "nvim-telescope/telescope-file-browser.nvim" },
    },
    config = function(plugin, opts)
      local custom_opts = {
        pickers = {
          live_grep = {
            mappings = {
              i = {
                ["<C-f>"] = ts_select_dir_for_grep,
              },
              n = {
                ["<C-f>"] = ts_select_dir_for_grep,
              },
            },
          },
        },
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

      require "astronvim.plugins.configs.telescope"(plugin, vim.tbl_deep_extend("force", opts, custom_opts))
      require("telescope").load_extension "file_browser"
      require("telescope-all-recent").setup {}
    end,
  },
}
