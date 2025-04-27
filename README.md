## lsps
```
pip install pyright
#I'm too lazy to make these not apt commands, you get the idea
sudo apt install nodejs npm
sudo npm install -g typescript typescript-language-server
npm install -g svelte-language-server
```

## markdown preview
call with `:MarkdownPreview`
```
brew install pandoc
npm install -g @compodoc/live-server
```

## tmux config
```
# Undercurl
set -g default-terminal "${TERM}"
set -as terminal-overrides ',*:Smulx=\E[4::%p1%dm'  # undercurl support
set -as terminal-overrides ',*:Setulc=\E[58::2::%p1%{65536}%/%d::%p1%{256}%/%{255}%&%d::%p1%{255}%&%d%;m'  # underscore colours - needs tmux-3.0

set -g @plugin 'tmux-plugins/tmux-yank'

set-option -g default-command "reattach-to-user-namespace -l $SHELL"

set -s set-clipboard on
```
```
brew install reattach-to-user-namespace
```

## global copy paste
This will only work inside Tmux because it 1) unifies the copy paste registers w/ Tmux and 2) relies on tmux to copy to the system clipboard

In iTerm2, go to Preferences > General > Selection and check "Applications in terminal may access clipboard"

##
```
brew install ripgrep
```

brew install --cask font-jetbrains-mono-nerd-font

# font fallback
fixes broken markdown rendering
```
brew install --cask font-jetbrains-mono-nerd-font
```
