---
title:  LaTeX
weight: 3
---

### インストール

M1 Macの場合は、まず以下を行う。

```
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

ここからは、IntelチップもM1チップも同様。
```
$ brew install mactex --cask
```
パスの設定(`~/.bash_profile` 等で設定し、`source ~/.bash_profile`で反映)
```
$ export PATH=/usr/local/texlive/2021/bin/universal-darwin/:$PATH # M1 chip の場合
$ export PATH=/usr/local/texlive/2021/bin/x86_64-darwin/:$PATH   # Intel chip の場合
```

TeXまわりのアップデート
```
$ sudo tlmgr update --self --all
$ sudo tlmgr paper a4
```

- M1 Macへのインストール方法は[M1 MacへのTex導入方法【2021年版】
](https://moromisenpy.com/m1-mactex2021/)を参照。
    - AtomのLaTex環境設定の説明もあってgoodです。

### 設定(Catalina,Mojaveの場合)

情報源: [macOS Mojave / macOS High Sierra / macOS Sierra / OS X El Capitan に付属するヒラギノフォントのセットアップ](https://texwiki.texjp.org/?%E3%83%92%E3%83%A9%E3%82%AE%E3%83%8E%E3%83%95%E3%82%A9%E3%83%B3%E3%83%88#macos-hiragino-setup)

1. TLContribから各種フォント設定用パッケージのダウンロード
```
$ sudo tlmgr repository add http://contrib.texlive.info/current tlcontrib
$ sudo tlmgr pinning add tlcontrib '*'
$ sudo tlmgr install japanese-otf-nonfree japanese-otf-uptex-nonfree ptex-fontmaps-macos cjk-gs-integrate-macos
```
2. 実行
```
$ sudo cjk-gs-integrate --link-texmf --cleanup
```
3. [cjk-gs-integrate-macos.pl](https://raw.githubusercontent.com/texjporg/cjk-gs-support/master/cjk-gs-integrate-macos.pl) をダウンロード
4. 実行
```
$ sudo cjk-gs-integrate-macos --link-texmf
$ sudo mktexlsr
$ sudo kanji-config-updmap-sys --jis2004 hiragino-highsierra-pron
```

### 以下は古い情報
#### 設定(High Sierraの場合)

[macOS High Sierra + Texlive 2017 + ヒラギノフォント](https://qiita.com/osamu620/items/8a299e44d087542e29a9)を見て以下の設定をした。

1. フォントパス等の設定
```
$ git clone https://github.com/texjporg/cjk-gs-support.git
$ cd cjk-gs-support
$ sudo ./cjk-gs-integrate.pl --link-texmf --fontdef-add=cjkgs-macos-highsierra.dat
$ sudo mktexlsr
```
2. jfontmapsの設定
```
$ git clone https://github.com/texjporg/jfontmaps.git
$ cd jfontmaps
```
Makefileの1行目を以下に変更
```
TEXMF = /usr/local/texlive/texmf-local
```
以下を実行
```
$ sudo make install
$ cd script
$ sudo mktexlsr
$ sudo ./kanji-config-updmap-sys.sh hiragino-highsierra-pron
$ sudo mktexlsr
```

ちなみに，いつもお世話になっている[奥村先生のサイト情報](https://okumuralab.org/bibun7/)によると，以下を実行すると良いらしいが，こちらは試していない。何か不具合があった時に実行する。
```
# ln -sf /System/Library/Fonts/ヒラ*ノ明朝\ ProN.ttc /usr/local/texlive/texmf-local/fonts/truetype/cjk-gs-integrate/HiraginoSerif.ttc
# ln -sf /System/Library/Fonts/ヒラ*ノ丸*\ ProN\ W4.ttc /usr/local/texlive/texmf-local/fonts/truetype/cjk-gs-integrate/HiraginoSansR-W4.ttc
# mktexlsr
```

#### 設定(Sierra/El Capitanの場合)
```
$ cd /usr/local/texlive/2016/texmf-dist/scripts/cjk-gs-integrate
$ sudo perl cjk-gs-integrate.pl --link-texmf --force
$ sudo mktexlsr
$ sudo updmap-sys --setoption kanjiEmbed hiragino-elcapitan-pron  <= ヒラギノのProN/StdNを使う
```
Nシリーズでないヒラギノ(Pro/Std)を使うこともできるが，[ヒラギノフォントの販売元](http://www.screen.co.jp/ga_product/sento/support/otf_osx_El_Capitan.html)によるとEl Capitan搭載のヒラギノフォント(Pro/Std)には互換性のための深刻な問題があるので使用はしないようにとのこと。

#### 設定(Yosemiteの場合)
```
$ sudo tlmgr install collection-langjapanese collection-latexrecommended collection-fontsrecommended
```
以下の sethiraginofont.sh を実行してヒラギノフォントを使えるようにする。
```
$ cat sethiraginofont.sh
#!/bin/sh
mkdir -p /usr/local/texlive/texmf-local/fonts/opentype/hiragino/
cd /usr/local/texlive/texmf-local/fonts/opentype/hiragino/
ln -fs "/Library/Fonts/ヒラギノ明朝 Pro W3.otf" ./HiraMinPro-W3.otf
ln -fs "/Library/Fonts/ヒラギノ明朝 Pro W6.otf" ./HiraMinPro-W6.otf
ln -fs "/Library/Fonts/ヒラギノ丸ゴ Pro W4.otf" ./HiraMaruPro-W4.otf
ln -fs "/Library/Fonts/ヒラギノ角ゴ Pro W3.otf" ./HiraKakuPro-W3.otf
ln -fs "/Library/Fonts/ヒラギノ角ゴ Pro W6.otf" ./HiraKakuPro-W6.otf
ln -fs "/Library/Fonts/ヒラギノ角ゴ Std W8.otf" ./HiraKakuStd-W8.otf
mktexlsr
updmap-sys --setoption kanjiEmbed hiragino
$ ./sethiraginofont.sh
```
