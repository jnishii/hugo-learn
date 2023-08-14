---
title: Atom
draft: True
---

[Atom](https://atom.io/)エディタの設定

## Atomのインストール
```
$ brew cask install atom
```

## Atom用各種パッケージ

Atomのメニュー"Preferences/Install"でインストールする

- atomic-emacs: emacsのキーバインディングにする
- [export-html](https://qiita.com/nobuhito/items/b062a8b423d8117c9c0d): 印刷機能を追加(Ctrl-Shift-P)
- fizzy
- japanese-wrap
- language-latex
- [File Icons](https://github.com/file-icons/atom)
  - ファイル一覧に適当なアイコンをつけてくれる

### LaTeX用パッケージ

- [LaTeX Package](https://atom.io/packages/latex)
  - `ctl-alt-b`でlatexコマンド実行
  - 注意) latexmk がインストールされていること
- [PDF View package](https://github.com/izuzak/atom-pdf-view)
  - 編集中のLaTeXファイルの出力PDFを開いておけば，PDFファイルが更新される毎に表示も更新される。
  - 表示されているPDFファイルをクリックすると，**LaTeXファイルの対応箇所に飛ぶことができる**。すばらしい\(^o^)/

```
$ apm install latex
$ apm install pdf-view
```


### Markdown用パッケージ

- [language markdown](https://github.com/burodepeper/language-markdown)
  - Markdownの補間等を適当にしてくれるので，Atomが本格的なMarkdownエディタっぽくなる
- markdown-preview-plus
	- もし"markdown-preview"パッケージがインストールされていたら，無効(disable)にしておく
	- LaTeX数式処理が必要ならSettingsメニューで"Enable Math Rendering By Default"にチェックを入れておく
	- Ctl-Shift-m で起動
- [markdown-preview-enhanced](https://atom.io/packages/markdown-preview-enhanced)
	- 軽い
	- こちらを使うならmarkdown-preview-plusは不要
	- 数式処理はmathjaxではなくてkatex。軽いがmathjaxよりも使えるlatexコマンドが少ないかも


## 日付挿入用キーマップ

日付挿入用キーマップ`alt-shift-D`を追加する。

1. packageに"Date & Time"を追加
2. フォーマットをYYYY/MM/DDにしたいので，READMEを見たら"オプション指定でできる"とあるが，指定の仕方がわからない。仕方ないのでPackage/Date の "View code"を見たら lib/date.js にフォーマット指定できるところがあったので，そこを修正した。まぁいいか。
3. keymap.jsonに以下を追加
```
    'body':
        'alt-shift-D': 'date:date'
```

## その他

- [Atom Keyboard Shortcuts](https://github.com/nwinkler/atom-keyboard-shortcuts)
