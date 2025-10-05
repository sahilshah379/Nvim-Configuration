# Linux Installation Instructions for Neovim

## 1. Install Neovim

- Follow the **"Pre-built archives"** section from the official guide:  
  [Neovim Installation Guide](https://github.com/neovim/neovim/blob/master/INSTALL.md)

- Add alias to `.bashrc`:
  ```bash
  echo "alias n='nvim'" >> ~/.bashrc
  source ~/.bashrc
  ```

* Verify Neovim installation:

  ```bash
  nvim --version
  ```

---

## 2. Install Dependencies

### ripgrep

```bash
sudo apt-get install ripgrep
```

### fzf

```bash
sudo apt install fzf
```

### zoxide

```bash
curl -sSfL https://raw.githubusercontent.com/ajeetdsouza/zoxide/main/install.sh | sh
```

Add the following to your `~/.bashrc`:

```bash
echo 'export PATH=$PATH:~/.local/bin' >> ~/.bashrc
echo 'eval "$(zoxide init bash)"' >> ~/.bashrc
source ~/.bashrc
```

### bat

```bash
sudo apt install bat
```

Add aliases to your `~/.bashrc`:

```bash
echo "alias bat='batcat --theme=OneHalfDark'" >> ~/.bashrc
echo "alias cat='bat'" >> ~/.bashrc
source ~/.bashrc
```

### Gemini

```bash
npm install -g @google/gemini-cli
```

To login, run:
```bash
gemini
```

---

## 3. Set Up Neovim Configuration

* Clone your Neovim config:

  ```bash
  cd ~/.config
  git clone https://github.com/sahilshah379/Nvim-Configuration.git
  mv Nvim-Configuration/ nvim/
  ```

---

## 4. Install Plugins

* Install `vim-plug`:

  ```bash
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  ```

* Open Neovim and run:

  ```vim
  :PlugInstall
  ```

---

## 5. Install Language Parsers

* Use Tree-sitter to install language parsers:

  ```vim
  :TSInstall <language>
  ```

* Refer to the full list of supported languages here:
  [nvim-treesitter](https://github.com/nvim-treesitter/nvim-treesitter?tab=readme-ov-file#supported-languages)
