"--------------------------------------
" General
"--------------------------------------
set nocompatible	" get out of horrible vi-compatible mode; must be first, as it changes other options
set undolevels=1000
set history=2000
"if exists(":filetype")
"	filetype plugin indent on "detect the type of file
"	runtime ftplugin/man.vim " to have :Man available
"endif
set cindent
set viminfo+=!		" make sure it can save viminfo
set isk+=_,$,@,%,#,-	" none of these should be word dividers, so make them not be
set ts=4

"-------------------------------------
" Vim UI
"-------------------------------------
set background=dark
syntax on
if exists(":colorscheme")
    colorscheme desert
endif

set ttyfast 
" set mouse=a		" make sure mouse is used in all cases.
" set nomousehide		" hide the mouse pointer when characters are typed
set lsp=0		" space it out just like unix
set fillchars=vert:\ ,stl:\ ,stlnc:\
set wildmenu		" turn on wild menu
set number		" turn on line numbers
set ruler		" Always show current positions along the bottom
set lz			" do not redraw while running macros (much faster) (LazyRedraw)
"set ignorecase		" easier to ignore case for searching
set report=0		" tell us when anything is changed via :...

" setting for the GTK2 GUI
if has("gui_running")
	set columns=105 lines=33
	colorscheme desert
"	set guioptions-=tT
"	set guifont=Bitstream\ Vera\ Sans\ Mono\ 10
endif


"-------------------------------------
" Vim locale
"-------------------------------------
" set enc=big5
" set fileencoding=big5
set hls                
set sw=2
set background=dark
set fileencoding=utf-8
set encoding=utf-8

set langmenu=none
syntax on
highlight Comment ctermfg=darkcyan
highlight Search term=reverse ctermbg=4 ctermfg=7


"-------------------------------------
" Visual Cues
"-------------------------------------
set mat=5		" how many tenths of a second to blink matching brackets for
set backspace=2		" indent,eol,start
set showmatch		" show matching brackets
set showcmd		" Show (partial) command in status line 
set incsearch		" do incremental searching
set hlsearch		" highlight searched for phrases
set splitbelow		" splitting a windows will put the window below the current one 
set scrolloff=10	" Keep 10 lines (top/bottom) for scope
set novisualbell	" don't blink
set noerrorbells	" no noises
set laststatus=2	" always show the status line
" set statusline=[%n][File:%f]%m%=[Row:%l][Col:%c][%p%%]
" set statusline=%<[%n]\ %F\ \ Filetype=\%y\ \ %r\ %1*%m%*%w%=%(Line:\ %l%)%4(%)Column:\ %5(%c%V/%{strlen(getline(line('.')))}%)\ %4(%)%p%%
set statusline=[%n]\ %<%f\ %((%1*%M%*%R%Y)%)\ %=%-19(\LINE\ [%3l/%3L]\ COL\ [%02c%03V]%)\ ascii['%02b']\ %P


"------------------------------------
" Text Formatting/Layout
"------------------------------------
set autoindent
set smartindent
set shiftwidth=2
" set softtabstop=4
set tabstop=2		"tab = 2 space
set textwidth=0		" maximum width of text that is being inserted
set linebreak		" wrap long lines at a character in 'breakat'
" set noexpandtab		" use real tabs
set expandtab 		
set nojoinspaces	" insert two spaces after a '.', '?' and '!' with a join command
" set smarttab		" use tabs at the start of a line, spaces elsewhere


"-------------------------------------
" Folding
"-------------------------------------
set foldenable		" Turn on folding
set foldmethod=indent	" Make folding indent sensitive
set foldlevel=100	" Don't autofold anything (but I can still fold manually)
"set foldopen-=search	" don't open folds when you search into them
set foldopen-=undo	" don't open folds when you undo stuff

"-------------------------------------
" Mappings
"-------------------------------------
" Optimized timestamp; useful for ChangeLogs.
map <F2> i<C-R>=strftime("%Y-%m-%d %H:%M")<CR> Leonard Schmidt<CR><TAB>* <CR><CR><ESC>--A
map Q gq		" Don't use Ex mode, use Q for formatting

"-------------------------------------
" Minibuf
"-------------------------------------
let g:miniBufExplTabWrap = 1 " make tabs show complete (no broken on two lines)
let g:miniBufExplModSelTarget = 1

"-------------------------------------
" Matchit
"-------------------------------------
let b:match_ignorecase = 1

"-------------------------------------
" Perl
"-------------------------------------
let perl_extended_vars=1    " highlight advanced perl vars inside strings
let perl_want_scope_in_variables=1
let perl_include_pod=1
let perl_fold=1
let perl_fold_blocks=1

"-------------------------------------
" C
"-------------------------------------
let c_comment_strings = 1   " hilights strings inside comments
let c_gnu = 1		    " set syntax for gnu gcc/g++
let c_space_errors = 1	    " show spacing errors

"-------------------------------------
" sh
"-------------------------------------
let highlight_function_name = 1

"-------------------------------------
" settings for :TOhtml
"-------------------------------------
let g:html_use_css = 1
let g:html_use_xhtml = 1
let g:html_number_lines = 1


colorscheme torte

" set cursorcolumn
" set cursorline

" highlight cursorcolumn cterm=bold ctermfg=white ctermbg=cyan
" highlight cursorline cterm=bold ctermfg=white ctermbg=blue

"set nu
" set mouse=n

let g:snip_set_textmate_cp=1

augroup filetype
  au! BufRead,BufNewFile *.jcs		set filetype=c
  au! BufRead,BufNewFile *.ll		set filetype=llvm
  au! BufRead,BufNewFile *.llx		set filetype=llvm
  au! BufRead,BufNewFile *.td		set filetype=tablegen
  au! BufRead,BufNewFile *Makefile*	set filetype=make
  au! BufRead,BufNewFile *.cl set filetype=c
augroup END

"set paste
set pastetoggle=<F1>
set vb t_vb=
set ai

inoremap ( ()<LEFT>
inoremap [ []<LEFT>
inoremap { {}<LEFT>

function! RemovePairs()
  let l:line = getline(".")
  let l:previous_char = l:line[col(".")-1] 

  if index(["(", "[", "{"], l:previous_char) != -1
    let l:original_pos = getpos(".")
    execute "normal %"
    let l:new_pos = getpos(".")

    if l:original_pos == l:new_pos
      execute "normal! a\<BS>"
      return
    end

    let l:line2 = getline(".")
    if len(l:line2) == col(".")
      execute "normal! v%xa"
    else
      execute "normal! v%xi"
    end

  else
    execute "normal! a\<BS>"
  end
endfunction
inoremap <BS> <ESC>:call RemovePairs()<CR>a

function! RemoveNextDoubleChar(char)
  let l:line = getline(".")
  let l:next_char = l:line[col(".")] 

  if a:char == l:next_char
    execute "normal! l"
  else
    execute "normal! i" . a:char . ""
  end
endfunction
inoremap ) <ESC>:call RemoveNextDoubleChar(')')<CR>a
inoremap ] <ESC>:call RemoveNextDoubleChar(']')<CR>a
inoremap } <ESC>:call RemoveNextDoubleChar('}')<CR>a

map <c-a> :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q .<CR>

"for OmniCppComplete
set nocp
filetype plugin on

let g:SuperTabDefaultCompletionType="context"
let g:completekey="<C-d>"

":set list listchars=tab:»·,trail:·
map <f6> :Tlist<CR>
