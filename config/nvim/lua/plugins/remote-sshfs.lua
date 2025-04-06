return {
  "nosduco/remote-sshfs.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  event = "VimEnter",
  config = function()
    require('remote-sshfs').setup {
      connections = {
        ssh_configs = {
          vim.fn.expand "$HOME" .. "/.ssh/config",
          "/etc/ssh/ssh_config",
        },
        sshfs_args = { 
          "-o reconnect",
          "-o ConnectTimeout=5",
        },
      },
      mounts = {
        base_dir = vim.fn.expand "$HOME" .. "/.sshfs/",
        unmount_on_exit = true,
      },
      handlers = {
        on_connect = {
          change_dir = true,
        },
        on_disconnect = {
          clean_mount_folders = true,
        },
      },
      ui = {
        confirm = {
          connect = false,       -- prompt y/n when host is selected to connect to
          change_dir = false,   -- prompt y/n to change working directory on connection (only applicable if handlers.on_connect.change_dir is enabled)
        },
      },
      log = {
        enable = false,   -- enable logging
        truncate = false, -- truncate logs
        types = {         -- enabled log types
          all = false,
          util = false,
          handler = false,
          sshfs = false,
        },
      },
    }
  end
}
