# https://github.com/joeljuca/cli

function setup_main() {
  setup_path
  setup_envs
  setup_ohmyzsh

  # executables
  setup_asdf
  setup_direnv
  setup_gcloud_cli

  setup_aliases
}

function setup_path() {
  # Homebrew
  export PATH="/usr/local/sbin:/usr/local/bin:$PATH"
  export PATH="/opt/homebrew/sbin:/opt/homebrew/bin:$PATH"

  # Homebrew-specific
  if which brew >/dev/null 2>&1; then
    # Homebrew OpenSSL
    export PATH="$(brew --prefix openssl@1.1)/bin:$PATH"

    # Homebrew curl
    export PATH="$(brew --prefix curl)/bin:$PATH"

    # Homebrew GnuPG
    #
    # Apparently, with deprecation of GPG 1.x lots of things
    # just broke out of no reason (aka.: I did not know why).
    # After a couple of searches I got a combination of steps
    # to make it work – being one of them to export this env.
    export GPG_TTY="$(tty)"

    # Homebrew Postgres
    export PATH="$(brew --prefix postgresql@15)/bin:$PATH"

    # Homebrew Ruby
    export PATH="$(brew --prefix ruby)/bin:$PATH"

    # Homebrew ssh-copy-id
    export PATH="$(brew --prefix ssh-copy-id)/bin:$PATH"

    # Homebrew SQLite
    export PATH="$(brew --prefix sqlite)/bin:$PATH"
  fi

  # Golang
  export GOPATH="$HOME/.go"
  export PATH="$HOME/.go/bin:$PATH"

  # Python
  if which python3 >/dev/null 2>&1; then
    # pkgs installed with --user
    export PATH="$(python3 -m site --user-base)/bin:$PATH"
  fi
}

function setup_envs() {
  # Disable Homebrew's problematic auto-updates
  export HOMEBREW_NO_AUTO_UPDATE=1

  export HISTCONTROL="ignoreboth"

  # Elixir/Erlang-related. Enable IEx history, and put docs in REPL
  export ERL_AFLAGS="-kernel shell_history enabled"
  export KERL_BUILD_DOCS="yes"
  export KERL_DOC_TARGETS="chunks"

  # Homebrew's OpenSSL
  if which brew >/dev/null 2>&1 && which openssl >/dev/null 2>&1; then
    # OpenSSL-related. TODO: check if the are still necessary
    export LDFLAGS="-L$(brew --prefix openssl@1.1)/lib"
    export CPPFLAGS="-I$(brew --prefix openssl@1.1)/include"
    export KERL_CONFIGURE_OPTIONS="--with-ssl=$(brew --prefix openssl@1.1)"

    export PKG_CONFIG_PATH="$(brew --prefix openssl@1.1)/lib/pkgconfig:$PKG_CONFIG_PATH"
  fi

  # Neovim
  if which nvim >/dev/null 2>&1; then
    export EDITOR="nvim"
  fi
}

function setup_ohmyzsh {
  # These variable names used by Oh My Zsh! are too generic; sounds a mistake.
  # TODO: check periodically if they've deprecated these envs.
  ZSH="$HOME/.oh-my-zsh"

  if [ -d "$ZSH" ]; then
    export ZSH_THEME="terminalparty"
    export ZSH_TMUX_AUTOSTART=true
    export ZSH_TMUX_AUTOCONNECT=true
    export plugins=(git tmux)

    source $ZSH/oh-my-zsh.sh
  fi
}

function setup_aliases() {
  alias :q="exit"
  alias bx="bundle exec"
  alias bottom="btm"
  alias btm="btm -C ~/repos/cli/config/bottom/bottom.toml"
  alias cask="brew cask"
  alias fuck_node_modules="find . -type d -name node_modules -exec rm -fR {} \;"
  alias grepi="grep -i"
  alias gshh="git show HEAD"
  alias gshhn="git show HEAD --name-only"
  alias gshn="git show --name-only"
  alias gzip="gzip -k"
  alias htop="htop -d 3"
  alias http="http --timeout=600"
  alias https="http --default-scheme=https --timeout=600"
  alias m="make"
  alias pls="make"
  alias px="ps aux"
  alias vim="nvim"

  # https://github.com/Peltoche/lsd, https://github.com/lsd-rs/lsd
  # configuration handled through config file (~/.config/lsd/config.yaml)
  if which lsd >/dev/null 2>&1; then
    alias ls="lsd"
  fi

  # use sqlite3 as sqlqite
  if ! which sqlite >/dev/null 2>&1 && which sqlite3 >/dev/null 2>&1; then
    alias sqlite="sqlite3"
  fi
}

function setup_asdf() {
  # asdf is either in $HOME or in under Homebrew's umbrella (macOS-specific)
  if which asdf | grep brew >/dev/null 2>&1 && [ -f "$(brew --prefix)/opt/asdf/libexec/asdf.sh" ]; then
    . "$(brew --prefix)/opt/asdf/libexec/asdf.sh"
  fi

  if which asdf >/dev/null 2>&1 && [ -f "${HOME}/.asdf/asdf.sh" ]; then
    . "${HOME}/.asdf/asdf.sh"
  fi

  # PS: asdf hooks must execute after oh-my-zsh's
}

function setup_direnv() {
  if which direnv >/dev/null 2>&1; then
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

setup_main
