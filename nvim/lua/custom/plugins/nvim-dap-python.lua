return {
  'mfussenegger/nvim-dap-python',
  dependencies = {
    'mfussenegger/nvim-dap',
  },
  config = function()
    -- Must install debugpy in a virtual environment
    -- mkdir ~/.virtualenvs/
    -- cd ~/.virtualenvs/
    -- python3 -m venv debugpy
    -- source debugpy/bin/activate to activate it
    local dap_python = require('dap-python').setup '~/.virtualenvs/debugpy/bin/python3'
  end,
}
