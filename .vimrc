" set UTF-8 encoding
set enc=utf-8
set fenc=utf-8
set termencoding=utf-8
" disable vi compatibility (emulation of old bugs)
set nocompatible
" use indentation of previous line
set autoindent
" use intelligent indentation for C
set smartindent
" configure tabwidth and insert spaces instead of tabs
set tabstop=2        " tab width is 2 spaces
set shiftwidth=2     " indent also with 2 spaces
set expandtab        " expand tabs to spaces

set textwidth=80
" turn syntax highlighting on
set t_Co=256
syntax on
" colorscheme wombat256
" turn line numbers on
set number
" highlight matching braces
set showmatch
" intelligent comments
set comments=sl:/*,mb:\ *,elx:\ */
" for netrw
set nocp
filetype plugin on

" highlight trailing whitespaces
highlight ExtraWhitespace ctermbg=red guibg=red
autocmd ColorScheme * highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" o to create new line without going into edit mode
noremap o o<Esc>
noremap O O<Esc>
noremap <Tab> >>
noremap <S-Tab> <<

" set line width marker
set colorcolumn=80,100

au BufNewFile, BufRead *.py
    \ set tabstop=4 |
    \ set softtabstop=4 |
    \ set shiftwidth=4 |
    \ set textwidth=79 |
    \ set expandtab |
    \ set autoindent |
    \ set fileformat=unix

" git clone https://github.com/mindriot101/vim-yapf.git in vim pack folder and install https://pypi.org/project/yapf/
let g:yapf_style = "\"{ column_limit: 100 }\""
autocmd BufWritePre *.py Yapf

" git clone https://github.com/natebosch/vim-lsc.git and https://github.com/dart-lang/dart-vim-plugin.git
let g:lsc_server_commands = {'dart': 'dart_language_server'}
let g:lsc_auto_map = v:true

autocmd BufWritePost *.dart silent execute "!dart format %" | e % | redraw!

function Grep(exp, includes="*.*")
    execute "tabnew | r ! grep -rn -C1 --include=" . a:includes . " -E " . a:exp
endfunction

command -nargs=+ Pygrep call Grep(<args>, "*.{py}")
command -nargs=+ Cppgrep call Grep(<args>, "*.{h,cpp}")

function! ReplaceAll(exp, replace, includes="*.*")
    execute "!grep -rl --include=" . a:includes . " -E " . a:exp . " | xargs -I{} sed -i s/" . a:exp . "/" . a:replace . "/g {}"
endfunction

command -nargs=* ReplaceAll call ReplaceAll(<f-args>)
