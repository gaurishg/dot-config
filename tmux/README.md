# My TMUX config

## Setup
1. `cd ~/.config`
2. clone the repo
```bash
git clone git@github.com:gaurishg/tmux.git
```
3. Update submodules
```bash
cd tmux
git submodule init
git submodule update
```
4. Install plugins
```bash
tmux
# inside tmux
tmux source ~/.config/tmux/tmux.conf
# Install using C-b + I
```
