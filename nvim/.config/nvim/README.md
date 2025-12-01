<div align="center">

# ⚡ My Neovim Configuration

_A blazingly fast, feature-rich Neovim setup built on LazyVim_

[![Neovim](https://img.shields.io/badge/Neovim-0.10+-blueviolet.svg?style=flat-square&logo=Neovim&logoColor=white)](https://neovim.io)
[![Lua](https://img.shields.io/badge/Lua-2C2D72?style=flat-square&logo=lua&logoColor=white)](https://www.lua.org/)
[![LazyVim](https://img.shields.io/badge/LazyVim-Powered-blue?style=flat-square)](https://www.lazyvim.org/)

</div>

---

## ✨ Features

### 🎯 Core Enhancements
- 🤖 **AI-Powered Coding**: GitHub Copilot + CopilotChat + TabNine for intelligent completions
- ⚡ **Blazing Fast**: Optimized with lazy loading and Blink.cmp for instant responses
- 🎨 **Beautiful UI**: Multiple themes (Catppuccin, Tokyo Night, VSCode) with modern aesthetics
- 📁 **Smart Navigation**: Telescope fuzzy finder + Neo-tree + Mini.files for effortless file management
- 🔍 **Advanced Search**: Spectre for project-wide search & replace with live preview

### 🛠️ Development Tools
- 🐛 **Debugging**: Full DAP support with visual breakpoints and watches
- 🔧 **LSP Powerhouse**: Language servers configured for syntax checking, formatting, and refactoring
- 🌲 **Treesitter**: Advanced syntax highlighting and code understanding
- 🔄 **Git Integration**: LazyGit, GitSigns, Diffview, and Octo for complete Git workflow
- 🧪 **Testing & Diagnostics**: Trouble.nvim for beautiful diagnostics management

### 💎 Quality of Life
- 💾 **Auto-save**: Never lose your work again
- 📦 **Session Management**: Restore your workspace exactly as you left it
- 🎯 **Smart Motions**: Flash.nvim for lightning-fast cursor movement
- 🔔 **Beautiful Notifications**: Noice.nvim + nvim-notify for elegant UI messages
- 🧭 **Breadcrumbs**: Code context awareness with nvim-navic integration
- 🎪 **Tmux Integration**: Seamless navigation between Vim and Tmux panes

### 📝 Content Creation
- 📓 **Obsidian Integration**: Full markdown note-taking support
- 📊 **Live Preview**: Real-time markdown and HTML preview
- 📋 **Todo Management**: Track TODOs, FIXMEs, and NOTEs across your codebase

### 🎨 UI/UX
- 🖼️ **Modern Dashboard**: Beautiful startup screen with quick actions
- 📊 **Enhanced Statusline**: Lualine with git info, LSP status, and diagnostics
- 🗂️ **Smart Bufferline**: Tab-like buffer management
- 🎭 **Icon Support**: Full devicons integration for file types
- 🌊 **Smooth Scrolling**: Neo-scroll for buttery smooth navigation
- 🎯 **Context Breadcrumbs**: Always know where you are in the code

---

## 📦 Plugin Highlights

<details>
<summary><b>🤖 AI & Completion (4 plugins)</b></summary>

- **Copilot.vim**: GitHub's AI pair programmer
- **CopilotChat**: Interactive AI conversations in Neovim
- **Blink.cmp**: Ultra-fast completion engine
- **TabNine**: ML-powered code completions

</details>

<details>
<summary><b>🎨 UI & Themes (8 plugins)</b></summary>

- **Dashboard**: Beautiful startup screen
- **Lualine**: Modern statusline
- **Bufferline**: Enhanced buffer/tab management
- **Noice**: Command line, messages, and popups
- **nvim-notify**: Toast-style notifications
- **Catppuccin**: Soothing pastel theme
- **Tokyo Night**: Clean, dark colorscheme
- **VSCode Theme**: Familiar VSCode colors

</details>

<details>
<summary><b>🔍 Navigation & Search (9 plugins)</b></summary>

- **Telescope**: Fuzzy finder over lists
- **Neo-tree**: Modern file explorer
- **Mini.files**: Lightweight file browser
- **Flash**: Quick cursor movement
- **Spectre**: Project-wide search & replace
- **Telescope Frecency**: Smart file finding
- **Telescope UI Select**: Better vim.ui.select
- **Telescope ToggleTerm Manager**: Terminal management
- **Tmux Navigator**: Seamless pane navigation

</details>

<details>
<summary><b>🔧 Development (12 plugins)</b></summary>

- **LSP Config**: Language server configurations
- **Treesitter**: Advanced syntax parsing
- **nvim-dap**: Debug Adapter Protocol
- **Trouble**: Beautiful diagnostics list
- **Gitsigns**: Git decorations and operations
- **LazyGit**: Full-featured git interface
- **Diffview**: Git diff and merge tool
- **Octo**: GitHub issues and PRs in Neovim
- **GitLinker**: Generate shareable git permalinks
- **Mini.surround**: Manipulate surroundings
- **SplitJoin**: Smart code splitting/joining
- **Which-key**: Display keybindings

</details>

<details>
<summary><b>📝 Content & Notes (4 plugins)</b></summary>

- **Obsidian**: Note-taking and knowledge management
- **Live Preview**: Real-time markdown/HTML preview
- **Todo Comments**: Highlight and search TODOs
- **Dataform**: SQL/Dataform support

</details>

<details>
<summary><b>⚡ Performance & QoL (8 plugins)</b></summary>

- **Autosave**: Automatic file saving
- **Session Save**: Workspace persistence
- **Neo-scroll**: Smooth scrolling
- **Mini.indentscope**: Indent guides
- **Luasnip**: Snippet engine
- **Dressing**: Better UI elements
- **Devicons**: File type icons
- **Snacks**: Collection of useful utilities

</details>

---

## 🚀 Installation

```bash
# Backup existing config
mv ~/.config/nvim ~/.config/nvim.bak

# Clone this config
git clone https://github.com/AnveshJarabani/nvim-config.git ~/.config/nvim

# Start Neovim (plugins will auto-install)
nvim
```

---

## ⌨️ Key Features in Action

### 🤖 AI Assistance
- `<Right>` in insert mode → Accept Copilot suggestion
- `:CopilotChat` → Interactive AI conversations

### 🔍 Navigation
- `<leader>ff` → Find files
- `<leader>fg` → Live grep search
- `<leader>fr` → Recent files (with frecency)
- `<leader>e` → Toggle Neo-tree file explorer

### 🔧 Development
- `<leader>gg` → LazyGit interface
- `<leader>xx` → Toggle Trouble diagnostics
- `<leader>cs` → Search & replace (Spectre)
- `<leader>gd` → Git diff view

### 💾 Sessions
- `<leader>qs` → Save session
- `<leader>ql` → Load last session

---

## 🎨 Customization

All configurations are modular and located in:
- `lua/config/` → Core settings, keymaps, autocmds
- `lua/plugins/` → Individual plugin configurations (50+ plugins, 2970+ lines)

---

## 📊 Stats

- **Plugins**: 50+ carefully selected and configured
- **Lines of Config**: ~3000+ lines of Lua
- **Startup Time**: ⚡ ~30-50ms (with lazy loading)
- **Themes**: 3 premium color schemes
- **LSP Support**: 15+ language servers ready to go

---

## 🙏 Credits

Built on the shoulders of giants:
- [LazyVim](https://www.lazyvim.org/) - The foundation
- [lazy.nvim](https://github.com/folke/lazy.nvim) - Plugin manager
- [Neovim](https://neovim.io/) - The best text editor

---

<div align="center">

**⭐ If you like this config, give it a star!**

Made with ❤️ and ☕ by [AnveshJarabani](https://github.com/AnveshJarabani)

</div>
