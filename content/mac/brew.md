---
title: Homebrew
weight: 2
---

以前はMacのパッケージ管理に[MacPorts](../macports)を使っていたけど，[homebrew](http://brew.sh/)の方がインストールサイズが小さくてすむので，こちらに乗り換えた。
以下はインストールメモ。

## HomeBrewのインストール方法

<!--1. **MacPortsから移行する時**: MacPortsから移行する場合はMacPortsをアンインストールしておく。方法は[こちら](../macports)。-->

1. Command Line Tools for Xcode のインストール
	```
	xcode-select --install
	```

2. brewコマンドのインストール
	```
	$ /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
	$ brew doctor
	```
	`brew doctor`の実行後にエラーが出たら，問題を解決しておく。解決方法は大抵エラーメッセージに書いてある。

3. `brew cask` 実行時のインストールディレクトリの設定
	- homebrew-cask (後述)でインストールしたアプリはデフォルトでは`~/Application`にインストールされる。以下の1, 2行目はこれを`/Application`に変更する設定.
	```
	$ echo "export HOMEBREW_CASK_OPTS=\"--appdir=/Applications\"" >> ~/.bash_profile
	```

## 新規にいろいろインストール

適当に必要なソフトを見繕ってインストール。

- lv:  多言語対応のlessみたいなの
- nkf: 文字コード変換ツール
- rmtrash: rmしたものを完全に消さないで，ゴミ箱に移動してくれる
- [Visual Studio Code](https://azure.microsoft.com/ja-jp/products/visual-studio-code/)
- [pandoc](http://sky-y.github.io/site-pandoc-jp/users-guide/): markdownとかlatexとかdocxとかを相互に変換するツール
- unar: ファイル名が文字化けしない解凍ソフト
- [ffmpeg](https://www.ffmpeg.org/): ビデオやオーディオファイルをいろいろな形式に変換したりできるソフト
- [Krypton app](https://krypt.co/docs/start/installation.html)
- [xonsh](https://xon.sh/index.html): Pythonをコマンドラインで使えるシェル
- [fish](https://fishshell.com/): 軽くて高機能なシェル
	- `fish_config`: ブラウザでカスタマイズ
	- `fish_update_completions`: 補完情報の更新
- z: cdコマンドの拡張版

```
$ brew install lv gnupg nkf rmtrash
$ brew install visual-studio-code
$ brew install pandoc markdown
$ brew install unar
$ brew install ffmpeg
$ brew install kryptco/tap/kr
$ brew install xonsh bash-completion2
$ brew install fish
$ brew install z
```

## brew caskでさらに追加インストール

dmg形式として配布されているものには，brewで管理できるようパッケージ化されているものがある。
そのようなパッケージの管理には`brew cask`を使う。

### いろいろインストール

- [emacs](http://emacsformacosx.com) (Gnu Emacs)
- [Sublime Text 3](https://www.sublimetext.com/): エディタ([こちら](/editors/sublime)にも解説あり)


```
$ brew install xquartz --cask    # R, grace, その他いくつかのアプリで必要
$ brew install sublime-text	--cask #	エディタSublime Text 3
$ brew install google-japanese-ime --cask # google日本語入力
$ brew install qlmarkdown --cask # .md のQuickLookプレビュー
```



### Rのインストール<a id="R"></a>

R は `homebrew/science` にあるものと，`homebrew/cask`にあるものがある。
後者をインストールすると，`/usr/local/lib/`以下にtcl/tk 関連のライブラリがインストールされ，これを消去するようにと`homebrew doctor`がエラーを出す。実際に消すと，Rの実行に困る場合がある。
前者をインストールするとこの問題は無くなるが，gccやら何やら，わさわさとインストールしないといけなくなる(`mpfr, libmpc, isl, gcc, gettext, pcre, pixman, libffi, glib, cairo`がインストールされた...)。ここでは前者の方でインストールする。

```
$ brew install r   # R言語
$ brew cask install rstudio   # RStudio
```

### gnuplotのインストール

gnuplot のインストールは brew cask で xquartz をインストールした後にする。
```
$ brew cask install aquaterm
$ brew install gnuplot --with-x11 --with-aquaterm
```

### mackup

[mackup](https://github.com/lra/mackup/)は各種設定ファイルをDropbox経由で同期する設定をするツール。
```
$ brew install mackup
$ mackup backup  <= macup新規導入時
$ mackup restore <= macupを他のマシンで利用開始時(既にあるmackupファイルを利用)
```
[同期したいものを追加したい時](https://github.com/lra/mackup/tree/master/doc#add-support-for-an-application-or-any-file-or-directory)には`~/.mackup/<name>.cfg`を追加。

### Java Script

Java Script環境のnode.jsを使えるようにする。
nodebrewをインストールして，あとはnpmで必要なものを追加。
```
$ brew install nodebrew
$ mkdir -p ~/.nodebrew/src
$ nodebrew install-binary latest
$ nodebrew use latest
$ echo 'export PATH=$PATH:~/.nodebrew/current/bin' >> ~/.bash_profile
```

## brewコマンドの使い方

- 更新のあるformula確認
```
$ brew outdated
```
- 古いバージョンのformulaを削除(ためこむと数10GBとかになることもあるので注意)
```
$ brew cleanup -n # 削除されるformulaの一覧表示(削除はしない)
$ brew cleanup
```
- formulaの情報表示
```
$ brew info <formula name>
```
- インストールされたformula (homebrewで管理するパッケージ)を一覧表示
```
$ brew list
```
- インストールされているパッケージ一覧(Brewfile)の作成
```
$ brew bundle dump
```
- パッケージ一覧(Brefile)に記載されているパッケージを一括インストール
```
$ brew bundle
```


## 困ったときのメモ

- "You are in 'detached HEAD' state. "と怒られた時は以下を実行する。
```
$ brew untap phinze/homebrew-cask
$ brew tap caskroom/homebrew-cask
```
- [DisplayLink](http://www.displaylink.com/downloads/macos)を使っている場合，このドライバに含まれる`/usr/local/lib/libusb-…` は brew doctorで怒られるので，削除して，homebrewのlibusbをインストールする。
```
$ brew install libusb
```

### 参考リンク

- [Formula-Cookbook](https://github.com/Homebrew/homebrew/wiki/Formula-Cookbook)
- [homebrewをフォークするためのGit&GitHub入門](http://toggtc.hatenablog.com/entry/2012/02/25/232434)
