# .config store

## Steps to reproduce the configuration
1. Install Python and Node (needed for vim)
```bash
sudo apt install python3-pip python3-venv
```

```bash
# installs NVM (Node Version Manager)
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash

# download and install Node.js
nvm install 22

# verifies the right Node.js version is in the environment
node -v # should print `v20.12.2`

# verifies the right NPM version is in the environment
npm -v # should print `10.5.0`
```

2. Install fzf and ripgrep
```bash
sudo apt install fzf ripgrep
```


3. Clone the repo
```bash
cd ~/.config
git clone git@github.com:gaurishg/dot-config.git .
```

4. Initialize submodules
```bash
git submodule init
git submodule update
```
