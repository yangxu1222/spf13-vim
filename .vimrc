" Modeline and Notes {
"
" vim: set sw=4 ts=4 sts=4 et tw=78 foldmarker={,} foldlevel=0 foldmethod=manual spell:
"                    __ _ _____              _
"         ___ _ __  / _/ |___ /      __   __(_)_ __ ___
"        / __| '_ \| |_| | |_ \ _____\ \ / /| | '_ ` _ \
"        \__ \ |_) |  _| |___) |_____|\ V / | | | | | | |
"        |___/ .__/|_| |_|____/        \_/  |_|_| |_| |_|
"            |_|
"
"   This is the personal .vimrc file of Steve Francia.
"   While much of it is beneficial for general use, I would
"   recommend picking out the parts you want and understand.
"
"   You can find me at http://spf13.com
"
"   Copyright 2014 Steve Francia
"
"   Licensed under the Apache License, Version 2.0 (the "License");
"   you may not use this file except in compliance with the License.
"   You may obtain a copy of the License at
"
"       http://www.apache.org/licenses/LICENSE-2.0
"
"   Unless required by applicable law or agreed to in writing, software
"   distributed under the License is distributed on an "AS IS" BASIS,
"   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
"   See the License for the specific language governing permissions and
"   limitations under the License.
" }

" Use before config if available {
    if filereadable(expand("~/.vimrc.before.local"))
        source ~/.vimrc.before.local
    endif

" }

" Use bundles config {
    if filereadable(expand("~/.vimrc.bundles"))
        source ~/.vimrc.bundles
    endif
" }

" General {
    set background=dark         " Assume a dark background
    set backspace=2

    filetype plugin indent on   " Automatically detect file types.
    syntax on                   " Syntax highlighting
    set mouse=a                 " Automatically enable mouse usage
    set mousehide               " Hide the mouse cursor while typing
    scriptencoding utf-8

    " Most prefer to automatically switch to the current file directory when
    " a new buffer is opened; to prevent this behavior, add the following to
    " your .vimrc.before.local file:
    "   let g:spf13_no_autochdir = 1
    if !exists('g:spf13_no_autochdir')
        autocmd BufEnter * if bufname("") !~ "^\[A-Za-z0-9\]*://" | lcd %:p:h | endif
        " Always switch to the current file directory
    endif

    set autowrite                       " Automatically write a file when leaving a modified buffer
    set history=1000                    " Store a ton of history (default is 20)
    set hidden                          " Allow buffer switching without saving

    set nobackup                  " Backups are nice ...

" }

" Key (re)Mappings {

    let mapleader = ','

" }

" Vim UI {

    if !exists('g:override_spf13_bundles') && filereadable(expand("~/.vim/bundle/vim-colors-solarized/colors/solarized.vim"))
        let g:solarized_termcolors=256
        let g:solarized_termtrans=1
        let g:solarized_contrast="normal"
        let g:solarized_visibility="normal"
        color solarized             " Load a colorscheme
    endif

    set tabpagemax=15               " Only show 15 tabs
    set showmode                    " Display the current mode

    "set cursorline                  " Highlight current line

    "highlight clear SignColumn      " SignColumn should match background
    "highlight clear LineNr          " Current line number row will have same background color in relative mode
    "highlight clear CursorLineNr    " Remove highlight color from current line number

    "set backspace=indent,eol,start  " Backspace for dummies
    set linespace=0                 " No extra spaces between rows
    "set number                      " Line numbers on
    set showmatch                   " Show matching brackets/parenthesis
    set incsearch                   " Find as you type search
    set hlsearch                    " Highlight search terms

" }

"" Formatting {

"    set wrap                       " Do not wrap long lines
    set autoindent                  " Indent at the same level of the previous line
    set shiftwidth=4                " Use indents of 4 spaces
    set expandtab                   " Tabs are spaces, not tabs
    set tabstop=4                   " An indentation every four columns
    set softtabstop=4               " Let backspace delete indent
    "set nojoinspaces                " Prevents inserting two spaces after punctuation on a join (J)
    set splitright                  " Puts new vsplit windows to the right of the current
    set splitbelow                  " Puts new split windows to the bottom of the current

" }

" Plugins {

    " A.vim {
        if isdirectory(expand("~/.vim/bundle/a.vim"))
            nnoremap <silent> <F12> :A<CR>
            nnoremap <silent> <leader>as :AS<CR>
            nnoremap <silent> <leader>av :AV<CR>
            nnoremap <silent> <leader>at :AT<CR>
        endif
    " }

    " Ctags {
        set tags=./tags;/,~/.vimtags

        " Make tags placed in .git/tags file available in all levels of a repository
        let gitroot = substitute(system('git rev-parse --show-toplevel'), '[\n\r]', '', 'g')
        if gitroot != ''
            let &tags = &tags . ',' . gitroot . '/.git/tags'
        endif
    " }

    " NerdTree {
        if isdirectory(expand("~/.vim/bundle/nerdtree"))
            let g:NERDShutUp=1
            map <C-e> <plug>NERDTreeTabsToggle<CR>
            map <leader>e :NERDTreeFind<CR>
            nmap <leader>nt :NERDTreeFind<CR>

            let NERDTreeShowBookmarks=1
            let NERDTreeIgnore=['\.py[cd]$', '\~$', '\.swo$', '\.swp$', '^\.git$', '^\.hg$', '^\.svn$', '\.bzr$']
            let NERDTreeChDirMode=0
            let NERDTreeQuitOnOpen=1
            let NERDTreeMouseMode=2
            let NERDTreeShowHidden=1
            let NERDTreeKeepTreeInNewTab=1
            let g:nerdtree_tabs_open_on_gui_startup=0
        endif
    " }

    " Tabularize {
        if isdirectory(expand("~/.vim/bundle/tabular"))
            nmap <Leader>a& :Tabularize /&<CR>
            vmap <Leader>a& :Tabularize /&<CR>
            nmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            vmap <Leader>a= :Tabularize /^[^=]*\zs=<CR>
            nmap <Leader>a=> :Tabularize /=><CR>
            vmap <Leader>a=> :Tabularize /=><CR>
            nmap <Leader>a: :Tabularize /:<CR>
            vmap <Leader>a: :Tabularize /:<CR>
            nmap <Leader>a:: :Tabularize /:\zs<CR>
            vmap <Leader>a:: :Tabularize /:\zs<CR>
            nmap <Leader>a, :Tabularize /,<CR>
            vmap <Leader>a, :Tabularize /,<CR>
            nmap <Leader>a,, :Tabularize /,\zs<CR>
            vmap <Leader>a,, :Tabularize /,\zs<CR>
            nmap <Leader>a<Bar> :Tabularize /<Bar><CR>
            vmap <Leader>a<Bar> :Tabularize /<Bar><CR>
        endif
    " }

    " PyMode {
        " Disable if python support not present
        if !has('python') && !has('python3')
            let g:pymode = 0
        endif

        if isdirectory(expand("~/.vim/bundle/python-mode"))
            let g:pymode_lint_checkers = ['pyflakes']
            let g:pymode_trim_whitespaces = 0
            let g:pymode_options = 0
            let g:pymode_rope = 0
        endif
    " }

    " ctrlp {
        if isdirectory(expand("~/.vim/bundle/ctrlp.vim/"))
            let g:ctrlp_working_path_mode = 'ra'
            nnoremap <silent> <D-t> :CtrlP<CR>
            nnoremap <silent> <D-r> :CtrlPMRU<CR>
            let g:ctrlp_custom_ignore = {
                \ 'dir':  '\.git$\|\.hg$\|\.svn$',
                \ 'file': '\.exe$\|\.so$\|\.dll$\|\.pyc$' }

            if executable('ag')
                let s:ctrlp_fallback = 'ag %s --nocolor -l -g ""'
            elseif executable('ack-grep')
                let s:ctrlp_fallback = 'ack-grep %s --nocolor -f'
            elseif executable('ack')
                let s:ctrlp_fallback = 'ack %s --nocolor -f'
            else
                let s:ctrlp_fallback = 'find %s -type f'
            endif
            if exists("g:ctrlp_user_command")
                unlet g:ctrlp_user_command
            endif
            let g:ctrlp_user_command = {
                \ 'types': {
                    \ 1: ['.git', 'cd %s && git ls-files . --cached --exclude-standard --others'],
                    \ 2: ['.hg', 'hg --cwd %s locate -I .'],
                \ },
                \ 'fallback': s:ctrlp_fallback
            \ }

            if isdirectory(expand("~/.vim/bundle/ctrlp-funky/"))
                " CtrlP extensions
                let g:ctrlp_extensions = ['funky']

                "funky
                nnoremap <Leader>fu :CtrlPFunky<Cr>
            endif
        endif
    "}

    " TagBar {
        if isdirectory(expand("~/.vim/bundle/tagbar/"))
            nnoremap <silent> <leader>tt :TagbarToggle<CR>
            " tagbar 子窗口中不显示冗余帮助信息 
             let g:tagbar_compact=1
             " 设置 ctags 对哪些代码标识符生成标签
        endif
    "}


"    " Fugitive {
"        if isdirectory(expand("~/.vim/bundle/vim-fugitive/"))
"            nnoremap <silent> <leader>gs :Gstatus<CR>
"            nnoremap <silent> <leader>gd :Gdiff<CR>
"            nnoremap <silent> <leader>gc :Gcommit<CR>
"            nnoremap <silent> <leader>gb :Gblame<CR>
"            nnoremap <silent> <leader>gl :Glog<CR>
"            nnoremap <silent> <leader>gp :Git push<CR>
"            nnoremap <silent> <leader>gr :Gread<CR>
"            nnoremap <silent> <leader>gw :Gwrite<CR>
"            nnoremap <silent> <leader>ge :Gedit<CR>
"            " Mnemonic _i_nteractive
"            nnoremap <silent> <leader>gi :Git add -p %<CR>
"            nnoremap <silent> <leader>gg :SignifyToggle<CR>
"        endif
    "}

    " UndoTree {
        if isdirectory(expand("~/.vim/bundle/undotree/"))
            nnoremap <Leader>u :UndotreeToggle<CR>
            " If undotree is opened, it is likely one wants to interact with it.
            let g:undotree_SetFocusWhenToggle=1
        endif
    " }

    " JSON {
        nmap <leader>jt <Esc>:%!python -m json.tool<CR><Esc>:set filetype=json<CR>
        let g:vim_json_syntax_conceal = 0
    " }"
    
    " Gutentags {
        if isdirectory(expand("~/.vim/bundle/vim-gutentags/"))
            " 搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归
            let g:gutentags_project_root = ['.root', '.svn', '.git'] 

            " 所生成的数据文件的名称
            let g:gutentags_ctags_tagfile = '.tags'

            " 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
            let s:vim_tags = expand('~/.cache/tags')
            let g:gutentags_cache_dir = s:vim_tags

            " 配置 ctags 的参数
            let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
            let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
            let g:gutentags_ctags_extra_args += ['--c-kinds=+px']
        endif
    "}
    "
    "ALE {
        let g:ale_linters_explicit = 1
        let g:ale_completion_delay = 500
        let g:ale_echo_delay = 20
        let g:ale_lint_delay = 500
        let g:ale_echo_msg_format = '[%linter%] %code: %%s'
        let g:ale_lint_on_text_changed = 'normal'
        let g:ale_lint_on_insert_leave = 1
        let g:airline#extensions#ale#enabled = 1

        let g:ale_c_gcc_options = '-Wall -O2 -std=c99'
        let g:ale_cpp_gcc_options = '-Wall -O2 -std=c++14'
        let g:ale_c_cppcheck_options = ''
        let g:ale_cpp_cppcheck_options = ''
    "}
    "
    " clang_format {

        let g:clang_format#command = 'clang-format'
        nmap <F4> :ClangFormat<cr>
      ""  autocmd FileType c ClangFormatAutoEnable
      ""  let g:clang_format#detect_style_file = 1

        let g:clang_format#style_options = {
                \ "Language" : "Cpp",
                \ "BasedOnStyle" : "Google",
                \ "AccessModifierOffset" : -4,
                \ "AllowShortFunctionsOnASingleLine" : "false",
                \ "AllowShortIfStatementsOnASingleLine" : "false",
                \ "IndentWidth" : 4}

    " }
    "
    
" }
"
    " Initialize directories {
    function! InitializeDirectories()
        let parent = $HOME
        let prefix = 'vim'
        let dir_list = {
                    \ 'backup': 'backupdir',
                    \ 'views': 'viewdir',
                    \ 'swap': 'directory' }

        if has('persistent_undo')
            let dir_list['undo'] = 'undodir'
        endif

        " To specify a different directory in which to place the vimbackup,
        " vimviews, vimundo, and vimswap files/directories, add the following to
        " your .vimrc.before.local file:
        "   let g:spf13_consolidated_directory = <full path to desired directory>
        "   eg: let g:spf13_consolidated_directory = $HOME . '/.vim/'
        if exists('g:spf13_consolidated_directory')
            let common_dir = g:spf13_consolidated_directory . prefix
        else
            let common_dir = parent . '/.' . prefix
        endif

        for [dirname, settingname] in items(dir_list)
            let directory = common_dir . dirname . '/'
            if exists("*mkdir")
                if !isdirectory(directory)
                    call mkdir(directory)
                endif
            endif
            if !isdirectory(directory)
                echo "Warning: Unable to create backup directory: " . directory
                echo "Try: mkdir -p " . directory
            else
                let directory = substitute(directory, " ", "\\\\ ", "g")
                exec "set " . settingname . "=" . directory
            endif
        endfor
    endfunction
    call InitializeDirectories()
    " }

" Use local vimrc if available {
    if filereadable(expand("~/.vimrc.local"))
        source ~/.vimrc.local
    endif
" }
"
"
