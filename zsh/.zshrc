# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:$HOME/.local/bin:/usr/local/bin:$PATH

# Path to your Oh My Zsh installation.
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="powerlevel10k/powerlevel10k"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Customization by vamsi

# Settings
bindkey '^H' backward-kill-word

# -----------SYSTEM---------------
alias uu="sudo apt update; sudo apt upgrade -y"
alias apt="sudo apt"
alias ai="sudo apt install"
alias ar="sudo apt remove"
alias dpkg="sudo dpkg"

eenv() {
  local file="${1:-.env}"

  if [[ ! -f "$file" ]]; then
    echo "❌ No such file: $file" >&2
    return 1
  fi

  while IFS='=' read -r key value; do
    [[ -z "$key" || "$key" =~ ^# ]] && continue

    value="${value%\"}"
    value="${value#\"}"
    value="${value%\'}"
    value="${value#\'}"

    export "$key"="$value"
  done < "$file"

  echo "✅ Loaded environment variables from $file"
}

# eza - The modern ls
alias ls="eza --icons"
alias ls-gi="eza --git-ignore --icons"

# -----------GIT---------------
alias br="git branch"
alias co="git checkout"
alias rb="git rebase"
alias lg="git log --oneline"
alias changes="git diff --name-only | cat"
alias allchaanges="git diff --name-only | cat; git ls-files --others --exclude-standard"
alias pullo="git pull origin"
alias pusho="git push origin"

pushoc () {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD) || return 1
    git push origin "$branch"
}
pulloc () {
    local branch
    branch=$(git rev-parse --abbrev-ref HEAD) || return 1
    git pull origin "$branch"
}


# -----------DOCKER---------------
alias dc="docker compose"
alias dcd="docker compose down"
alias dce="docker compose exec"
alias dcu="docker compose up -d"
alias de="docker exec"
alias dk="docker"

# ------------ZSH-----------------
alias vz="nvim ~/.zshrc"        # editing the config file
alias sz="source ~/.zshrc"      # sourcing the config file

# ------------TMUX----------------
alias ta="tmux attach -t"
alias tn="tmux new -s"

# -------------RG-----------------
alias rgf="rg --files | rg"

# ------------PNPM----------------
alias pn="pnpm"

# ------------CURL----------------
alias get="curl -X GET"
alias post="curl -X POST"
alias put="curl -X PUT"

# ------------APPS----------------
export PATH=$PATH:/home/ubuntu/apps/bin

# alias v="nvim"
alias v="/home/ubuntu/apps/nvim/nvim.appimage"
alias py="python3"
alias fd="fdfind"
alias bat="batcat"

# ------------MISC----------------
alias myip="curl -s https://checkip.amazonaws.com"

# ------------SECRETS-------------
[[ -f ~/.zsh_secrets ]] && source ~/.zsh_secrets

# -------NOTES APP CONFIG---------
nn() { notes new "$@"; }
no() { notes open "$@"; }
ncc() { notes cat "$@"; }
alias ng="notes grep"

_nn() {
    local notes_dir=~/Documents/notes

    [[ -d $notes_dir ]] || return 1

    _files -W "$notes_dir"
}

compdef _nn nn
compdef _nn no

# ------------ AWS ---------------
autoload bashcompinit && bashcompinit
autoload -Uz compinit && compinit
complete -C '/usr/local/bin/aws_completer' aws


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="/home/ubuntu/.local/bin:$PATH"

# direnv
eval "$(direnv hook zsh)"

# uv completions
eval "$(uv generate-shell-completion zsh)"
