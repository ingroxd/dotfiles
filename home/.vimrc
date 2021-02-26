"general {
  " Sets encoding standards
  set encoding=utf-8
  set termencoding=utf-8


  " Sets how many lines of history VIM has to remember
  set history=500

  " Set to auto read when a file is changed from the outside
  set autoread
  au FocusGained,BufEnter * checktime

  " Always show the status line
  set laststatus=2

  " Ignore case when searching
  set ignorecase
"}

"files {
  " Turn backup off, since most stuff is in SVN, git etc. anyway...
  set nobackup
  set nowb
  set noswapfile

  " Turn persistent undo on
  try
    set undodir=~/.vim/.undodir
    set undofile
  catch
  endtry
"}

"ui {
  " Height of the command bar
  set cmdheight=1

  "Always show current position
  set ruler

  " Don't redraw while executing macros (good performance config)
  set lazyredraw

  " Show matching brackets when text indicator is over them
  set showmatch

  " How many tenths of a second to blink when matching brackets
  set mat=2

  " No annoying sound on errors
  set noerrorbells
  set novisualbell
  set t_vb=
  set tm=500

  " Display line number
  set number

  " Display relative line number
  set relativenumber

  " Display breaklines
  set listchars=tab:❘-,trail:·,extends:»,precedes:«,nbsp:×,eol:¬
"}

"font {
  " Enable syntax highlighting
  syntax enable

  set background=dark
"}

"text {
  " Set utf8 as standard encoding and en_US as the standard language
  set encoding=utf8

  " Use Unix as the standard file type
  set ffs=unix,dos,mac

  " For regular expressions turn magic on
  set magic

  " Use spaces instead of tabs
  set expandtab

  " 1 tab = 2 spaces
  set shiftwidth=2
  set tabstop=2

  set ai "Auto indent
  set wrap "Wrap lines

  " Indent code
  set foldmethod=indent
  set foldlevel=10
"}

"shell {
  if exists('$TMUX') 
    if has('nvim')
      set termguicolors
    else
      set term=screen-256color 
    endif
  endif
"}

"python {
  au BufNewFile,BufRead *.py set tabstop=4 softtabstop=4 shiftwidth=4 textwidth=79
"}

"shortcut {
  autocmd BufEnter * set mouse=
  autocmd BufEnter * map <F2> :set number! relativenumber!<cr>
  autocmd BufEnter * map <F3> :set paste!<cr>
  autocmd BufEnter * map <F4> :set spell!<cr>
  autocmd BufEnter * map <F5> :set list!<cr>
  nnoremap <space> za
"}

