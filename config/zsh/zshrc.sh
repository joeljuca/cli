# https://github.com/joeljuca/cli

ZSH=$HOME/.oh-my-zsh
ZSH_THEME="avit"
ZSH_TMUX_AUTOSTART=true
ZSH_TMUX_AUTOCONNECT=true
plugins=(git tmux)

function setup_path() {
  # Homebrew
  export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
  export PATH="/opt/homebrew/sbin:/opt/homebrew/bin:$PATH"

  # Homebrew OpenSSL
  export PATH="$(brew --prefix openssl@1.1)/bin:$PATH"

  # Homebrew curl
  export PATH="$(brew --prefix curl)/bin:$PATH"

  # Homebrew ssh-copy-id
  export PATH="$(brew --prefix ssh-copy-id)/bin:$PATH"

  # Homebrew Golang
  export GOPATH="$HOME/.go/bin"
  export PATH="$HOME/.go/bin:$PATH"
}

function setup_envs() {
  export EDITOR="nvim"
  export HISTCONTROL="ignoreboth"

  # OpenSSL-related. TODO: check if the are still necessary
  export LDFLAGS="-L$(brew --prefix openssl@1.1)/lib"
  export CPPFLAGS="-I$(brew --prefix openssl@1.1)/include"
  export PKG_CONFIG_PATH="$(brew --prefix openssl@1.1)/lib/pkgconfig"

  # Elixir/Erlang-related. Enable IEx history, and put docs in REPL
  export ERL_AFLAGS="-kernel shell_history enabled"
  export KERL_BUILD_DOCS="yes"
  export KERL_CONFIGURE_OPTIONS="--with-ssl=$(brew --prefix openssl@1.1)"
  export KERL_DOC_TARGETS="chunks"
}

function setup_aliases() {
  alias :q="exit"
  alias cask="brew cask"
  alias fuck_node_modules="find . -type d -name node_modules -exec rm -fR {} \;"
  alias grepi="grep -i"
  alias gshh="git show HEAD"
  alias gzip="gzip -k"
  alias htop="htop -d 3"
  alias http="http --timeout=600"
  alias https="http --default-scheme=https --timeout=600"
  alias px="ps aux"
  alias vim="nvim"

  # https://github.com/Peltoche/lsd
  # configuration handled through config file (~/.config/lsd/config.yaml)
  if which lsd >/dev/null 2>&1; then
    alias ls="lsd"
  fi
}

function setup_zsh_autocomplete {
  local zsh_autocomplete_dir="${HOME}/repos/zsh-autocomplete"
  local skip_global_compinit=1

  if [ -d "${zsh_autocomplete_dir}" ]; then
    source "${zsh_autocomplete_dir}/zsh-autocomplete.plugin.zsh"
  fi
}

function setup_asdf() {
  # asdf is either in $HOME or in under Homebrew's umbrella (macOS-specific)
  if [ -f "$(brew --prefix)/opt/asdf/libexec/asdf.sh" ]; then
    . "$(brew --prefix)/opt/asdf/libexec/asdf.sh"
  fi

  if [ -f "${HOME}/.asdf/asdf.sh" ]; then
    . "${HOME}/.asdf/asdf.sh"
  fi

  # PS: asdf hooks must execute after oh-my-zsh's
}

function setup_direnv() {
  if which direnv 2>&1 >/dev/null; then
    eval "$(direnv hook zsh)"
  fi
}

function setup_gcloud_cli() {
  # macOS-specific
  if which gcloud >/dev/null 2>&1; then
    local gcloud_cask_path="$(brew --prefix)/Caskroom/google-cloud-sdk"

    for filename in path completion; do
      if [ -x "${gcloud_cask_path}/latest/google-cloud-sdk/${filename}.zsh.inc" ]; then
        source "${gcloud_cask_path}/latest/google-cloud-sdk/${filename}.zsh.inc"
      fi
    done
  fi
}

setup_path
setup_envs

source $ZSH/oh-my-zsh.sh

# executables
setup_asdf
setup_direnv
setup_gcloud_cli

setup_aliases
setup_zsh_autocomplete
