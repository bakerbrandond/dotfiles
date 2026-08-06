return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    lazy = false,
    version = false, -- Build from source for the newest ACP features
    opts = {
      provider = "cursor",
      mode = "agentic",
      acp_providers = {
        cursor = {
          command = "cursor-agent", 
          args = { "acp" },
          auth_method = "cursor_login",
          env = {
            PATH = os.getenv("PATH"),
            HOME = os.getenv("HOME"),
          },
        },
      },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
  },
}
