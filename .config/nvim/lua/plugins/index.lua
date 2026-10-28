return {
  {
    "neovim/nvim-lspconfig",
    opts = function(_, opts)
      opts.inlay_hints = opts.inlay_hints or {}
      opts.inlay_hints.enabled = true
      opts.inlay_hints.exclude = { "go" }

      opts.servers = opts.servers or {}
      opts.servers.kotlin_language_server = { enabled = false }
      opts.servers.kotlin_lsp = {}
      opts.servers.tailwindcss = {
        filetypes_exclude = {},
        filetypes_include = { "elm" },
        settings = {
          tailwindCSS = {
            includeLanguages = {
              elm = "html",
            },
            experimental = {
              classRegex = {
                { [[\bclass[\s(<|]+"([^"]*)"]] },
                { [[\bclass[\s(]+"[^"]*"\s+"([^"]*)"]] },
                { [[\bclass[\s<|]+"[^"]*"\s*\+{2}\s*" ([^"]*)"]] },
                { [[\bclass[\s<|]+"[^"]*"\s*\+{2}\s*" [^"]*"\s*\+{2}\s*" ([^"]*)"]] },
                { [[\bclass[\s<|]+"[^"]*"\s*\+{2}\s*" [^"]*"\s*\+{2}\s*" [^"]*"\s*\+{2}\s*" ([^"]*)"]] },
                { [[\bclassList[\s\[\(]+"([^"]*)"]] },
                { [[\bclassList[\s\[\(]+"[^"]*",\s[^\)]+\)[\s\[\(,]+"([^"]*)"]] },
                { [[\bclassList[\s\[\(]+"[^"]*",\s[^\)]+\)[\s\[\(,]+"[^"]*",\s[^\)]+\)[\s\[\(,]+"([^"]*)"]] },
              },
            },
          },
        },
      }
      opts.servers.elmls = {
        init_options = {
          elmPath = "lamdera",
          elmFormatPath = "elm-format --elm-version=elm-0.19.3",
          elmTestPath = "elm-test",
          elmReviewPath = "elm-review",
          elmReviewDiagnostics = "warning",
          disableElmLSDiagnostics = false,
          skipInstallPackageConfirmation = false,
          onlyUpdateDiagnosticsOnSave = false,
        },
      }

      return opts
    end,
  },
  { "calind/selenized.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "selenized",
    },
  },
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = {
          function(cmp)
            if cmp.snippet_active() then
              return cmp.accept()
            else
              return cmp.select_and_accept()
            end
          end,
          "snippet_forward",
          "fallback",
        },
      },
    },
  },
}
