return {
  dir = "/home/rob/dev/courier.nvim",
  config = function()
    require("courier").setup({
      remote = {
        search_roots = { "~", "/root", "/root/app" }, -- where the project lives on the remote:
        confirm_on_save = true,
        scp_opts = "-p",
        verbose = true,
      }
    })
  end
}
