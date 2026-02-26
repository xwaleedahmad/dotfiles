### --- Zinit Installer --- ###

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME/.git" ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"


### --- Core Config & History  --- ###

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY       # Write to history file immediately, not at exit
setopt SHARE_HISTORY            # Share history between multiple tabs
setopt HIST_IGNORE_DUPS         # Don't save the same command twice in a row
setopt HIST_IGNORE_SPACE        # Don't save commands starting with space (good for passwords)


### --- Environment & Paths --- ###

# We add paths directly. We DO NOT source scripts (like source cargo/env) 
# because that requires reading files from disk, which is slow.
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$HOME/.cargo/bin:$PATH"
export MICRO_TRUECOLOR=1


### --- Aliases --- ###

alias copilot='zsh_nvm_lazy_load && copilot'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Bun Completions Optimization:
# Instead of sourcing the huge '_bun' file, we just add the folder to 'fpath'.
# Zsh will only read the file if you actually try to autocomplete 'bun'.
[ -d "$BUN_INSTALL" ] && fpath=("$BUN_INSTALL" $fpath)

# Lazy Loading NVM
# NVM normally adds ~0.5s to startup. We create "fake" functions instead.
# The real NVM only loads when you type 'node', 'npm', or 'nvm'.
export NVM_DIR="$HOME/.nvm"
zsh_nvm_lazy_load() {
    # 1. Remove the fake functions
    unset -f node npm npx zsh_nvm_lazy_load
    
    # 2. Load the real NVM script
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    
    # 3. Execute the command you just typed
    "$@"
}

# Map the commands to the lazy loader
node() { zsh_nvm_lazy_load node "$@" }
npm()  { zsh_nvm_lazy_load npm "$@" }
npx()  { zsh_nvm_lazy_load npx "$@" }
nvm()  { zsh_nvm_lazy_load nvm "$@" }


### --- The Prompt (Starship) --- ###

eval "$(starship init zsh)"


### --- Plugins (Turbo Mode / Async) --- ###

# Standard Library & Completions
# 'OMZ::lib/completion.zsh': Makes matching case-insensitive and smarter.
# 'zsh-users/zsh-completions': Adds definitions for thousands of tools.
zinit ice wait'0a' lucid
zinit snippet OMZ::lib/completion.zsh

zinit ice wait'0a' lucid blockf
zinit light zsh-users/zsh-completions

# FZF-Tab (The UI Upgrade)
# Must load after completions. Replaces the default tab menu.
zinit ice wait'0b' lucid
zinit light Aloxaf/fzf-tab

# Autosuggestions
# 'atload': Start the suggestion engine manually since we loaded it async.
zinit ice wait'0c' lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Syntax Highlighting (MUST BE LAST)
# It overlays colors on top of everything else.
# 'zpcompinit': Ensures the completion system is fully ready before coloring.
zinit ice wait'0c' lucid atinit"zpcompinit; zpcdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

# zinit ice depth=1
# zinit light jeffreytse/zsh-vi-mode

### ---Configuration & Styles --- ###

# FZF: Catppuccin Mocha Theme (Applies in the standard fzf tool)
export FZF_DEFAULT_OPTS=" \
--color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#cdd6f4,header:#f38ba8,info:#94e2d5,pointer:#89b4fa,marker:#f5e0dc \
--color=fg+:#cdd6f4,prompt:#89b4fa,hl+:#f38ba8 \
--prompt='❯ ' --marker='✓' --pointer='▶' --layout=reverse --border --info=inline"

# FZF-Tab: Preview Logic
zstyle ':fzf-tab:*' fzf-flags \
  --color=bg+:#313244,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
  --color=fg:#cdd6f4,header:#f38ba8,info:#94e2d5,pointer:#89b4fa,marker:#f5e0dc \
  --color=fg+:#cdd6f4,prompt:#89b4fa,hl+:#f38ba8,border:#89b4fa,separator:#89b4fa

# Image Previews (Chafa) & File Previews (Bat)
# This logic runs only when you press TAB, so it doesn't slow down startup.
zstyle ':fzf-tab:complete:*' fzf-preview \
  'mime=$(file --mime-type -b "$realpath"); \
  if [[ $mime == image/* ]]; then \
    chafa --size="${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}" "$realpath"; \
  elif [[ -d $realpath ]]; then \
    ls --color=always "$realpath"; \
  else \
    bat --style=numbers --color=always --line-range :500 "$realpath" 2>/dev/null; \
  fi'
