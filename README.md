## install

should then be able to go into nvim, navigate to `lua/spencer/packer.lua` and run `:so` and `:PackerSync`

## random helpful info

might need nightly neovim built
https://github.com/neovim/neovim/releases/nightly

need to run the following command in the .config file above nvim folder
```
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```
from:
https://github.com/wbthomason/packer.nvim

## key bindings
`gc` and `gcc` comment out lines
`\ff` opens fuzzy finder and `\fg` opens a grep search
