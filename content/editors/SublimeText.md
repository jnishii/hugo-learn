---
title: Sublime Text 3
slug: sublime
---

[Sublime Text 3](https://www.sublimetext.com/)の設定方法

## インストール

```
$ brew cask install sublime-text3
```

## 各種設定

### Package Controlのインストール

1. ``Ctrl-Shift-` ``でコンソールを開く
2. コンソールに[呪文](https://packagecontrol.io/installation#st3)登録

### 日本語化

1. `Cmd-Shift-P`で Command Pallet を開く
2. Command Palletで`install package`
3. `japanize`を選択
4. 以下を実行
  ```
  $ cp ~/Library/Application Support/Sublime Text 3/Packages/Japanize/*jp ~/Library/Application Support/Sublime Text 3/Packages/Default/
  ```

### Markdownを使うためのパッケージをインストール

- Monokai Extended
  + markdown の syntax highlight
  + `Preferences/Color Scheme`で色選択
- Markdown Extended
  + markdown内のコードのsyntax highlight
  + `表示/Syntax/Open all with current extension as .../Markdown Extended`を選択
- OmniMarkupPreviewer
  + L ive Preview   が可能
  + `⌘`+`⌥`+`O`: Preview Markup in Browser.
  + `⌘`+`⌥`+`X`: Export Markup as HTML.
  + `Ctrl`+`Alt`+`C`: Copy Markup as HTML.

### ここまでの参考URL

- [Sublime Text で Markdown を快適にする3つのパッケージ](http://webmem.hatenablog.com/entry/sublime-text-markdown)
- [[Mac] Sublime text 3 インストール はじめにやること - 初期設定 - (Setup 1of5)](http://wp.re13b.jp/entry/sublime/setup/install)

### google 日本語入力で「Tab」キーを有効に

日本語の変換候補を選択するのに「Tab」キーを押すと，候補が消えてなくなるのに対応

1. keymapを保存するdirectoryを作る
  ```
  $ mkdir -p ~/Library/Application\ Support/Sublime\ Text\ 3/Packages/Default
  ```
2. `Preferences/Key Bindings – Default`を開く
3. (初めての時のみ) `Ctl-s` (保存)して，一回終了して，もう一度2を実行
4. 以下(95-101行目?)をコメントにする
  ```
  { "keys": ["tab"], "command": "insert_best_completion", "args": {"default": "\t", "exact": true} },
  { "keys": ["tab"], "command": "insert_best_completion", "args": {"default": "\t", "exact": false},
    "context":
        [
          { "key": "setting.tab_completion", "operator": "equal", "operand": true }
        ]
  },
  ```

参考URL: [Sublime Text 3 で日本語入力中に Tab キーで入力・変換候補を選択できるようにする](http://beadored.com/sublime-text-3-suggest-tab/)

### 日本語での文字検索をできるようにする

1. 上記の「Tab」キーの設定と同様に，keymapの編集画面にする
2. 以下をコメントアウト
  ```
  // Find panel key bindings
  // { "keys": ["enter"], "command": "find_next", "context":
  //  [{"key": "panel", "operand": "find"}, {"key": "panel_has_focus"}]
  // },
  ```
3. さらにあと二箇所コメントアウト
  ```
  // Replace panel key bindings
  // { "keys": ["enter"], "command": "find_next", "context":
  //  [{"key": "panel", "operand": "replace"}, {"key": "panel_has_focus"}]
  // },
  ```
  ```
  // Incremental find panel key bindings
  // { "keys": ["enter"], "command": "hide_panel", "context":
  //  [{"key": "panel", "operand": "incremental_find"}, {"key": "panel_has_focus"}]
  // },
  ```

参考URL: [Sublime Text 3 で日本語を検索したとき文字が消える不具合を直す](http://memo.sanographix.net/post/101061111635)

### 印刷できるようにする

[ExportHtml](https://github.com/facelessuser/ExportHtml)を使う

1. `Cmd`-`Shift`-`P`で Command Pallet を開く
2. Command Palletで`install package`
3. "[ExportHtml](https://github.com/facelessuser/ExportHtml)"を選択
4. `Key Bindings - User`に以下を設定
```
{
    "keys": ["ctrl+alt+n"],
    "command": "export_html",
    "args": {
        "numbers": true,
        "wrap": 900,
        "browser_print": true,
        "multi_select": true,
        "color_scheme": "Packages/ExportHtml/ColorSchemes/Print-Color.tmTheme",
        "style_gutter": false
    }
}
```

### LaTeX文書作成用プラグイン

[LatexTools](https://github.com/SublimeText/LaTeXTools)を使う。

1. `Cmd-Shift-P`でCommand Pallette起動
2. Package Control: Install Package 起動
3. LatexToolsをインストール
4. 設定ファイル
```
~/Library/Application\ Support/Sublime\ Text\ 3/Packages/LaTeXTools/builders/traditionalBuilder.py
```
の`DEFAULT_COMMAND_LATEXMK`の設定を以下に変える。(普段使っているlatexmkの設定に応じて修正)
```
DEFAULT_COMMAND_LATEXMK = ["latexmk", "-cd",
"-e", "$latex = 'platex %O -interaction=nonstopmode -synctex=1 %S'",
"-e", "$biber = 'biber %O --bblencoding=utf8 -u -U --output_safechars %B'",
"-e", "$bibtex = 'upbibtex %O %B'",
"-e", "$makeindex = 'mendex -U -r -c -g -s ~/Dropbox/etc/latex/dot.ist %O -o %D %S'",
"-e", "$dvipdf = 'dvipdfmx %O -o %D %S'",
"-f", "-norc", "-gg", "-pdfdvi"]
```

`Cmd-b`でlatexmkコマンドを起動できる。

注) MacTeXとSkimがインストールしてあること。

#### 参考URL

- [OS X El Capitan＋Sublime Text 3でヒラギノを埋め込んだPDFを作る
Raw](https://gist.github.com/wichy/13c970563a2f5a489c9d)
- [TeX Wiki Sublime Text](https://texwiki.texjp.org/?Sublime%20Text#c2e22368)

### そのほかのプラグイン

- WordCount : 文字数表示
