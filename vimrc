execute pathogen#infect()
filetype plugin indent on

"set cursorline  " will make screen redrawing slower
set nocompatible
set nu! 
set shiftwidth=4
set softtabstop=4
set tabstop=4
set expandtab
syntax enable
set fdm=indent
set autoindent
set hls 
"set nowrap
set wrap
set sidescroll=1
set listchars+=precedes:<,extends:>
" 如果不设置这个，则默认为set bs=""，为compatible模式
set backspace=indent,eol,start

let Tlist_Ctags_Cmd="/usr/bin/ctags"
let Tlist_Exit_OnlyWindow=1
let Tlist_Show_One_File=1

augroup hello_yourself
    autocmd!
    autocmd Filetype python call InitForPython()
    autocmd Filetype ruby call InitForRuby()
    autocmd Filetype mkd call InitForMkd()
    autocmd BufReadPost *
        \ if line("'\"") > 0 && line("'\"") <= line("$") |
        \ exe "normal! g`\"" |
        \ endif
augroup END

command Time call ShowTimeCxyokk()

" ====================================
" = 函数定义区开始
" ====================================

" 当打开.py文件时执行这个函数
function! InitForPython()
    setlocal expandtab ts=4 sts=4 sw=4
endfunction

function! InitForRuby()
    setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
endfunction

function! InitForMkd()
    setlocal cursorline
    normal! zR
endfunction

function! ShowTimeCxyokk()
    echo "^_^     " strftime("%Y-%m-%d %T") "      seize the moment, cxyokk"
endfunction

function! AddTracker()
    let cmd = printf('setlocal expandtab ts=%d sts=%d sw=%d', w, w, w)
    execute cmd
    if &filetype == 'php' || &filetype == 'javascript'
        let tracker = printf('/* vim: %s : */',  cmd)
    else
        let tracker = printf('# vim: %s :',  cmd)
    endif
    execute "normal! Go\<esc>0Di".tracker
endfunction

" ====================================
" = 函数定义区结束
" ====================================

" 'muscle memory'
let mapleader = '-'
let maplocalleader = '-'
nnoremap <leader>- ddp
nnoremap <leader>_ ddkP
nnoremap <leader>f :f<cr>

nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
nnoremap <leader>s. :source %<cr>

nnoremap <leader>o o<esc>k
nnoremap <leader>oo O<esc>j

cnoremap ;; <c-e><c-u><esc>
"cnoremap <esc> <nop> " interrupt arrow keys
vnoremap ;; <esc>
vnoremap <esc> <nop>

nnoremap vv V

inoremap jk <esc>
inoremap <esc> <nop>

nnoremap ;; :
nnoremap <leader>q :q<cr>
nnoremap <leader>w :w<cr>
nnoremap <leader>wq :wq<cr>

nnoremap <leader>' viw<esc>a'<esc>bi'<esc>el
nnoremap <leader>" viw<esc>a"<esc>bi"<esc>el
vnoremap <leader>' <esc>`<i'<esc>`>la'<esc>`<lv`>l
vnoremap <leader>" <esc>`<i"<esc>`>la"<esc>`<lv`>l

nnoremap <leader>nh :nohlsearch<cr>



" execute texts as vim script:
" - normal mode: current line
" - visual mode: selection
nnoremap <leader>e V:<c-u>call ExecuteVimScript()<cr>
vnoremap <leader>e  :<c-u>call ExecuteVimScript()<cr>
function! ExecuteVimScript()
    let old_reg = @@
    normal! `<v`>y
    exec @@
    let @@ = old_reg
endfunction



" open vim help:
" - normal mode: <cword>
" - visual mode: selection
nnoremap <leader>h viw:<c-u>call OpenVimHelp()<cr>
vnoremap <leader>h    :<c-u>call OpenVimHelp()<cr>
function! OpenVimHelp()
    let old_reg = @@
    normal! `<v`>y
    help @@
    let @@ = old_reg
endfunction
