# MY NVIM

NVIM 配置

## 安装 neovim

### 命令行安装

```bash
sudo apt-get install neovim
```

### 源码安装

- 安装指引：<https://github.com/neovim/neovim/wiki/Building-Neovim>
- 安装前置软件，具体参看：<https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites>
- 命令汇总如下

```bash
git clone https://github.com/neovim/neovim.git
cd neovim/

# 切到稳定节点
# git checkout stable
# 切到 0.7.0 版本，最新的 DiffView 插件，需求 0.7.0 版本的 neovim
git check 0.7.0

make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install
```

## 使用配置

拷贝当前文件(init.vim)到`~/.config/nvim/`目录下，并打开 nvim。

## 安装插件管理器

### plug.vim

init.vim 生效后首次打开 nvim 后自动安装 plug.vim

### packer.nvim

packer 用来管理 lua 插件

安装方法：

```shell
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
        ~/.local/share/nvim/site/pack/packer/start/packer.nvim
```

## coc.vim

coc 支持 lsp，是个强大的补全工具，同时也是一个插件管理工具，可以通过 coc 安装插件。

coc 源码地址：<https://github.com/neoclide/coc.nvim>

要使 coc 正常工作首先需要安装 12.12 以上的 nodejs。

### nodjs 安装

安装指引：<https://nodejs.org/en/download/package-manager/#debian-and-ubuntu-based-linux-distributions>

```bash
# debian 安装方案
curl -fsSL https://deb.nodesource.com/setup_12.x | bash -
apt-get install -y nodejs"
```

## C++ 支持

### coc-clangd

coc-clangd 是 c++ 补全插件，还有一个插件是 coc-ccls，两者选其一即可。

使用 coc-clangd 通过`:CocCommand clangd-install`安装最新 clangd。

### 安装 ctags/gtags 和 cscope

【已弃用】使用 coc-clangd、anyjump、fzf 之后，感觉花费大量时间和性能来生产 tag 已经没有必要了

ctags 安装不多说明，可以使用`apt-get install ctags`直接安装原生 ctags 或者安装 universal-ctags。

gtags 是比 ctags 更好的标签生成器

- 相关攻略：<https://zhuanlan.zhihu.com/p/36279445>
- 官方文档：<https://www.gnu.org/software/global/global.html>
- 下载地址：<https://ftp.gnu.org/pub/gnu/global/global-6.6.tar.gz>
- 安装方式：源码安装，需要先安装 pygments (`sudo pip install pygments`)

cscope 也可以通过命令直接安装

### bear

【已弃用】 可以使用 `compiler_flags.txt` 文件来配置 clangd 的编译选项

bear 是一个为 clang 生成编译数据库的工具。

安装方式:

- 命令行安装：`sudo apt-get install bear`
- 源码安装: 源码地址为 <https://github.com/rizsotto/Bear>

使用方式：在 make 命令前加 bear，如`bear make -j4`，即可生成 `compile_commands.json`。

生成的 `compile_commands.json` 是 coc-clangd 补全和跳转的依据。
`compile_commands.json` 的生成方式可以参考：<https://clangd.llvm.org/installation.html#project-setup>

### jq

用于合并两个 json 文件，如 `compile_commands.json`。

安装方式：`sudo apt-get install jq`

使用方式：

```bash
jq -s 'map(.[])' a/compile_commands.json b/compile_commands.json > compile_commands.json
```

## Golang 支持

### gopls

gopls 是 Golang 团队自行开发的 language server，可以通过 go 安装`go install golang.org/x/tools/gopls@latest`，
要注意 gopls 配置 gopls 会安装到`go env`显示的`GOPATH`目录下的`bin`目录中，需要将其加环境变量`PATH`中。

> 注意：gopls 需要 go1.12 以上版本。

## Git 支持

### diffview

#### diffview 作用

- 查看当前 git 修改，`DiffViewOpen`
- 比对两个提交节点（分支、tag）的代码差异，`DiffViewOpen commit1 commit2`
- 解决冲突

#### Git 2.31.0 安装

- 安装依赖

```shell
sudo apt update
sudo apt install make libssl-dev libghc-zlib-dev libcurl4-gnutls-dev \
         libexpat1-dev gettext unzip
```

- 源码下载

```shell
git clone https://github.com/git/git
```

- 编译安装

```shell
# 先切换 tag
cd git
# 展示所有的版本 tag
git tags

# 切换版本
git checkout v2.37.3

# 编译
make prefix=/usr/local all

# 安装
sudo make prefix=/usr/local install
```

- 参考

<https://www.howtoing.com/how-to-install-git-on-debian-9>

#### 依赖

- Git ≥ 2.31.0
- Neovim ≥ 0.7.0
- plenary.nvim
- nvim-web-devicons (optional) For file icons

### git-delta

delta(git-delta) 为 `git`、`diff`、`grep` 的输出提供语法高亮页面。

安装方案

```bash
# Debian8
wget https://github.com/dandavison/delta/releases/download/0.15.1/git-delta-musl_0.15.1_amd64.deb
sudo dpkg -i git-delta-musl_0.15.1_amd64.deb

# 查看是否安装成功
delta --version

```

配置

```bash
# 配置 delta
mv .gitconfig ~/
```

相关链接

- 主页：<https://dandavison.github.io/delta/introduction.html>
- 老版本 Debian 安装问题（安装 `musl` 版本）：<https://github.com/dandavison/delta/issues/504>
- 下载列表：<https://github.com/dandavison/delta/releases>

## ChatGPT

### ChatGPT.nvim

使用 packer.nvim 安装。

### curl

依赖高版本的 curl，安装 curl 方法：<https://flowus.cn/4263e38e-57db-4924-ae13-910011a49ba4>

## 格式化

这里主要使用 `mhartington/formatter.nvim` 来做格式化

### astype for cpp

```bash
# astyle
svn co https://svn.code.sf.net/p/astyle/code/trunk/AStyle
cd AStyle
mkdir as-gcc-exe
cd as-gcc-exe
cmake ../
make
sudo make install
```

### prettier for html/css/js/ts/markdown/json and so on

```bash
sudo npm install -g --save-dev --save-exact prettier
```

### clang-format for cpp

```bash
# 这里会安装到 $HOME/.local/bin，需要将该路径加入环境变量 PATH 中
pip install clang-format

# 安装到系统路径
sudo pip install clang-format
```

### stylua for lua

```bash
wget https://github.com/JohnnyMorganz/StyLua/releases/download/v0.10.1/stylua-0.10.1-linux.zip
unzip stylua-0.10.1-linux.zip
chmod +x stylua
mv stylua ~/.local/bin/
sudo ln -sf $HOME/.local/bin/stylua /usr/bin/stylua
```

## 其他外部工具安装

### ranger

使用 rnvimr 插件的前置工具，建议使用 pip 进行安装。

### Pynvim

使用 rnvimr 插件的前置工具，建议使用 pip 进行安装。

### Ueberzug

使用 rnvimr 插件的前置工具，建议使用 pip 进行安装。

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

ripgrep 是非常快速的模糊查找字符串工具，效率是普通工具的几倍甚至几十倍，可以配合 fzf 使用。

安装指南：<https://github.com/BurntSushi/ripgrep#installation>。

- debian 用户可以直接下载 .deb 安装

  ```bash
  curl -LO https://github.com/BurntSushi/ripgrep/releases/download/13.0.0/ripgrep_13.0.0_amd64.deb
  sudo dpkg -i ripgrep_13.0.0_amd64.deb
  ```

- debian 10(buster) 用用户可以直接使用命令`sudo apt-get install ripgrep`进行安装。
- 如果使用源码安装的方式，需要先安装 Rust("https://www.rust-lang.org/")。

### tree-sitter

tree-sitter 是 nvim-treesitter 插件所需要的外部工具。

github 仓库：<https://github.com/tree-sitter/tree-sitter>

安装方法

```bash
    wget https://github.com/tree-sitter/tree-sitter/releases/download/v0.20.3/tree-sitter-linux-x64.gz
    gunzip tree-sitter-linux-x64.gz
    mv tree-sitter-linux-x64 ~/.local/bin/
    sudo ln -sf $HOME/.local/bin/tree-sitter-linux-x64 /usr/bin/tree-sitter
```

### lazygit

lazygit 是一个可交互的命令行 git gui 工具，提供 git 界面显示和各种可交互功能

安装方法

```bash
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin
```

## 健康检查

插件与工具都安装好之后，可以执行`:checkhealth`进行健康检查，并按照提示把问题一一解决

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

- 打开 Coc 日志：`:CocInfo`
- 打开 Coc 插件的日志输出：先输入指令`:CocCommand workspace.showOutput`，然后选择想要打开的日志文件

## 问题汇总

### gopls definition not found

使用 gopls 时出现`[coc.vim] definition not found`，用`:CocCommand workspace.showOutput`查看`languageserver.golang`
的日志，发现在跳转通过 git 引用的包时会出现如下提示：

```bash
fatal: could not read Username for 'https://gitlab.com': terminal prompts disabled
```

参考了帖子："https://medium.com/easyread/today-i-learned-fix-go-get-private-repository-return-error-terminal-prompts-disabled-8c5549d89045"，
按照提示修改了 git 相关配置之后，问题解决，可以正常跳转。修改如下：

```bash
git config --global url."git@gitlab.com:".insteadOf "https://gitlab.com/"
cat ~/git/config
[url "git@gitlab.com:"]
 insteadOf = https://gitlab.com/
```

### coc-sh 报错

打开 `.sh` 文件时出现：`[coc.nvim] bash-language-server client: couldn't create connection
to server.`， `:CocCommand workspace.showOutput sh` 显示：
`Error: Cannot find module 'node:child_process'`。

这个问题可能是由于 `Node.js` 的版本引起的，出问题的 node 版本是 `v14.16.1`，将其升级到 `v14.18.3` 即可。

可以使用 nvm 来安装 `Node.js`，nvm 以及 Node.js 的安装方案：

1. 安装 nvm

   ```bash
   curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
   ```

2. 重启终端或加载 nvm

   安装完成后，需要重启终端或者使用以下命令加载 nvm：

   ```bash
   source ~/.bashrc
   ```

3. 安装 Node.js

   使用以下命令安装 Node.js：

   ```bash
   nvm install <version>
   ```

   其中 `<version>` 是你想要安装的 Node.js 版本号，例如 `14.17.0`。

4. 切换到新安装的 Node.js 版本

   使用以下命令切换到新安装的 Node.js 版本：

   ```bash
   nvm use <version>
   ```

## 其他

### 字体问题

- nerdfonts 字体下载："https://www.nerdfonts.com/font-downloads"
- 建议采用字体: `Consolas Nerd Font Complete Mono`, github 仓库: "https://github.com/zdszero/Consolas-with-Yahei-Nerd-Font"
- 可以通过 `字符映射表` 来选择某个字符
- 其他中文字体
  -- 图标较少但字宽 OK："https://github.com/mingleeShade/YaHei-Consolas-Hybrid-For-Powerline"
  -- 图标齐全，但字宽显示有问题："https://github.com/mingleeShade/yahei-fira-icon-hybrid-font"
