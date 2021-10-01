---
title: いろいろ戻す
weight: 60
---

ファイルやディレクトリを以前のバージョンに戻したいときには以下のように使い分けます。

- addを実行してしまう前に，直前のバージョンに戻すときは`git checkout`
- addを実行してしまった後に，直前のバージョンに戻すときは`git reset`
- pushをしてしまったが，取り消したいときには`git revert`
- 古いバージョンに戻すには`git checkout`
- あるファイルの特定の箇所のみ戻す時には`git revert`を使います。

### 直前の状態に戻す(git add 前)

間違えて変な修正を加えて保存したファイルを，最後にcommitした状態に戻す。ただし`git add`はまだ実行していない場合。
```
$ git checkout HEAD .
```
**HEAD** は現在作業しているブランチ(もしくはそのID)をさす。これは省略可能なので，以下でも良い。
```
$ git checkout .
```
ただし，新しく作ったファイルが削除されることはない。
特定のファイル名のみ戻す時には，その名前を指定する。
```
$ git checkout <file name>
```

### 直前の状態に戻す(git add後)

- `git add`の取り消し(stagingの取り消し)
	```
	$ git reset HEAD <file name>
	```
	staging状態にあるファイル全てについて取り消す時にはファル名の指定は無しで。
- `git add`をしてしまったが, stagingも，実際にファイルやディレクトリに対して行った操作も取り消したい時
```
$ git reset --hard HEAD
```


### 直前の状態に戻す(git commit後)

- commitだけ取り消して，staging状態に戻す
	```
	$ git reset --soft HEAD~
	```
- commitもstagingも取り消したい
	```
	$ git reset HEAD~
	$ git reset --mixed HEAD~
	```
	`HEAD~`は，現在作業しているブランチの一つ古いIDを指す。
- 前回commitした状態に戻す(最新のcommitも，stagingも，ファイル修正も取り消す)
	```
	$ git reset --hard HEAD~
	```

### 古いバージョンに戻す。

履歴を確認し，戻したいバージョンIDを確認して，`git checkout`で戻す。

- 履歴の確認
	```
	$ git log  
	commit 989d476c5ab7fb30bb0eb1ca8f5b917860c9c719`
	Author: Jun Nishii
	Date:   Wed May 24 13:22:45 2017 +0900  
	First commit  
	```
	特定のファイルの履歴を見たいときには`-p <ファイル名>`をつける
- 最新ファイル(最後にcommitしたもの)と，あるバージョンを比較
	```
	$ git show 989d476c5ab7fb30bb0eb1ca8f5b917860c9c719 --word-diff=color  
	```
- あるバージョンに戻す
	```
	$ git checkout 989d476c5ab7fb30bb0eb1ca8f5b917860c9c719 *  
	```
	戻したバージョンを最終バージョンにしたいときには，ここでcommitする。(さらにファイルを修正後でももちろんOK)
	```
	$ git commit -a -m "バージョンを戻す"
	```

### ファイルの特定の箇所のみ戻す

以下のように文書ファイルをいじっていたとする

1. あるバージョンでアブストラクトを書いた
2. 次のバージョンで序論を修正した
3. さらに次のバージョンで図を加えた

ここで，序論の修正に後悔して，序論のみをもとに戻したくなったととき。

```
$ git revert <序論を修正したバージョンのID>
```

### 一度pushしてしまったファイルをリポジトリから完全に消す

`git push`したファイルは，その後削除してもリポジトリに過去データとして残る。これを完全に削除する方法。

1. [git-filter-repo](https://github.com/newren/git-filter-repo/blob/main/INSTALL.md)をインストール
2. `git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch <path to the file or directory>' --prune-empty --tag-name-filter cat -- --all`

情報源
- [How to remove file from Git history?](https://stackoverflow.com/questions/43762338/how-to-remove-file-from-git-history)