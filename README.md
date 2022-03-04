# MY NVIM

---

NVIM 配置

## 安装 neovim

---

### 命令行安装
  
``` bash
sudo apt-get install neovim
```

### 源码安装

- 安装指引："https://github.com/neovim/neovim/wiki/Building-Neovim"
- 安装前置软件，具体参看："https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites"
- 命令汇总如下

```bash
git clone https://github.com/neovim/neovim.git
cd neovim/
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

## 使用配置

---

拷贝当前文件(init.vim)到`~/.config/nvim/`目录下，并打开 nvim

## 安装插件管理器

init.vim 生效后首次打开 nvim 后自动安装

## coc.vim

---

coc 支持 lsp，是个强大的补全工具，同时也是一个插件管理工具，可以通过coc安装插件
coc 源码地址："https://github.com/neoclide/coc.nvim"
要使 coc 正常工作首先需要安装 12.12 以上的 nodejs

### nodjs安装

安装指引："https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions"

```bash
# debian 安装方案
curl -fsSL https://deb.nodesource.com/setup_12.x | bash -
apt-get install -y nodejs"
```

### coc-clangd

coc-clangd 是 c++ 补全插件，还有一个插件是 coc-ccls，两者选其一即可
使用 coc-clangd 通过`:CocCommand clangd-install`安装最新 clangd。

## 其他外部工具安装

---

### 安装 ctags/gtags 和 cscope

ctags 安装不多说明，可以使用 apt-get install ctags 直接安装原生 ctags 或者安装 universal-ctags

gtags 是比ctags更好的标签生成器

- 相关攻略："https://zhuanlan.zhihu.com/p/36279445"
- 官方文档："https://www.gnu.org/software/global/global.html"
- 下载地址："https://ftp.gnu.org/pub/gnu/global/global-6.6.tar.gz"
- 安装方式：源码安装，需要先安装 pygments (`sudo pip install pygments`)

### bear

bear 是一个为 clang 生成编译数据库的工具。

安装方式:

- 命令行安装：`sudo apt-get install bear`
- 源码安装: 源码地址为 "https://github.com/rizsotto/Bear"

使用方式：在 make 命令前加 bear，如`bear make -j4`，即可生成 compile_commands.json
生成的 compile_commands.json 是 coc-clangd 补全和跳转的依据

### jq

用于合并两个 json 文件，如 compile_commands.json。
安装方式：`sudo apt-get install jq`
使用方式：

```bash
jq -s 'map(.[])' a/compile_commands.json b/compile_commands.json > compile_commands.json
```

### ranger

使用 rnvimr 插件的前置工具，建议使用 pip 进行安装

### Pynvim

使用 rnvimr 插件的前置工具，建议使用 pip 进行安装

### Ueberzug

使用 rnvimr 插件的前置工具，建议使用 pip 进行安装

### fzf

fzf 堪称模糊搜索神器，效率极高，推荐也安装到控制台使用。
安装参考："https://github.com/junegunn/fzf#installation"
控制台内使用方式：

```bash
# vim 命令后加"**"然后按 tab 键，可以自动进入模糊搜索界面，开始搜索当前目录下的文件，
# vim 命令可以替换成其他文件相关的命令
vim **<tab>

# 弹出模糊搜索界面以搜索进程 ID
kill -9 <tab>

# 按 CTRL+T 搜索当前目录下的文件
<CTRL-T>

# 模糊搜索历史命令
<CTRL-R>

# Host names 补全
ssh **<TAB>
telnet **<TAB>
```

### ripgrep

ripgrep 是非常快速的模糊查找字符串工具，效率是普通工具的几倍甚至几十倍，可以配合 fzf 使用
安装指南："https://github.com/BurntSushi/ripgrep#installation"

- debian 用户可以直接下载 .deb 安装

    ```bash
    curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
    sudo dpkg -i ripgrep_13.0.0_amd64.deb
    ```

- debian 10(buster) 用用户可以直接使用命令`sudo apt-get install ripgrep`进行安装。
- 如果使用源码安装的方式，需要先安装 Rust("https://www.rust-lang.org/")

## 调试技巧

- 打开速度调试: `nvim [openfile] --startuptime profile.log`
- 运行期间调试：`nvim -V8 filename`，可以通过`help verbose`查看更多信息
- 显示运行日志：`:messages`
- 命令信息转存到文件之中：

    ```vimscript
    :redir > finename.txt
    :youcmd
    ```

    使用`help redir`查看更多帮助信息

## 其他

---

- 字体下载："https://www.nerdfonts.com/font-downloads"
