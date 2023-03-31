"
" vim-plug. https://github.com/junegunn/vim-plug
"

call plug#begin('~/.config/nvim/plugged')

Plug 'vim-airline/vim-airline'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'preservim/nerdtree'
Plug 'vim-syntastic/syntastic'
Plug 'editorconfig/editorconfig-vim'
" Plug 'Olical/conjure'

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
  set guifont=Hack\ Nerd\ Font:h16
endif
