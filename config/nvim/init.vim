"
" vim-plug. https://github.com/junegunn/vim-plug
"

call plug#begin('~/.config/nvim/plugged')

Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'elixir-editors/vim-elixir'
Plug 'dense-analysis/ale'
Plug 'hylang/vim-hy'
Plug 'janet-lang/janet.vim'
Plug 'olical/conjure'
Plug 'preservim/nerdtree'
Plug 'vim-airline/vim-airline'
Plug 'vim-erlang/vim-erlang-runtime'
Plug 'vim-syntastic/syntastic'

call plug#end()

"
" Configuration
"

set number " show line numbers
set cursorline " draw a hr line on cursor
set paste " allows Cmd-V inside Vim/Neovim/MacVim

"
" MacVim-specific configuration
"

if has("gui_macvim")
  set guifont=Hack\ Nerd\ Font:h12
endif
