---
title: 変更を一時的に隠す(退避)
---

修正中の手元のファイルは一旦退避して(隠して)，GitHub上のファイルをpullしたいときには`stash` (「隠す」の意味)を使う。


## 変更を隠す(退避)


- commitしていない変更部分を退避する。
```
$ git stash save
```
これで，現在編集中のbranchの全ての変更は一時キャンセルさせて状態になる。
`git add` によるstagingの有無に関係なく退避されますが，新規追加したファイルは退避されない。
- 新規追加したファイルも退避する
```
$ git stash -u save
```
`-u`は`--include-untracked`でもOK。
- addした変更以外を退避する
```
$ git stash -k
```
- 退避時にメッセージを付ける
```
$ git stash save "some message..."
```

## 退避している変更の情報を表示する

- 退避している変更の一覧を表示する。
```
$ git stash list
```
これで，退避した変更のID(`stash@{0}`等)やメッセージが表示される。
- 退避した変更に含まれるファイル一覧を表示
```
$ git stash show <ID>
```
- 変更内容の詳細を表示
```
$ git stash show <ID> -p
```


## 退避したファイルを戻したり消したりする

- 退避していた変更を戻す
```
$ git stash apply <ID>
```
- 退避していた変更を戻し，stashのリストからも消す
```
$ git stash pop <ID>
```
- 退避していた変更を消す
```
$ git stash drop <ID>
```
- 退避していた変更を全て消す
```
$ git stash claer
```
