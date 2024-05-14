return {
  "catppuccin/nvim", 
  name = "catppuccin", 
  priority = 1000,
  config = function ()
    local options = {
      flavour = "mocha",
      no_bold = true,
      transparent_background = true
    }
    require("catppuccin").setup(options)
    vim.cmd("colorscheme catppuccin")
  end
}
