return {
  dir = "/home/rob/dev/courier.nvim",
  config = function()
    require("courier").setup({
      remote = {
        search_roots = { "~", "/root", "root/webconsole", "/root/app/src/gstreamer/vivi-gstreamer" },
        confirm_on_save = true,
        scp_opts = "-p",
        verbose = false,
      }
    })
  end
}
