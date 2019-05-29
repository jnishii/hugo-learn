---
title: リポジトリの作成
---

自分の作ったソースコードをリポジトリ登録して，Git/GitHubで管理する方法

## 1. ローカルリポジトリの作成

管理したいソースプログラム群があるディレクトリに移動して，バージョン管理のための初期化をする。
```
$ cd <target directory>
$ git init
```

これで，ローカルリポジトリ(`.git/`)が作られ，`git init`を実行したディレクトリが作業ディレクトリになる。

以下のように`git init`でローカルリポジトリ用のディレクトリを新規作成することもできる。
```
$ git init <target directory>
$ cd <target directory>
```

## 2. .gitignoreの作成

gitコマンドでは無視したいファイルが有る時(LaTeXの一時ファイル等)は，`.gitignore`という名前のファイルを作っておく。
以下は例。latex関連の一時ファイルを無視するように設定している。
```
$ cat .gitignore
*.aux
*.idx
*.log
*.toc
*.ist
*.bbl
*.blg
*.dvi
*.ilg
*.ind
*.lot
*.out
*.synctex.gz
*~
```

## 3. ローカルリポジトリに登録するファイルやディレクトリの指定

```
$ git add .            # 現在のディレクトリにある全てのファイル/ディレクトリを登録
$ git add figures/     # ディレクトリ figures/ 以下のファイルを登録
$ git add *.tex        # すべての .tex ファイルを登録
```

一部のファイルのみを登録したい時には`git add <ファイル名>`とすれば良い。

## 4. ローカルリポジトリにファイル登録

`git add`で指定したファイルやディレクトリを，ローカルリポジトリに登録する。
```
$ git commit -m "はじめてのgit"`
```

`-m`は1行コメントをつけるオプション。
更新したファイルをローカルリポジトリに反映するときにも，同様に`git add`と`git commit`を実行する。ここまでは**ローカルリポジトリ**の管理。

## 5. Gitサーバに登録する

インターネット上のどこからでも最新ファイルを入手できるようにするには，Gitサーバにリモートリポジトリを登録する。

1. git サーバ上に新規リモートリポジトリを作る(GitHubやBitbucketの各webページ上で作る)
2. ローカルリポジトリ(要はgit管理したいプログラム群のあるディレクトリ)をgitサーバ上のリモートリポジトリと紐付ける。GitHubにリポジトリを作った時には，その後にするべきことが表示される。以下はその一例。
	```
	$ cd <directory> <= 作業ディレクトリに移動
	$ git remote add origin https://github.com/someone/somerepo.git
	```
	`git remote`は，サーバ上のファイル置き場(リモートリポジトリ)を登録する命令。
	この例では，URL(https://github.com/someone/somerepo.git)を，originという名前(識別子)で登録している。
	識別子 origin は他の名前にしても良いが，慣習的にこの名称が使われている。
	`someone/somerepo`の部分は，GitHub上に作ったリポジトリの名前に従って設定する。

	ただし，非公開リポジトリ(private repository)に登録する場合は，以下のようにGitHubの認証情報を加える。
	```
	$ git remote add origin https://<username>@github.com/someone/somerepo.git
	```
	セキュリティを高めるためには，ssh keyをGitHubに登録しておいて，ssh通信にするほうが無難。この場合の`git rmote`は以下のなる。
	```
	$ git remote add origin git@github.com:someone/somerepo.git
	```

3. 登録情報を確認

	```
	$ git remote -v
	```
	登録情報を間違えていたら，以下のコマンドで一旦削除して再登録する

	```
	$ git remote rm origin
	```

4. リモートリポジトリにローカルリポジトリの内容を反映

	```
	$ git push -u origin master
	```
