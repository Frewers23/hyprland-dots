return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        local ok, matugen = pcall(require, 'matugen')
        if ok then matugen.setup() end
      end,
    },
  },
}