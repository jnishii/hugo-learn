---
title: 環境構築(pyenv)
weight: 10
---

Pythonの環境構築に必要なpyenvを上に導入する方法です。
このページでは，pyenv の導入方法を説明します。

- [pyenv](https://github.com/yyuu/pyenv): 複数のバージョンのpythonをインストールしたり，使うバージョンを切り替えたりするのに便利なツール。

Macでhomebrewを使う人も，Linuxの人も以下の手順でOKのはずです。
proxy設定が必要なネットワーク環境の方は，[Proxy設定](../../proxy)を見て, ターミナルの環境変数設定とanacondaの設定をしてください。

## 準備: pyenv のインストール

### Step 1. PYENV_ROOTの設定

`pyenv` 環境をインストールする場所を設定する。
homebrewでインストールする場合のデフォルトでは`~/.pyenv/`(つまり，自分のホーム内に)。
環境変数`PYENV_ROOT`の設定で，インスール先は変更できる。
以下は，デフォルト通りの設定した場合と，`/usr/local/var/pyenv`にした場合の例。
```
export PYENV_ROOT="${HOME}/.pyenv"  # デフォルト通り，`~/.pyenv`にインストールする場合
export PYENV_ROOT=/usr/local/var/pyenv # デフォルトから変えたい場合の例
```
例えば，自分のホームがNFSサーバ上にあり，`/usr/local/`はローカルディスク上ならば，`/usr/local`にインストールするほうが，コマンドの呼び出しのオーバヘッドが短くなる。
`~/.bash_profile`を変更したら，読み込みを忘れずに。
```
$ . ~/.bash_profile # <= 読み込み
$ printenv PYENV_ROOT # <= PYENV_ROOTが無事設定できているか確認
```

### Step 2: pyenvのインストール

**Mac**でhomebrewを使う場合は以下で。
```
$ brew install pyenv
```
**Linux**の場合は，githubから直接ダウンロードする。
```
$ cd ~/
$ git clone https://github.com/yyuu/pyenv.git ${PYENV_ROOT}
```

### Step 3: パス設定: `~/.bash_profile`に以下を追記する。
```
export PATH="${PYENV_ROOT}/shims:$PATH"
if which pyenv > /dev/null; then eval "$(pyenv init -)"; fi
```
再び，`~/.bash_profile`の読み込みをお忘れなく。
```
$ . ~/.bash_profile
```
## さらにいろいろインストール

さらにPythonのプログラム開発に必要なライブラリ等をインストールするには[anacondaを使う方法](../install-anaconda)や[poetryを使う方法](../install-poetry)のページを見てください。
- [Anaconda](https://www.continuum.io/why-anaconda): Pythonとデータ解析モジュールのディストリビューション。とりあえず一式揃えたい人はこちらが便利
- [poetry](https://python-poetry.org/): Pythonのパッケージ管理ツール。環境構築を必要最小限にしたい人，自分独自のPython環境の構築・管理をしたい人，さらにpythonライブラリの開発をしたい人はこちらが便利