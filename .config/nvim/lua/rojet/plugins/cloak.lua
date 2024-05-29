return {
  'laytan/cloak.nvim',
  opts = {
    enabled = true,
    cloak_character = '*',
    highlight_group = 'Comment',
    cloak_length = 20, -- Provide a number if you want to hide the true length of the value.
    try_all_patterns = true,
    cloak_telescope = true,
    patterns = {
      {
        file_pattern = { '.env*', '*.env*' },
        cloak_pattern = '=.+',
        replace = nil,
      },
    },
  },
}
