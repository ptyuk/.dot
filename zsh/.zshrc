#
# Executes commands at the start of an interactive session.
#

# Source Prezto.
if [[ -s "${ZDOTDIR:-$HOME}/init.zsh" ]]; then
  source "${ZDOTDIR:-$HOME}/init.zsh"
fi

#PROMPT
fz="zprompt"
for c in $client; do
    if [[ -s "${ZDOTDIR:-$HOME}/$c/$fz" ]]; then . ${ZDOTDIR:-$HOME}/$c/$fz ; fi
done

#---------------------------------------------------------------------
# global setting
#---------------------------------------------------------------------

# ls-color
eval $(dircolors ${ZDOTDIR:-$HOME}/.dircolors)
export TERM=xterm-256color
if [ -n "$LS_COLORS" ]; then
    zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi
zmodload -ui complist

# コマンド(含内部コマンド)入力中にマニュアルを表示できる：M-h
[ -n "`alias run-help`" ] && unalias run-help
autoload -U run-help

# ファイルのパーミッションを644(rw-r--r--)に設定
umask 022

# alias
fz="zaliases"
for c in $client; do
    if [[ -s "${ZDOTDIR:-$HOME}/$c/$fz" ]]; then . ${ZDOTDIR:-$HOME}/$c/$fz ; fi
done

# Some environment variables
export HISTFILE=${ZDOTDIR:-$HOME}/.zhistory
export HISTSIZE=10000
export SAVEHIST=10000
export USER=$USERNAME
export HOSTNAME=$HOST

### bindkey
# bindkey -v             # vi key bindings
bindkey -e               # emacs key bindings

## Bindkey you may think it's usefull
#bindkey ' ' magic-space  # also do history expansino on space
#bindkey -s "^xs" '\C-e"\C-asu -c "'
#bindkey -s "^xd" "$(date '+-%d_%b')"
#bindkey -s "^xd" "$(date '+-%Y%m%d')"
#bindkey -s "^xf" "$(date '+-%D'|sed 's|/||g')"
#bindkey -s "^xp" "\$(pwd\)/"
#bindkey -s "^xw" "\C-a \$(which \C-e\)\C-a"

# ctrl+j で コマンドの途中からヒストリを呼び出す
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
bindkey "^J" history-beginning-search-backward-end

# 補完機能が強力になる
autoload -U compinit
compinit -u #-uをつけて権限の安産性関係なく実行 mountしてる時に権限の問題があったのでつけた

### Shell options ###

# 親プロセスが死んでも子プロセスが死なない
setopt nohup

# コマンドを訂正して下さる
setopt correct

# ファイル名も訂正して下さる
setopt correct_all

# 複数のタームで実行したコマンドのヒストリを共有化する
setopt share_history

# 直前と同じコマンドを入力した場合，ヒストリに入れない
setopt hist_ignore_dups

# コマンドの不要な空白を削除してヒストリに登録
setopt hist_reduce_blanks

# historyコマンドをヒストリに登録しない
setopt hist_no_store

# スペースで始まるコマンドをヒストリに登録しない
setopt hist_ignore_space

# コマンドの開始時間，経過時間をヒストリに保存
setopt extended_history

# リダイレクション (>) で上書きしない
# >! で強制書き込み
# setopt no_clobber

# エラーの際のビープ音を鳴らさない
setopt no_beep

# 「#」 「~」 「^」を特殊文字として使用する
setopt extended_glob

# 補完候補をスッキリ表示
setopt list_packed

# [@@@@@@] cd を省略
setopt auto_cd

# 変数をディレクトリパスとして利用する
setopt auto_name_dirs

# cd コマンドで自動的にpushdする
setopt auto_pushd

# pushdの重複を防ぐ
setopt pushd_ignore_dups

# popdでスタックの内容を表示しない
setopt pushd_silent

# 日本語のファイル名も補完リストで表示
setopt print_eight_bit

# rm で * を使う際に聞き返してこない
setopt rm_star_silent

# ファイル名中の数字を数字としてソート
setopt numeric_glob_sort

## TAB で順に補完候補を切り替える
 setopt auto_menu
## TAB で順に補完候補を切り替えない
##setopt noautomenu

# 単語の分割ルールをbashと同様にする
setopt sh_word_split

# 自動補完される余分なカンマなどを適宜削除してスムーズに入力
setopt auto_param_keys
# 自動補完したカンマなどが勝手に削除されない（未確定状態にしない）
unsetopt auto_param_keys

#setopt no_list_ambiguous

# emacsでzshを利用
[[ $EMACS = t ]] && unsetopt zle

# 日本語名の directory へ移動
ncd(){ builtin cd "`echo $@ | nkf -s`"}
nls(){ ls $@ | nkf}
# nxmms() { /usr/bin/xmms "`echo $@ | nkf -s`"}
# nplaympeg() { plaympeg "`echo $@ | nkf -s`"}

if [[ -n $SSH_CLIENT || -n $DISPLAY ]]; then
    LANG=ja_JP.UTF-8 export LANG
    LC_ALL=ja_JP.UTF-8 export LC_ALL
    XMODIFIERS=@im=uim export XMODIFIERS
fi

#---------------------------------------------------------------------
# local setting
#---------------------------------------------------------------------
fz="zshrc"
for c in $client; do
    if [[ -s "${ZDOTDIR:-$HOME}/$c/$fz" ]]; then . ${ZDOTDIR:-$HOME}/$c/$fz ; fi
done
