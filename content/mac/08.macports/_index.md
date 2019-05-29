---
title: MacPorts
slug: macports
---

MacPortsってのはMac上でフリーソフトのインストール・管理をするシステムです。
西井はMacPortsはやめて[homebrew](../brew)にしましたが，一応こちらも紹介。

- [MacPorts Project Official Homapage](http://www.macports.org/)
- [MacWiki: MacPortsとは](http://macwiki.sourceforge.jp/wiki/index.php/MacPorts)

## 準備

+ [MacPortsのInstallationのページ](http://www.macports.org/install.php)から, 自分の使っているMac OS用のdmgイメージをダウンロードしてインストールする。
-  パス設定をしておく。(`~/.bashrc` に以下を追加)

	```
	export PATH=/opt/local/bin:/opt/local/sbin/:$PATH
	export MANPATH=/opt/local/man:$MANPATH
	```

## インストールメモ
必要なものだけインストールすりゃいいんだけど，こんな具合にという例。

	$ sudo port install lv +lesslikeslash
	$ sudo port install gnuplot
	$ sudo port install grace
	$ sudo port install nkf

## 使い方メモ

### 情報取得・検索

- portコマンドの更新

	```
	$ port - d selfupdate
	```

- 情報更新

	```
	$ port - d sync
	```	

- キーワードによるパッケージ検索

	```
	$ port search <key>
	```

- パッケージ情報

	```
	$ port info <package>
	```

- variants （コンバイルオプション）を知る

	```
	$ port variants <package>
	```

- インストールできるパッケージ一覧

	```
	$ port list
	```

- インストール済み一覧

	```
	$ port installed
	```

- インストールしたパッケージのファイル一覧

	```
	$ port contents <package>
	```

- インストールされてるファイルを提供するパッケージ名を表示

	```
	$ port provides <file name>
	e.g)
	$ port provides /opt/local/etc/irssi.conf
    $ port provides include/tiff.h
	```

- ports の依存関係を知る

	```
	$ port deps <package>
	```

### インストールと更新

- インストール

	```
	$ port install <package> +<variants>
	```

-  アップグレード

	```
	$ port upgrade <package>
	```

- アップグレード可能なソフトウェアの表示

	```
	$ port outdated
	```

-  インストールされているものを一括アップグレード

	```
	$ port upgrade installed
	```

-  古くなった ports を全てアップグレード（結局上と同じことをする）

	```
	$ port upgrade outdated
	```

（コンパイラの出力を表示させたい場合には、上記コマンドで "port" に続けて、- v フラグを追加）

-  ソースに直接手を入れた状態でPortをインストール

	```
	$ sudo port patch TARGET_PORT
	```

を行うと、

	/opt/local/var/macports/sources/rsync.macports.org/release/ports/CATEGORY/TARGET_PORT/work/

以下にソースが展開され、標準のパッチがあればそれらが適用された状態で停止します。これに手動でソースツリーに変更を加えて、

	$ sudo port install TARGET_PORT

を実行するとインストールまで自動で進みます。パッチを作ってPortsファイルを書くまでもないケースに使えます。([情報源](http://lapangan.net/darwinports/index.php?HowTo%2FUseMacPorts))

### 複数のバージョンの使い分け

-  一時無効に(他のvariantを試すときなど)

	```
	$ port deactivate <package>
	```

-  無効解除

	```
	$ port activate <package>
	```

### 削除
-  中間ファイルを削除

	```
	$ port clean
	```

-  パッケージ削除

	```
	$ port uninstall <package> (@version)
	$ port - f uninstall inactive    	# inactiveなのは依存性を無視して削除
	```

## MacPortsのアンインストールの仕方

1. macportsを消す

	```
	$ port installed > port-installed	# 一応なにがインストールされていたかメモ
	$ sudo port -fp uninstall --follow-dependents installed
	```

2. 以下を消去

	```
	/opt/local
	/Library/TeX
	find /Library |grep Port で引っかかるもの(要確認)
	find /Application |grep port で引っかかるもの(要確認)
	~/.macrpots
	```
