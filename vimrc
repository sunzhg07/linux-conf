set nocompatible
filetype plugin indent on
set number
syntax on

""" Searching and Patterns
set ignorecase              " Default to using case insensitive searches,
set smartcase               " unless uppercase letters are used in the regex.
set smarttab                " Handle tabs more intelligently
set hlsearch                " Highlight searches by default.
set incsearch               " Incrementally search while typing a /regex

set ls=2                    " allways show status line
set vb t_vb=                " Disable all bells.  I hate ringing/flashing.
set confirm                 " Y-N-C prompt if closing with unsaved changes.
set showcmd                 " Show incomplete normal mode commands as I type.
set report=0                " : commands always print changed line count.
set shortmess+=a            " Use [+]/[RO]/[w] for modified/readonly/written.
set ruler                   " Show some info, even without statuslines.
set laststatus=2            " Always show statusline, even if only 1 window.

filetype on                   " try to detect filetypes
filetype plugin indent on     " enable loading indent file for filetype
set number                    " Display line numbers
set numberwidth=1             " using only 1 column (and 1 space) while possible
set background=dark           " We are using dark background in vim
set title                     " show title in console title bar
set wildmenu                  " Menu completion in command mode on <Tab>
set wildmode=full             " <Tab> cycles between all matching choices.
set cursorline              " have a line indicate the cursor location
set ruler                   " show the cursor position all the time
set nostartofline           " Avoid moving cursor to BOL when jumping around
set virtualedit=block       " Let cursor move past the last char in <C-v> mode
set scrolloff=3             " Keep 3 context lines above and below the cursor
set backspace=2             " Allow backspacing over autoindent, EOL, and BOL
set showmatch               " Briefly jump to a paren once it's balanced
set nowrap                  " don't wrap text
set linebreak               " don't wrap textin the middle of a word
set autoindent              " always set autoindenting on
set smartindent             " use smart indent if there is no indent file
set tabstop=4               " <tab> inserts 4 spaces
set shiftwidth=4            " but an indent level is 2 spaces wide.
set softtabstop=4           " <BS> over an autoindent deletes both spaces.
set expandtab               " Use spaces, not tabs, for autoindent/tab key.
set shiftround              " rounds indent to a multiple of shiftwidth
set matchpairs+=<:>         " show matching <> (html mainly) as well
set foldmethod=indent       " allow us to fold on indents
set foldlevel=99            " don't fold by default



let fortran_free_source=1
let fortran_have_tabs=1
let fortran_more_precise=1
let fortran_do_enddo=1


call plug#begin('~/.vim/plugged')
Plug 'dense-analysis/ale'
Plug 'terryma/vim-multiple-cursors'
Plug 'preservim/nerdtree'
call plug#end()



let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'


function! LinterStatus() abort
        let l:counts = ale#statusline#Count(bufnr(''))

        let l:all_errors = l:counts.error + l:counts.style_error
        let l:all_non_errors = l:counts.total - l:all_errors

        return l:counts.total == 0 ? 'OK' : printf(
                                \   '%dW %dE',
                                \   all_non_errors,
                                \   all_errors
                                \)
endfunction

set statusline+=%=
set statusline+=\ %{LinterStatus()}

nmap <silent> <C-e> <Plug>(ale_next_wrap)
let g:ale_lint_on_enter = 0


let g:ale_linters_explicit = 1  " 只显示运行ale_linters的文件
let g:ale_completion_delay = 500
let g:ale_echo_delay = 20
let g:ale_lint_delay = 500
let g:ale_echo_msg_format = '[%linter%] %code: %%s'
let g:ale_lint_on_text_changed = 'normal'  " 防止YCM不停补全
let g:ale_lint_on_insert_leave = 1

let g:ale_linters = {
                        \   'c++': ['g++'],
                        \   'c': ['gcc'],
                        \   'fortran' : ['gfortran'],
                        \   'python': ['pylint'],
                        \}

let g:ale_fortran_gcc_use_free_form = 1
let g:ale_fortran_gcc_executable = 'gfortran'
let g:ale_fortran_gcc_options = '-Og -g -fbounds-check  -Wall -Wextra -ftrapv -fcheck=all  -Wuninitialized -I/home/wolf/work/smcc_opt/cc'
let g:ale_fortran_language_server_executable = 'fortls --lowercase_intrinsics --max_line_length=80'
" ALE
let b:ale_linters = ['prospector', 'pyflakes', 'flake8', 'pylint', 'proselint', 'textlint', 'clang', 'clangcheck', 'clangtidy', 'clazy', 'cppcheck', 'cpplint', 'gcc' ]
let b:ale_fixers = ['yapf', 'isort', 'prettier', 'clang-format', 'uncrustify' ]

let g:ale_set_loclist = 1
let g:ale_set_quickfix = 0
let g:ale_open_list = 1
" default is 10
let g:ale_list_window_size = 5

" Start NERDTree. If a file is specified, move the cursor to its window.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * NERDTree | if argc() > 0 || exists("s:std_in") | wincmd p | endif
