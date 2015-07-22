set nocompatible
set termencoding=latin1

" General {
    set nu
    "set mouse=a
    "filetype plugin indent on       " Automatically detect file types.
    "syntax on                       " syntax highlighting
    set hlsearch                    " highlight search pattern
    set wildmenu                    " show list instead of just completing
    set wildmode=list:longest,full  " command <Tab> completion, list matches, then longest common part, then all.
    set history=1000                " Store a ton of history (default is 20)
    "set spell                       " spell checking on
    set scrolljump=1                " lines to scroll when cursor leaves screen
    set scrolloff=10                " minimum lines to keep above and below cursor
    "set foldenable                  " auto fold code
    set wrap linebreak textwidth=0  
"}

" Key mappings {
    "let mapleader = ','
    nnoremap ; :
    command W w
    command WQ wq
    command Wq wq

     " Yank from the cursor to the end of the line, to be consistent with C and D.
    nnoremap Y y$
    " copy and past {
        map <F2> viwx
        map <F3> viwy
        map <F4> viwp
        map <F5> viwpviwy
    " }

     " Code folding options {
        nmap <leader>f0 :set foldlevel=0<CR>
        nmap <leader>f1 :set foldlevel=1<CR>
        nmap <leader>f2 :set foldlevel=2<CR>
        nmap <leader>f3 :set foldlevel=3<CR>
        nmap <leader>f4 :set foldlevel=4<CR>
        nmap <leader>f5 :set foldlevel=5<CR>
        nmap <leader>f6 :set foldlevel=6<CR>
        nmap <leader>f7 :set foldlevel=7<CR>
        nmap <leader>f8 :set foldlevel=8<CR>
        nmap <leader>f9 :set foldlevel=9<CR>
    "}

    "clearing highlighted search
    nmap <silent> <leader>/ :nohlsearch<CR>

    "del end of line
    map <F12> nD

    "Shortcut to macro qq
    map <F9> @q

    "shift up and down
    nmap <S-j> mz:m+<cr>`z
    nmap <S-k> mz:m-2<cr>`z
    
    " Miskey correction {
        map taeb tabe
    " }

    " Convert hex {
        map <F7> :%!xxd<CR>
        map <F8> :%!xxd -r<CR>
    " }
" }
"
" Some Functions {
    :command Insprocess r /home/jchauvet/work/templates/process.vhd
    :command Insvhd r /home/jchauvet/work/templates/vhdl_src.vhd
    :command Insvhdavlmm r /home/jchauvet/work/templates/vhdl_src_avlmm.vhd
" }

" Formatting {
    set autoindent                  " indent at the same level of the previous line
    set shiftwidth=4                " use indents of 4 spaces
    set expandtab                   " tabs are spaces, not tabs
    set tabstop=4                   " an indentation every four columns
    set softtabstop=4               " let backspace delete indent
    set pastetoggle=<F11>           " pastetoggle (sane indentation on pastes)
    set foldcolumn=3                " set 3 colomns for folding
    "autocmd FileType * set tabstop=4|set shiftwidth=4|set noexpandtab
    "autocmd FileType c set tabstop=2|set shiftwidth=2|set expandtab
    "autocmd FileType cpp set tabstop=2|set shiftwidth=2|set expandtab
" }

" Ctags {
	" This will look in the current directory for 'tags', and work up the tree towards root until one is found. 
	"set tags=./tags;/,$HOME/vimtags
    map <C-\> :tab split<CR>:exec("tag ".expand("<cword>"))<CR> " C-\ - Open the definition in a new tab
    map <A-]> :vsp <CR>:exec("tag ".expand("<cword>"))<CR>      " A-] - Open the definition in a vertical split
" }

" Tests {
    "function! Myfunc()
    "  :normal i
    "  echo "Hello!"
    "endfunction
    "
    "
    "function! Myfunc1()
    "    
    "    return "salut" 
    "endfunction
    " }

