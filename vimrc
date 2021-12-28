
" ================ vim-plug ================ 
" auto install vim-plug
let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif
unlet data_dir


call plug#begin('~/.vim/plugged')
" functions
Plug 'neoclide/coc.nvim', {'branch': 'release'} 	" lsp
Plug 'preservim/nerdtree' 				            " nerdtree folder viewer
Plug 'Yggdroot/indentLine' 				            " indent line
Plug 'mhinz/vim-startify'                           " cool start up screen
Plug 'psliwka/vim-smoothie'                         " smooth scrolling
Plug 'tpope/vim-fugitive' 				            " git

" UI
Plug 'vim-airline/vim-airline' 				        " statusline
Plug 'ryanoasis/vim-devicons' 				        " icons

" color schemes
Plug 'joshdick/onedark.vim'
Plug 'sainnhe/sonokai'
Plug 'KeitaNakamura/neodark.vim'
Plug 'hzchirs/vim-material'
Plug 'sonph/onehalf', {'rtp': 'vim'}
Plug 'junegunn/seoul256.vim'
call plug#end()



" ================ configs ================ 
" ==> color theme
if (has("nvim"))
  let $NVIM_TUI_ENABLE_TRUE_COLOR=1
endif
if (has("termguicolors"))
  set termguicolors
  if (!empty($TMUX))
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
  endif
endif
syntax on


" Available values: `'default'`, `'atlantis'`, `'andromeda'`, `'shusia'`, `'maia'`, `'espresso'`
" let g:sonokai_style ='default'
" let g:sonokai_enable_italic = 1
" colorscheme sonokai
" let g:airline_theme = 'sonokai'

" let g:onedark_terminal_italics = 1
" let g:airline_theme='onedark'
" colorscheme onedark


"let g:neodark#background = '#202020'
let g:neodark#use_256color = 1
let g:neodark#italics = 1
"let g:neodark#terminal_transparent = 1 " default: 0
colorscheme neodark

"let g:material_style='oceanic'
" colorscheme vim-material

"colorscheme onehalfdark
"let g:airline_theme='onehalfdark'

"let g:seoul256_background = 234 "233 - 239
"colorscheme seoul256    " seoul256-light
"set background=dark

" ==> basic setting
"let mapleader="\<Space>"
let mapleader=';'
set encoding=utf-8
set nocompatible
set history=1000

set backspace=indent,eol,start                          " insert mode backspace behavior
set expandtab smarttab                                  " tab
set tabstop=4 softtabstop=4 shiftwidth=4 autoindent     " indent
set incsearch hlsearch ignorecase smartcase wrapscan    " search
set splitright                                          " vsplit new window in the right side
set wrap breakindent                                    " wrap long lines
set number relativenumber                               " show line number
set scrolloff=3                                         " leave margin lines after the cursor
set noruler noshowcmd wildmenu                             " show some status
set cursorline                                          " cursor line

" ==> coc needs
set hidden
set nobackup
set nowritebackup
set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes "signcolumn=number


" ==> coc.nvim

" list of the extensions to make sure are always installed
let g:coc_global_extensions = [
            \'coc-yank',
            \'coc-pairs',
            \'coc-json',
            \'coc-css',
            \'coc-html',
            \'coc-tsserver',
            \'coc-yaml',
            \'coc-lists',
            \'coc-snippets',
            \'coc-pyright',
            \'coc-clangd',
            \'coc-prettier',
            \'coc-xml',
            \'coc-syntax',
            \'coc-git',
            \'coc-marketplace',
            \'coc-highlight',
            \'coc-sh',
            \]
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.

" use tab to navigate snippet placeholders
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
 
" Use <cr> to accept snippet expansion
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

"To make <cr> select the first completion item and confirm the completion when no item has been selected:
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm() : "\<C-g>u\<CR>"

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
 
" GoTo code navigation.
"nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
set tagfunc=CocTagFunc
nmap <silent> gd <C-]>
nmap <silent> gb <C-t>

 
" Use K to show documentation in preview window.
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')
"autocmd ColorScheme * highlight CocHighlightText     ctermfg=LightMagenta    guifg=LightMagenta
hi CocHighlightText guibg=darkgray guifg=black
hi CocHighlightText ctermfg=darkgray ctermfg=black
"autocmd ColorScheme * hi CocHighlightText ctermbg=235 guibg=#202020


" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)
 
" Formatting selected code.
xmap <leader>f <Plug>(coc-format-selected)
nmap <leader>f <Plug>(coc-format-selected)
 
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a <Plug>(coc-codeaction-selected)
nmap <leader>a <Plug>(coc-codeaction-selected)

" augroup mygroup
"   autocmd!
"   " Setup formatexpr specified filetype(s).
"   autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
"   " Update signature help on jump placeholder.
"   autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
" augroup end

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" " Use CTRL-S for selections ranges.
" " Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)
 
" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

 
" " Add `:Format` command to format current buffer.
" command! -nargs=0 Format :call CocAction('format')
" 
" " Add `:Fold` command to fold current buffer.
" command! -nargs=? Fold :call     CocAction('fold', <f-args>)
" 
" " Add `:OR` command for organize imports of the current buffer.
" command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')
 
" " Add (Neo)Vim's native statusline support.
" " NOTE: Please see `:h coc-status` for integrations with external plugins that
" " provide custom statusline: lightline.vim, vim-airline.
" " set laststatus=2
" " set statusline=%f
" " set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
 
" " Mappings for CoCList
" " Show all diagnostics.
" nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" " Manage extensions.
" nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" " Show commands.
" nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" " Find symbol of current document.
" nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" " Search workspace symbols.
" nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" " Do default action for next item.
" nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" " Do default action for previous item.
" nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" " Resume latest coc list.
" nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>

 
" ==> Plug 'Yggdroot/indentLine'
nnoremap <leader>i :IndentLinesToggle<CR>


" ==> Plug 'psliwka/vim-smoothie'
let g:smoothie_enabled = 0
let g:smoothie_speed_linear_factor = 15
let g:smoothie_speed_constant_factor = 15
let g:smoothie_speed_exponentiation_factor = 0.9


" ==> Plug 'preservim/nerdtree'
nnoremap <leader>t :NERDTreeToggle<CR>
autocmd VimEnter * NERDTree | wincmd p
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif
autocmd BufWinEnter * if getcmdwintype() == '' | silent NERDTreeMirror | endif


" ==> Plug 'ryanoasis/vim-devicons' 				        " icons
" after a re-source, fix syntax matching issues (concealing brackets):
if exists('g:loaded_webdevicons')
  call webdevicons#refresh()
endif


" ==> Plug 'vim-airline/vim-airline'
"let g:airline_left_sep='>'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#show_buffers = 1
let g:airline#extensions#coc#enabled = 1
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#tabline#buffer_idx_mode = 1
let g:airline#extensions#tabline#keymap_ignored_filetypes = ['vimfiler', 'nerdtree']
nmap <leader>1 <Plug>AirlineSelectTab1
nmap <leader>2 <Plug>AirlineSelectTab2
nmap <leader>3 <Plug>AirlineSelectTab3
nmap <leader>4 <Plug>AirlineSelectTab4
nmap <leader>5 <Plug>AirlineSelectTab5
nmap <leader>6 <Plug>AirlineSelectTab6
nmap <leader>7 <Plug>AirlineSelectTab7
nmap <leader>8 <Plug>AirlineSelectTab8
nmap <leader>9 <Plug>AirlineSelectTab9
nmap <leader>0 <Plug>AirlineSelectTab0
nmap <leader>- <Plug>AirlineSelectPrevTab
nmap <leader>+ <Plug>AirlineSelectNextTab
nmap <Tab> <Plug>AirlineSelectNextTab
nmap <S-Tab> <Plug>AirlineSelectPrevTab


" ==> shortcuts
nnoremap <leader>q :bd<CR>
nnoremap <leader>w :w<CR>

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

nnoremap <leader>( i(<Esc>Ea)<Esc>
nnoremap <leader>[ i[<Esc>Ea]<Esc>
nnoremap <leader>{ i{<Esc>Ea}<Esc>

nnoremap <leader>s :term zsh<cr>
