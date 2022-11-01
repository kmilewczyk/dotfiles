
local profile = {}

profile.gruvbox = {
  config = function () 
    vim.cmd([[
    let g:gruvbox_contrast_dark = 'hard'
    colorscheme gruvbox
    ]])
  end
}

profile.leap = {
  config = function ()
    local leap = require('leap')

    if leap then
      leap.add_default_mappings()
    end
  end
}

profile.telescope = {
  config = function ()
    if not require('telescope') then return end

    vim.keymap.set('n', '<leader>fb', '<cmd>Telescope buffers<cr>')
    vim.keymap.set('n', '<leader>fc', '<cmd>Telescope commands<cr>')
    vim.keymap.set('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
    vim.keymap.set('n', '<leader>fr', '<cmd>Telescope git_files<cr>')
    vim.keymap.set('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')
    vim.keymap.set('n', '<leader>fk', '<cmd>Telescope keymaps<cr>')
    vim.keymap.set('n', '<leader>fh', '<cmd>Telescope command_history<cr>')
    vim.keymap.set('n', '<leader>fl', '<cmd>Telescope current_buffer_fuzzy_find<cr>')
  end
}

profile.whichkey = {
  config = function ()
    local whichkey = require('which-key')

    if whichkey then
      whichkey.setup()
    end
  end
}

profile.neotree = {
  config = function()
    local neotree = require('neo-tree')

    if neotree then
      neotree.setup()
      vim.keymap.set('n', '<leader>1', '<cmd>Neotree<cr>')
    end
  end
}

profile.lspconfig = {
  config = function ()
    local lspconfig = require('lspconfig')
    if not lspconfig then return end

    vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, opts)
    vim.keymap.set('n', ']d', vim.diagnostic.goto_next, opts)
    vim.keymap.set('n', '<leader>de', vim.diagnostic.open_float, opts)
    vim.keymap.set('n', '<leader>dq', vim.diagnostic.setloclist, opts)

    -- Use an on_attach function to only map the following keys
    -- after the language server attaches to the current buffer
    local on_attach = function(client, bufnr)
      -- Enable completion triggered by <c-x><c-o>
      vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

      -- Mappings.
      -- See `:help vim.lsp.*` for documentation on any of the below functions
      local bufopts = { noremap=true, silent=true, buffer=bufnr }
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
      vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
      vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, bufopts)
      vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, bufopts)
      vim.keymap.set('n', '<space>wl', function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end, bufopts)
      vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, bufopts)
      vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, bufopts)
      vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, bufopts)
      vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
      vim.keymap.set('n', '<space>f', function() vim.lsp.buf.format { async = true } end, bufopts)
    end

    local svelte = lspconfig.svelte
    if svelte then
      svelte.setup({ on_attach = on_attach })
    end
  end
}

profile.mason = {
  config = function() 
    local mason = require('mason')

    if mason then
      mason.setup()
    end
  end
}

profile.mason_lspconfig = {
  config = function () 
    local mason_lspconfig = require('mason-lspconfig')
    if not mason_lspconfig then return end

    mason_lspconfig.setup()
  end
}

return profile
