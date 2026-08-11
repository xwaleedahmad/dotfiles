### --- Zinit Installer --- ###

ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d "$ZINIT_HOME" ] && mkdir -p "$(dirname "$ZINIT_HOME")"
[ ! -d "$ZINIT_HOME/.git" ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

### --- Core Config & History  --- ###

HISTFILE="$HOME/.zsh_history"
HISTSIZE=10000
SAVEHIST=10000
setopt INC_APPEND_HISTORY # Write to history file immediately, not at exit
setopt SHARE_HISTORY      # Share history between multiple tabs
setopt HIST_IGNORE_DUPS   # Don't save the same command twice in a row
setopt HIST_IGNORE_SPACE  # Don't save commands starting with space (good for passwords)

### --- SSH Key Management --- ###

[[ -f ~/.keychain/$HOST-sh ]] && source ~/.keychain/$HOST-sh >/dev/null

if ! ssh-add -l >/dev/null 2>&1; then
  eval $(keychain --eval --quiet --nogui ~/.ssh/github)
fi

### --- Aliases & Functions --- ###

alias ff='fastfetch'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME' # dotfiles config --local status.showUntrackedFiles no

phonecam() {
  sudo modprobe v4l2loopback exclusive_caps=1 card_label="Android Phone" video_nr=5 &&
    scrcpy --video-source=camera \
      --camera-size=1921x1080 \
      --capture-orientation=0 \
      --camera-id=0 \
      --camera-zoom=1.0 \
      --no-audio \
      --v4l2-sink=/dev/video5
}

### --- Environment & Paths --- ###

export PATH="$HOME/.cargo/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

eval "$(mise activate zsh)"
eval "$(fzf --zsh)"

### --- Plugins (Turbo Mode / Async) --- ###

# Base completion engine for Zsh, Improves tab completion behavior
zinit ice wait'0a' lucid
zinit snippet OMZ::lib/completion.zsh

# Adds definitions for thousands of tools.
zinit ice wait'0a' lucid blockf
zinit light zsh-users/zsh-completions

# Replaces default tab completion UI with fuzzy selection menu
zinit ice wait'0b' lucid
zinit light Aloxaf/fzf-tab

# Suggests commands from history as you type (ghost text style)
zinit ice wait'0c' lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

# Colors commands while typting, Shows errors instantly before execution
zinit ice wait'0c' lucid atinit"zpcompinit; zpcdreplay"
zinit light zdharma-continuum/fast-syntax-highlighting

# Enables Vim-Style keybindings in terminal
zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

function zvm_after_init() {
  source /usr/share/fzf/key-bindings.zsh
}

### ---Configuration & Styles --- ###

# Catppuccin Mocha Theme
color_bg="#313244"
color_text="#cdd6f4"
color_red="#f38ba8"
color_blue="#89b4fa"
color_green="#a6e3a1"
color_lavender="#b4befe"
color_rosewater="#f5e0dc"

export FZF_DEFAULT_OPTS=" \
  --color=bg+:${color_bg},spinner:${color_lavender},hl:${color_lavender} \
  --color=fg:${color_text},header:${color_lavender},info:${color_lavender},pointer:${color_lavender},marker:${color_lavender} \
  --color=fg+:${color_text},prompt:${color_lavender},hl+:${color_lavender} \
  --color=border:${color_lavender} \
  --prompt='❯ ' --marker='✓' --pointer='▶' "

zstyle ':fzf-tab:*' fzf-flags \
  --height=70% \
  --color=bg+:${color_bg},spinner:${color_lavender},hl:${color_lavender} \
  --color=fg:${color_text},header:${color_lavender},info:${color_lavender},pointer:${color_lavender},marker:${color_lavender},border:${color_lavender},separator:${color_lavender}

# Image Previews (Chafa) & File Previews (Bat)
zstyle ':fzf-tab:complete:*' fzf-preview \
  'mime=$(file --mime-type -b "$realpath"); \
  if [[ $mime == image/* ]]; then \
    chafa --size="${FZF_PREVIEW_COLUMNS}x${FZF_PREVIEW_LINES}" "$realpath"; \
  elif [[ -d $realpath ]]; then \
    ls --color=always "$realpath"; \
  else \
    bat --style=numbers --color=always --line-range :500 "$realpath" 2>/dev/null; \
    fi'

### --- Prompt --- ###

eval "$(starship init zsh)"

if [[ -o interactive ]]; then
  clear
  echo
  fastfetch
fi
