
" 检查plug.vim是否安装下载
if empty(glob('~/.config/nvim/autoload/plug.vim'))
    echo "plug.vim not exist, now download it!"
    :silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

"<=========基础设置==========

"----------缩进相关----------
" c风格智能缩进
set cindent
" 缩进长度
set expandtab
set tabstop=4
set softtabstop=4
set shiftwidth=4

" 详细定制c风格缩进，参见":help cinoptions-values"
" 括号缩进定制
set cino+=(0
" case大括号缩进
set cino+=l1
" C++作用域，public、private等的缩进
set cino+=g0
"----------缩进相关----------

"----------颜色主题----------
" 设置颜色主题
"colorscheme default
" 设置背景颜色
"set background=light

" 语法高亮
syntax on
"----------颜色主题----------

"----------其他----------
" 搜索高亮
set hlsearch
" 搜索时自动显示匹配位置并高亮匹配字符串
set incsearch

" 鼠标设置开启
set mouse=a

" 设置状态栏
"set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}
set statusline=%F%=[%{&ff}\ %Y\ %{&fenc}][Line:%l/%L,Column:%c][%p%%]

" 设置何时显示状态栏
set laststatus=2

" 行号
set number
set relativenumber

" 补全菜单显示设置
set completeopt=menu,menuone

" 设置光标上下最少保留的屏幕行数
set scrolloff=5

" 设置不生成交换文件
set noswapfile

" 设置帮助文档默认语言为中文
set helplang=cn

" 设置文件编码
set fileencodings=ucs-bom,utf-8,euc-cn,gbk,big5,gb18030,latin1

" 可以针对特定文件载入查插件文件
filetype plugin on
" 可以针对特定的文件类型载入缩进文件
filetype indent on

" 设置退格键行为：允许自动缩进上退格，允许换行符上退格，允许在插入开始的位置上退格
set backspace=indent,eol,start

" 打开文件类型识别
filetype on

" 设置可显示的隐藏字符$
set list lcs=eol:$,tab:>-,trail:~,extends:>,precedes:<
set nolist

" 设置隐藏等级，json的引号被隐藏之后，可以设置 conceallevel=0 将其显示出来
set conceallevel=0

" 字符集设置
set encoding=utf-8
" 设置不保存备份文件
set nobackup
set nowritebackup
"----------其他----------

"==========基础设置=========>


"<=========扩展功能==========

" 加载配置
nnoremap <leader>so :source $MYVIMRC <CR>

" 在c语言环境中快捷键显示函数名称
function! ShowFuncName()
    let lnum = line(".")
    let col = col(".")
    echohl ModeMsg
    echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
    echohl None
    call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfunction
map ,f :call ShowFuncName() <CR>

" 记住上次打开的位置
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

" 长行移动
nnoremap k gk
nnoremap gk k
nnoremap j gj
nnoremap gj j

" 在插入模式下光标移动
"inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

cnoremap <C-h> <Left>
cnoremap <C-j> <Down>
cnoremap <C-k> <Up>
cnoremap <C-l> <Right>

" 设置 诸如 "-- INSERT --" 这样的 'showme' 类型的消息颜色
hi ModeMsg ctermfg=DarkGreen
" 设置搜索模式的高亮
"hi Search  ctermfg=DarkCyan
" 设置弹出菜单选中项的高亮方式
hi PmenuSel ctermbg=green ctermfg=white

" 高亮多余的空格
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd VimEnter * match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" 快速输入对应的大括号
inoremap {<CR> {<CR>}<ESC>O

" 跳转快捷键调整
nmap <C-]> g<C-]>

" 鼠标切换快捷键设置
let mouseFlag = 1
function! SetMouse()
    if g:mouseFlag == 1
        let g:mouseFlag = 0
        set mouse=
        echo "mouse off"
    else
        let g:mouseFlag = 1
        set mouse=a
        echo "mouse on"
    endif
endfunction
map <C-c>m :call SetMouse() <CR>

" 行号切换快捷键设置
let numFlag = 1
function! SetNum()
    if g:numFlag == 1
        let g:numFlag = 0
        set nonu
        set norelativenumber
        echo "number of line off"
    else
        let g:numFlag = 1
        set nu
        set relativenumber
        echo "number of line on"
    endif
endfunction
map <leader>n :call SetNum() <CR>

"-----------------------美化标签栏-----------------------
" 定义颜色
hi SelectTabLine term=Bold cterm=Bold gui=Bold ctermbg=None
hi SelectPageNum cterm=None ctermfg=Red ctermbg=None
hi SelectWindowsNum cterm=None ctermfg=DarkCyan ctermbg=None

hi NormalTabLine cterm=Underline ctermfg=Black ctermbg=LightGray
hi NormalPageNum cterm=Underline ctermfg=DarkRed ctermbg=LightGray
hi NormalWindowsNum cterm=Underline ctermfg=DarkMagenta ctermbg=LightGray

function! MyTabLabel(n)
    let label = ''
    let buflist = tabpagebuflist(a:n)
    for bufnr in buflist
        if getbufvar(bufnr, "&modified")
            let label = '+'
            break
        endif
    endfor

    let winnr = tabpagewinnr(a:n)
    let name = bufname(buflist[winnr - 1])
    if name == ''
        " 为没有名字的文档设置个名字
        if &buftype == 'quickfix'
            let name = '[Quickfix List]'
        else
            let name = '[No Name]'
        endif
    else
        " 只取文件名
        let name = fnamemodify(name, ':t')
    endif

    let label .= name
    return label
endfunction

function! MyTabLine()
    let s = ''
    for i in range(tabpagenr('$'))
        " 选择高亮
        let hlTab = ''
        let select = 0
        if i + 1 == tabpagenr()
            let hlTab = '%#SelectTabLine#'
            " 设置标签页号 (用于鼠标点击)
            let s .= hlTab . "[%#SelectPageNum#%T" . (i + 1) . hlTab
            let select = 1
        else
            let hlTab = '%#NormalTabLine#'
            " 设置标签页号 (用于鼠标点击)
            let s .= hlTab . "[%#NormalPageNum#%T" . (i + 1) . hlTab
        endif

        " MyTabLabel() 提供标签
        let s .= ' %{MyTabLabel(' . (i + 1) . ')} '

        "追加窗口数量
        let wincount = tabpagewinnr(i + 1, '$')
        if wincount > 1
            if select == 1
                let s .= "%#SelectWindowsNum#" . wincount
            else
                let s .= "%#NormalWindowsNum#" . wincount
            endif
        endif
        let s .= hlTab . "]"
    endfor

    " 最后一个标签页之后用 TabLineFill 填充并复位标签页号
    let s .= '%#TabLineFill#%T'

    " 右对齐用于关闭当前标签页的标签
    if tabpagenr('$') > 1
        let s .= '%=%#TabLine#%999XX'
    endif

    return s
endfunction
" 使用airline tabline
"set tabline=%!MyTabLine()

" 设置默认不折叠
"set nofoldenable

" 设置折叠方式为手工折叠，zf70j,可以折叠当前光标之下的70行，
" 使用help fold-manual 查看帮助信息，zo 展开折叠
set foldmethod=manual
" 设置折叠配色
hi Folded guibg=black guifg=grey40 ctermfg=grey ctermbg=darkgrey
hi FoldColumn guibg=black guifg=grey20 ctermfg=4 ctermbg=7

" 打通系统粘贴板与neovim粘贴板
" 参考帖子：https://zhuanlan.zhihu.com/p/419472307
" 之前放进来之后，有报错，但是后来突然好了，非常莫名
" if executable('clipboard-provider')
"   let g:clipboard = {
"           \ 'name': 'myClipboard',
"           \     'copy': {
"           \         '+': 'clipboard-provider copy',
"           \         '*': 'clipboard-provider copy',
"           \     },
"           \     'paste': {
"           \         '+': 'clipboard-provider paste',
"           \         '*': 'clipboard-provider paste',
"           \     },
"           \ }
" endif
" set clipboard+=unnamedplus
"==========扩展功能=========>


"<=========插件安装==========

call plug#begin('~/.config/nvim/plugged')

" 配色插件
Plug 'theniceboy/vim-deus'
Plug 'altercation/vim-colors-solarized'

" change-colorscheme 快速切换颜色主体
Plug 'chxuan/change-colorscheme'

" airline 状态栏插件
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" 查看 tag 和符号
Plug 'liuchengxu/vista.vim'

" tags 生成 && 管理
Plug 'ludovicchabant/vim-gutentags'
Plug 'skywind3000/gutentags_plus'

" 预览窗口增强，配合 tags 使用
Plug 'skywind3000/vim-preview'

" quickfix增强
Plug 'mingleeShade/quickr-preview.vim'

" 代码格式化
"Plug 'Chiel92/vim-autoformat'

" 缩进对齐线
"Plug 'nathanaelkane/vim-indent-guides'
Plug 'Yggdroot/indentLine'

" 在悬浮窗中进行文件查找
Plug 'kevinhwang91/rnvimr'

" 文件目录浏览
Plug 'preservim/nerdtree'
"Plug 'preservim/tagbar'

" 补全插件 coc
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 代码片段补全
"Plug 'SirVer/ultisnips'
Plug 'mingleeShade/vim-snippets'

" 简单跳转头文件插件，与 coc-clangd 的 clangd.switchSourceHeader 命令互为补充
Plug 'vim-scripts/a.vim'

" FuzzyFinder插件依赖
"Plug 'vim-scripts/L9'
" 模糊查找插件 fzf 模糊搜索神器，建议安装到控制台
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" 模糊查找 ctrlp, 观察一段时间，如果可以被 LeaderF完全取代，则删去
Plug 'kien/ctrlp.vim'

" 模糊查找 LeaderF
Plug 'Yggdroot/LeaderF', { 'do': ':LeaderfInstallCExtension' }

" 查找关键字和批量替换
Plug 'brooth/far.vim'

" 批量注释
Plug 'preservim/nerdcommenter'

" === 文件编辑相关
" 多光标编辑插件
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
" 对 ".命令" (重复上一个指令) 的扩展
Plug 'tpope/vim-repeat'
" 包裹式编辑，为文章增加前后包裹字符，比如 "" [] {} 等
Plug 'tpope/vim-surround'
" 表格编辑
Plug 'dhruvasagar/vim-table-mode'

" Git支持
Plug 'airblade/vim-gitgutter'

" 文本对齐插件
Plug 'junegunn/vim-easy-align'

call plug#end()

"==========插件安装=========>


"<=========插件设置==========

" ===
" === gitgutter: 显示每一行的git信息（新增、删除或者修改）
" ===
" 跳转到代码块(git修改代码块)
nmap ]h <Plug>(GitGutterNextHunk)
nmap [h <Plug>(GitGutterPrevHunk)
" 用 :Gqf 命令汇总并在 QuickFix 窗口打开所有的修改块
command! Gqf GitGutterQuickFix | copen
" 在修改块上使用 ghs 快捷键，将该代码块加入缓冲区(stage)
nmap ghs <Plug>(GitGutterStageHunk)
" 将git修改回退
nmap ghu <Plug>(GitGutterUndoHunk)
" 打开预览窗口
nmap ghp <Plug>(GitGutterPreviewHunk)

" 使用 [c ]c 遍历所有buffer的git代码块
function! NextHunkAllBuffers()
  let line = line('.')
  GitGutterNextHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bnext
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      1
      GitGutterNextHunk
      return
    endif
  endwhile
endfunction

function! PrevHunkAllBuffers()
  let line = line('.')
  GitGutterPrevHunk
  if line('.') != line
    return
  endif

  let bufnr = bufnr('')
  while 1
    bprevious
    if bufnr('') == bufnr
      return
    endif
    if !empty(GitGutterGetHunks())
      normal! G
      GitGutterPrevHunk
      return
    endif
  endwhile
endfunction

nmap <silent> ]c :call NextHunkAllBuffers()<CR>
nmap <silent> [c :call PrevHunkAllBuffers()<CR>

" 状态栏线上修改情况，vim-airline情况下，无需此配置
" function! GitStatus()
"   let [a,m,r] = GitGutterGetHunkSummary()
"   return printf('+%d ~%d -%d', a, m, r)
" endfunction
" set statusline+=%{GitStatus()}

" 符号高亮
"highlight SignColumn guibg=darkgrey ctermbg=darkgrey
" 悬浮预览窗口为悬浮窗口
let g:gitgutter_preview_win_floating = 1


" ===
" === far: 全局搜索/替换 
" ===
set lazyredraw
set regexpengine=1
set ignorecase smartcase
let g:far#enable_undo=1

nnoremap <silent> <C-M-f> :Farf<cr>
vnoremap <silent> <C-M-f> :Farf<cr>

" farr 界面快捷键说明
" t: 忽略匹配的某一项， 
" T: 忽略全部
" R: 替换
" s: 保存
" u: 撤销
nnoremap <silent> <C-M-r> :Farr<cr>
vnoremap <silent> <C-M-r> :Farr<cr>


" ===
" === vim-multiple-cursors: 多光标编辑, 
" === 该工具已废弃，使用 mg979/vim-visual-multi 取代之
" ===
"let g:multi_cursor_use_default_mapping=0
"默认按键映射
"let g:multi_cursor_start_word_key      = '<C-n>'
"let g:multi_cursor_select_all_word_key = '<A-n>'
"let g:multi_cursor_start_key           = 'g<C-n>'
"let g:multi_cursor_select_all_key      = 'g<A-n>'
"let g:multi_cursor_next_key            = '<C-n>'
"let g:multi_cursor_prev_key            = '<C-p>'
"let g:multi_cursor_skip_key            = '<C-x>'
"let g:multi_cursor_quit_key            = '<Esc>'

" LeaderF: 模糊查找插件，比ctrlp更强
" ===
" === vim-visual-multi: 多光标编辑, 
" ===
" 修改按键映射，按键全映射参考：https://github.com/mg979/vim-visual-multi/wiki/Mappings#full-mappings-list
" 其中 S-Left 和 S-Right 不再文档中，其被定义在
" vim-visual-multi/autoload/vm/maps/all.vim 之中
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n
let g:VM_maps["Select Cursor Down"] = '<M-j>'           " start selecting down
let g:VM_maps["Select Cursor Up"]   = '<M-k>'           " start selecting up
let g:VM_maps["Select l"]           = '<M-l>'           " 选择右移
let g:VM_maps["Select h"]           = '<M-h>'           " 选择左移


" ===
" === vim-table-mode
" ===
" 表格编辑和重排
noremap <LEADER>tm :TableModeToggle<CR>
let g:table_mode_orner_corner='+'
let g:table_mode_header_fillchar='-'

" ===
" === Ultisnips
" ===
"let g:UltiSnipsSnippetDirectories = [$HOME.'/.config/nvim/Ultisnips/', $HOME.'/.config/nvim/plugged/vim-snippets/UltiSnips/']



" ===
" === 配色相关
" ===
"set background=dark
set t_Co=256
colorscheme deus



" ===
" === airline: 状态栏美化
" ===
" 支持 powerline 字体
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1 " 显示窗口tab和buffer
"let g:airline_theme='luna'
let g:airline_theme = 'powerlineish'
let g:airline#extensions#hunks#enabled=1
let g:airline#extensions#branch#enabled=1

if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
" powerline symbols
" 设置字符，window上，打开 字符映射表，找到所需字体对应的字符，自行替换
" 字符选项可参见 
" ~/.config/nvim/plugged/vim-airline/doc/airline.txt
let g:airline_symbols.branch = ''
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
"let g:airline_left_sep = '⮀'
"let g:airline_left_alt_sep = '⮁'
"let g:airline_right_sep = '⮂'
"let g:airline_right_alt_sep = '⮃'




" ===
" === nerdcommenter: 批量注释
" ===
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'


" ===
" === rnvimr
" ===
" rnvimr:
" 浮窗式文件浏览器，非常酷炫且有用，安装需求较多，建议使用pip安装Ranger、Pynvim、Ueberzug等
" $ sudo pip3 install ranger
let g:rnvimr_ex_enable = 1
let g:rnvimr_pick_enable = 1
"let g:rnvimr_draw_border = 0
"let g:rnvimr_bw_enable = 1
highlight link RnvimrNormal CursorLine
nnoremap <silent><leader>r :RnvimrToggle<CR><C-\><C-n>:RnvimrResize 0<CR>
let g:rnvimr_action = {
            \ '<C-t>': 'NvimEdit tabedit',
            \ '<C-x>': 'NvimEdit split',
            \ '<C-v>': 'NvimEdit vsplit',
            \ 'gw': 'JumpNvimCwd',
            \ 'yw': 'EmitRangerCwd'
            \ }
let g:rnvimr_layout = { 'relative': 'editor',
            \ 'width': &columns,
            \ 'height': &lines,
            \ 'col': 0,
            \ 'row': 0,
            \ 'style': 'minimal' }
"let g:rnvimr_presets = [{'width': 1.0, 'height': 1.0}]


" ===
" === ctrlp
" ===
let g:ctrlp_map='<leader>p'



" ===
" === LeaderF: 模糊查找插件，比ctrlp更强
" ===
" don't show the help in normal mode
let g:Lf_HideHelp = 1
let g:Lf_UseCache = 0
let g:Lf_UseVersionControlTool = 0
let g:Lf_IgnoreCurrentBufferName = 1
" popup mode
let g:Lf_WindowPosition = 'popup'
let g:Lf_PreviewInPopup = 1
" 使用WindTerm时，且用 YeHei Powerline 字体时，用以下配置
"let g:Lf_StlSeparator = { 'left': "⮀", 'right': "⮂", 'font': "YeHei Consolas Hybrid Powerline" }

" 使用其他ssh工具时采用
"let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "Droid Sans Mono for Slashed Powerline" }
let g:Lf_StlSeparator = { 'left': "\ue0b0", 'right': "\ue0b2", 'font': "Consolas Nerd Font Mono" }
let g:Lf_PreviewResult = {'Function': 0, 'BufTag': 0 }

let g:Lf_ShortcutF = "<leader>ff"
noremap <leader>fb :<C-U><C-R>=printf("Leaderf buffer %s", "")<CR><CR>
noremap <leader>fu :<C-U><C-R>=printf("Leaderf function %s", "")<CR><CR>
noremap <leader>fm :<C-U><C-R>=printf("Leaderf mru %s", "")<CR><CR>
noremap <leader>ft :<C-U><C-R>=printf("Leaderf tag %s", "")<CR><CR>
noremap <leader>fl :<C-U><C-R>=printf("Leaderf line %s", "")<CR><CR>
noremap <leader>fw :<C-U><C-R>=printf("Leaderf window %s", "")<CR><CR>
noremap <leader>fc :<C-U><C-R>=printf("Leaderf colorscheme %s", "")<CR><CR>

" ===
" === fzf: 模糊查找工具
" === 非常强大的模糊查找工具
" == 按键映射
noremap <leader>sf :Files<CR>
" Rg: 代表 ripgrep 工具，
" 非常快速的模糊查找字符串工具，效率是普通工具的几倍甚至几十倍
" 需要先安装 ripgrep.
" 安装方法：https://github.com/BurntSushi/ripgrep#installation
" 提示0：debian 用户可以直接使用二进制 .deb 安装
"   $ curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
"   $ sudo dpkg -i ripgrep_13.0.0_amd64.deb
" 提示1：debian 10(buster) 可以直接 apt-get install 安装，
" 提示2：源码安装需要先安装 Rust (https://www.rust-lang.org/)
noremap <leader>sr :Rg<CR>
noremap <leader>sh :History<CR>
noremap <leader>sb :Buffers<CR>
noremap <leader>st :Tags<CR>
noremap <leader>sc :History:<CR>
noremap <leader>ss :History/<CR>

" == fzf设置
let g:fzf_preview_window = 'right:60%'
let g:fzf_commit_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'

function! s:list_buffers()
  redir => list
  silent ls
  redir END
  return split(list, "\n")
endfunction

function! s:delete_buffers(lines)
  execute 'bwipeout' join(map(a:lines, {_, line -> split(line)[0]}))
endfunction

command! BD call fzf#run(fzf#wrap({
            \ 'source': s:list_buffers(),
            \ 'sink*': { lines -> s:delete_buffers(lines) },
            \ 'options': '--multi --reverse --bind ctrl-a:select-all+accept'
            \ }))
" 删除Buffer
noremap <leader>sd :BD<CR>

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.8 } }



" ===
" === NERDTree: 目录插件
" ===
" 设置忽略的文件
let NERDTreeIgnore=['\.o$', '\.lo$', '\.la$', 'tags', 'cscope.*']

" 自动打开 NERDTree
function! AutoNERDTree()
    NERDTree
endfunction
"autocmd VimEnter * call AutoNERDTree()

" 设置 NERDTree 快捷键
map <F6> :NERDTree<CR>



" ===
" === tagbar: 类视图浏览器
" === 废弃该插件，打开大文件时太卡了，卡的怀疑人生
" === 优化加在速度，可以使用 nvim [openfile] --startuptime profile.log
"noremap <c-l> :TagbarToggle <CR>


" ===
" === vista.vim: tagbar 替代品, 支持 lsp 和 异步处理
" === vista.vim 不支持原始的 Exuberant Ctags, 
" 如果 g:vista_default_executive 设置为 'ctags', 则需要先安装 Universal-ctags(https://github.com/universal-ctags/ctags) 方可使用
noremap <c-l> :Vista!!<CR>
noremap tc :silent! Vista finder coc<CR>
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]
let g:vista_default_executive = 'coc'
let g:vista_fzf_preview = ['right:50%']
let g:vista#renderer#enable_icon = 1
" function: 
" let g:vista#renderer#icons = {
" \   "function": "\uf794",
" \   "variable": "\uf71b",
" \  }
let g:lightline = {
      \ 'colorscheme': 'wombat',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'readonly', 'filename', 'modified', 'method' ] ]
      \ },
      \ 'component_function': {
      \   'method': 'NearestMethodOrFunction'
      \ },
      \ }
" function! NearestMethodOrFunction() abort
"     return get(b:, 'vista_nearest_method_or_function', '')
" endfunction
" set statusline+=%{NearestMethodOrFunction()}
" autocmd VimEnter * call vista#RunForNearestMethodOrFunction()



" ===
" === cscope: 文件引用跳转插件
" ===
" 增加 cscope 数据库时，给出消息
set nocscopeverbose

" 设置是否使用 quickfix 窗口来线上cscope结果
"set cscopequickfix=s-,c-,d-,i-,t-,e-

" cscope 快捷键设置
" nmap <C-\>s :cs find s <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>g :cs find g <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>c :cs find c <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>t :cs find t <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>e :cs find e <C-R>=expand("<cword>")<CR><CR>
" nmap <C-\>f :cs find f <C-R>=expand("<cfile>")<CR><CR>
" nmap <C-\>i :cs find i ^<C-R>=expand("<cfile>")<CR>$<CR>
" nmap <C-\>d :cs find d <C-R>=expand("<cword>")<CR><CR>
" 设置更新方法
function! UpdateCscope()
    :silent cs kill 0
    ":silent !find . -path ./robot/share/gpb -prune -o -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.hpp" > cscope.files
    :silent !find . -name "*.h" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp" -o -name "*.hpp" > cscope.files
    :!cscope -bkq -i cscope.files
    :cs add cscope.out
    :e
endfunction
" map <F7> :call UpdateCscope()<CR>



" ===
" === gtags:比ctags更好的标签生成器
" ===
let $GTAGSLABEL = 'native-pygments'
let $GTAGSCONF = '/usr/local/share/gtags/gtags.conf'

" 自动动态更新tags，使用传统 ctags，已废弃
function! UpdateTags()
    " only update the tags when we've created one
    if !filereadable("tags")
        return
    endif

    " use the path relative to pwd
    let _file = expand("%")
    let _cmd = 'ctags --append "' . _file . '"'
    let _ret = system(_cmd)
    unlet _cmd
    unlet _file
    unlet _ret
endfunction
" 自动动态更新tags，使用传统 ctags，已废弃
"autocmd BufWritePost *.cpp,*.h,*.c call UpdateTags()

" 设置tag文件
set tags=./.tags;,.tags
set tags+=tags
set tags+=~/.tags/cpp/tags "gcc版本库tags文件

if filereadable('.project_vimrc') "判断文件是否存在
    :source .project_vimrc
endif

" 设置tags生成快捷键
function! SelectTagsFunc()
    if filereadable('.project_vimrc') "判断文件是否存在
        :call ProjectGenerateTags()
    else
        :call DefaultGenerateTags()
    endif
    :e
endfunction
" 将此方法拷贝到对应的项目的.project_vimrc中
"function! ProjectGenerateTags()
"    :silent !ctags -R --languages=c++ --c++-kinds=+p --fields=+iaS  --exclude=thirdparty --exclude=unreal --exclude=lib --exclude=.git --exclude=boost --links=no -f .
"endfunction

function! DefaultGenerateTags()
    :!ctags -R --c++-kinds=+p --fields=+iaS --extra=+q --links=no -f .
endfunction

map <F8> :call SelectTagsFunc()<CR>
"----------ctags----------

" ===
" === vim-gutentags
" ===
" gutentags搜索工程目录的标志，碰到这些文件/目录名就停止向上一级目录递归 "
" 禁用默认增加工程目录标记
let g:gutentags_add_default_project_roots = 0
" 否则脚本之中，会自动增加如下标记
" if g:gutentags_add_default_project_roots
"     let g:gutentags_project_root += ['.git', '.hg', '.svn', '.bzr', '_darcs', '_FOSSIL_', '.fslckout']
" endif
let g:gutentags_project_root = ['.root', '.project']

" 所生成的数据文件的名称 "
let g:gutentags_ctags_tagfile = '.tags'

let g:gutentags_modules = []
if executable('gtags-cscope') && executable('gtags')
	let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 tags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录 "
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags
" 检测 ~/.cache/tags 不存在就新建 "
if !isdirectory(s:vim_tags)
   silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+pxI']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0



" ===
" === gutentags_plus: use gtags like cscope
" ===
" change focus to quickfix window after search (optional).
let g:gutentags_plus_switch = 1

let g:gutentags_plus_nomap = 1
" keymap	desc
" s	Find symbol (reference) under cursor
" g	Find symbol definition under cursor
" d	Functions called by this function
" c	Functions calling this function
" t	Find text string under cursor
" e	Find egrep pattern under cursor
" f	Find file name under cursor
" i	Find files #including the file name under cursor
" a	Find places where current symbol is assigned
" z	Find current word in ctags database
noremap <silent> <leader>gs :GscopeFind s <C-R><C-W><cr>
noremap <silent> <leader>gg :GscopeFind g <C-R><C-W><cr>
noremap <silent> <leader>gc :GscopeFind c <C-R><C-W><cr>
noremap <silent> <leader>gt :GscopeFind t <C-R><C-W><cr>
noremap <silent> <leader>ge :GscopeFind e <C-R><C-W><cr>
noremap <silent> <leader>gf :GscopeFind f <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gi :GscopeFind i <C-R>=expand("<cfile>")<cr><cr>
noremap <silent> <leader>gd :GscopeFind d <C-R><C-W><cr>
" \ga 快捷键卡死，原因暂时未知
" noremap <silent> <leader>ga :GscopeFind a <C-R><C-W><cr>
noremap <silent> <leader>gz :GscopeFind z <C-R><C-W><cr>

let g:gutentags_define_advanced_commands = 1


" ===
" === vim-preview: 增强预览窗口
" ===
" 按键映射
noremap <silent> <leader>qk :PreviewScroll -1<cr>
noremap <silent> <leader>qj :PreviewScroll +1<cr>
inoremap <silent> <leader>qk <c-\><c-o>:PreviewScroll -1<cr>
inoremap <silent> <leader>qj <c-\><c-o>:PreviewScroll +1<cr>
" 默认关闭 preview 窗口的快捷键是 CTRL+W z

" 在Quickfix窗口下打开 预览窗口
autocmd FileType qf nnoremap <silent><buffer> p :PreviewQuickfix<cr>
autocmd FileType qf nnoremap <silent><buffer> P :PreviewClose<cr>
" 用 Esc 退出 Preview + Quickfix 窗口
function ExitQuickfix()
    :PreviewClose
    :cclose
endfunction
autocmd FileType qf nnoremap <silent><buffer> <Esc> :call ExitQuickfix()<cr>

" 预览标签
" 为了能在命令行预览标签，首先需要关闭 在命令行中显示模式
set noshowmode
noremap <F4> :PreviewSignature!<cr>
inoremap <F4> <c-\><c-o>:PreviewSignature!<cr>

" When you are using Language Servers with LanguageClient-neovim, 
" You can use PreviewFile to preview definition instead of jump to it:
"call LanguageClient#textDocument_definition({'gotoCmd':'PreviewFile'})




" ===
" === quickr-preview.vim
" ===
" Auto-open preview window
let g:quickr_preview_on_cursor = 1
" Auto-close quickfix on enter
let g:quickr_preview_exit_on_enter = 1

" 配合 quickr-preview 实现悬浮 preview
function! s:pedit()
    if &buftype != 'quickfix'
        return
    endif
    let l:list_index=line(".")-1
    let l:list=getqflist()[l:list_index]
    echo "print peditttt"
    execute ':pedit +'.l:list.lnum." ".bufname(l:list.bufnr)
endfunction

" ===
" === fuf：提供文件的模糊查找方式
" ===
" 设置 fuzzyfinder 快捷键
"map ff <esc>:FufFile **/<cr>
"map ft <esc>:FufTag<cr>
"map <silent> <c-\> :FufTag! <c-r>=expand('<cword>')<cr><cr>



" ===
" === vim-indent-guides：缩进线，已废弃
" ===
" 缩进对齐线
"let g:indent_guides_enable_on_vim_startup = 1 "添加行，vim启动时启用
"let g:indent_guides_start_level = 1           "添加行，开始显示对齐线的缩进级别
"let g:indent_guides_guide_size = 1            "添加行，对齐线的宽度，（1字符）
"let g:indent_guides_tab_guides = 0            "添加行，对tab对齐的禁用



" ===
" === indentLine: 缩进线
" ===
let g:indentLine_concealcursor = 'inc'
let g:indentLine_conceallevel = 1



" ===
" === autoformat：代码格式化
" ===
"autoformat: 代码格式化，首先需要安装astyle
let g:formatdef_allman = '"astyle --options=~/.astylerc"'
let g:formaters_cpp = ['allman']
let g:formaters_c = ['allman']
"autocmd BufWritePre *.cpp,*.h,*.c,*.hpp :Autoformat



" ===
" === coc-vim: 补全插件
" ===

" coc  插件管理
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-git',
    \ 'coc-xml',
    \ 'coc-vimlsp',
    \ 'coc-jedi',
    \ 'coc-clangd',
    \ 'coc-python',
    \ 'coc-translator',
    \ 'coc-snippets',
    \ 'coc-markdownlint',
    \ 'coc-marketplace'
    \]

" TAB触发补全
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 设置主动触发快捷键
if has('nvim')
    inoremap <silent><expr> <c-space> coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

" Enter 键自动选中第一个补全项
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" 函数跳转快捷键 不调用原始接口
" nmap <silent> gd <Plug>(coc-definition)
" nmap <silent> gy <Plug>(coc-type-definition)
" nmap <silent> gi <Plug>(coc-implementation)
" nmap <silent> gr <Plug>(coc-references)

" 函数跳转快捷键 自行封装接口
nmap <silent> gd :call <SID>CocJumpAndSetTagStack(0) <CR>
nmap <silent> gy :call <SID>CocJumpAndSetTagStack(1) <CR>
nmap <silent> gi :call <SID>CocJumpAndSetTagStack(2) <CR>
nmap <silent> gr :call <SID>CocJumpAndSetTagStack(3) <CR>

function! s:CocJumpAndSetTagStack(type)
	" 记录好跳转前的位置.
	let tag = expand('<cword>')
	let pos = [bufnr()] + getcurpos()[1:]
	let item = {'bufnr': pos[0], 'from': pos, 'tagname': tag}

    " 判断跳转的方式
    let result = v:false
    if a:type == 0
        let result = CocAction('jumpDefinition')
    elseif a:type == 1
        let result = CocAction('jumpTypeDefinition')
    elseif a:type == 2
        let result = CocAction('jumpImplementation')
    elseif a:type == 3
        let result = CocAction('jumpReferences')
    endif

    if result == v:true
        " 如果可以跳转，则取出之前的 tagstack，并判断是否要将跳转前的位置写入
        " tagstack 
		let winid = win_getid()
		let stack = gettagstack(winid)

        " 下面对比当期位置和 tagstack 中的位置，不存在相同元素再行加入
        let temp_item = item
        " 移除‘from’列表最后一个参数，方便与 gettagstack 获取的数据进行比较
        call remove(temp_item['from'], 4)
        let found = v:false
        for iter in stack['items']
            " 为了方便使用“==”进行对比，先移除 matchnr 项
            call remove(iter, "matchnr")
            if iter == temp_item
                " 找到则跳出
                let found = v:true
                break
            endif
        endfor
        if found == v:false
            " 不存在相同项，则设置 tagstack
            let stack['items'] = [item]
            call settagstack(winid, stack, 't')
        endif
	endif
endfunction


" 使用 K 来在预览窗口中显示文档
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    elseif (coc#rpc#ready())
        call CocActionAsync('doHover')
    else
        execute '!' . &keywordprg . " " . expand('<cword>')
    endif
endfunction

" 保持光标不动时，高亮显示符号及其引用(目前不起效果, 先注释)
"autocmd CursorHold * silent call CocActionAsync('highlight')

" 使用 \rn 将符号重命名(目前不起效果，先注释).
nmap <c-\>rn <Plug>(coc-rename)

" 格式化选中的代码(需要lsp语言支持)
"xmap <leader>f  <Plug>(coc-format-selected)
"nmap <leader>f  <Plug>(coc-format-selected)

" 暂时不知道用途，后面看看
" Remap for do codeAction of selected region
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
"xmap <leader>a  <Plug>(coc-codeaction-selected)
"nmap <leader>aw  <Plug>(coc-codeaction-selected)w

" 代码修复
" Apply AutoFix to problem on the current line.
nmap <leader>qf :CocFix <CR>
nmap <leader>dn <Plug>(coc-diagnostic-next)
nmap <leader>dp <Plug>(coc-diagnostic-next)



" ===
" === coc-markdownlint: markdown 语法自动检查
" ===
"

" ===
" === coc-webview: coc-markdown-preview-enhanced 前置插件
" ===


" ===
" === coc-markdown-preview-enhanced: markdown 预览插件，不生效，先留着
" ===


" ===
" === coc-markmap: markdown支持
" ===
" 项目地址：https://github.com/gera2ld/markmap
" 试用了一下，出现错误：“[coc.nvim]: Error on "runCommand": Cannot read property 'watch' of undefined”，暂时放弃


" ===
" === coc-clangd
" ===
" 使用coc-clangd 进行 c++ 代码补全
" coc-clangd github 网站：https://github.com/clangd/coc-clangd
" coc-clangd 需要 compile_commands.json 文件.
" compile_commands.json 的生成方式可以参考：https://clangd.llvm.org/installation.html#project-setup
" 通常 make 环境下，可以安装 bear 工具，使用诸如："$ bear make -j4" 命令的方式进行生成

" clangd 按键映射
" 切换头文件
nnoremap <c-c>a :CocCommand clangd.switchSourceHeader <CR>
" 切换头文件并切屏
nnoremap <c-c>v :CocCommand clangd.switchSourceHeader vsplit <CR>
" 显示符号信息
nnoremap <c-c>s :CocCommand clangd.symbolInfo <CR>


" ===
" === coc-snippets: 代码片段补全
" ===
let g:snips_author="lihaiming"


" ===
" === coc-translator
" ===
nmap ts <Plug>(coc-translator-p)



"===
"=== vim-easy-align: 对齐插件
"===
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap <leader>ea <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap <leader>ea <Plug>(EasyAlign)

"==========插件设置=========>
