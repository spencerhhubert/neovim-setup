return {
  "nvim-tree/nvim-web-devicons",
  lazy = false,
  config = function()
    require("nvim-web-devicons").setup({
      strict = true,
      override_by_filename = {
        [".gitignore"] = {
          icon = "",
          color = "#f1502f",
          name = "Gitignore"
        }
      },
      override_by_extension = {
        ["txt"] = {
          icon = "",
          color = "#89e051",
          name = "Text",
        },
      },
    })
  end,
}
