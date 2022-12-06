filetype on             " enable filetype detection
filetype plugin on      " load file-specific plugins
set hlsearch
syntax on

" Display trailing spaces
set listchars=trail:°
set list

" Remove trailing spaces before saving files
autocmd BufWritePre * :%s/\s\+$//e
