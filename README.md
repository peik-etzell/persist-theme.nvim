# persist-theme.nvim

Do you like to alternate between multiple colorschemes? Don't like going to your neovim config to change it?

- Write your colorscheme to disk on change
- Load your coloscheme from disk on startup

This works with an autocommand on the event `ColorScheme`, which means it works however you change your theme.

- `:colorscheme <colorscheme>`
- `:Telescope colorscheme`

## Configuration

Remove other `:colorscheme <colorscheme>` calls from your config,
this plugin sets your persisted theme on startup.

## lazy.nvim

```lua
    {
        'peik-etzell/persist-theme.nvim',
        config = function()
            require('persist-theme').setup({
                file_path = vim.fn.stdpath('state') .. '/persisted_theme',
                default_colorscheme = nil
            })
        end
    }
```
