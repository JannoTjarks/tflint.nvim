# tflint.nvim
[![GitHub release](https://img.shields.io/github/v/release/JannoTjarks/tflint.nvim)](https://github.com/JannoTjarks/tflint.nvim/releases/latest)
![License: MPL 2.0](https://img.shields.io/badge/License-MPL%202.0-blue.svg)

`tflint.nvim` is a plugin for integrating [tflint](https://github.com/terraform-linters/tflint) into [neovim](https://neovim.io/).

The original idea came from a very personal need.
I like `tflint` a lot. It is part of my `neovim` language server setup and I even contributed code to the Microsoft Azure plugin ([tflint-ruleset-azurerm](https://github.com/terraform-linters/tflint-ruleset-azurerm)) myself.

In my company we have a lot of repositories with Terraform code and the implementation of a tool to automate dependencies for automating dependencies like [renovate](https://github.com/renovatebot/renovate) was missing in our IaC department. This leads to a lot of different versions of `tflint` plugins used in different repositories.  

So the first idea was to automate the installation of the plugins...
Because that was something I always forgot to do ;)

## Feature

[x] Automated installation of all plugins specified in the `.tflint.hcl`

## Installation

### lazy.nvim
You can use the following snippet to install `tflint.nvim`, if you
installed `tflint` with [mason.nvim](https://github.com/williamboman/mason.nvim).
(Or at least if `tflint` is stored in the `mason.nvim` default path `~/.local/share/nvim/mason/bin/tflint`)
``` lua
{
    "JannoTjarks/tflint.nvim",
    version = "*"
    dependencies = {
        "neovim/nvim-lspconfig"
    },
    lazy = true,
    ft = "terraform",
}
```

Or use this snippet, if you have the `tflint` binary on a different path.
``` lua
{
    "JannoTjarks/tflint.nvim",
    version = "*"
    dependencies = {
        "neovim/nvim-lspconfig"
    },
    lazy = true,
    ft = "terraform",
    config = function()
        require("tflint").setup({ tflint_path = "/path/to/tflint" })
    end
}
```

