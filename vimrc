set number
syntax on
call plug#begin('~/.vim/plugged')
Plug 'vim-syntastic/syntastic'
Plug 'terryma/vim-multiple-cursors'
Plug 'lambdalisue/vim-findent'
Plug 'tell-k/vim-autoflake'
call plug#end()


set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_fortran_compiler = 'mpif90'
"let g:syntastic_fortran_compiler_options = '-Wall -Wextra -ftrapv -fcheck=all  -Wuninitialized   -llapack -lblas -fopenmp  -I/opt/Develop/GNU/hdf5/include -I hdf5-wrap-intel/include'
let g:syntastic_fortran_compiler_options = ' -g -Wall -Wextra -Wunused -Wconversion -fimplicit-none -fbacktrace -ffree-line-length-0 -fcheck=all -ffpe-trap=zero,overflow,underflow -finit-real=nan   -llapack -lblas -fopenmp  -I/opt/Develop/GNU/hdf5/include -I hdf5-wrap-intel/include'

"let g:syntastic_fortran_compiler_options = ' -checkall   -llapack -lblas -fopenmp  -I/opt/Develop/INTEL/hdf5/include -I hdf5-wrap-intel/include'

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

"@!let g:ale_fortran_gcc_use_free_form = 1
"@!let g:ale_fortran_gcc_executable = 'gfortran'
"@!let g:ale_fortran_gcc_options = '-Wall -Wextra -ftrapv -fcheck=all  -Wuninitialized'

