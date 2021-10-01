---
title: トラブル対応
weight: 80
---

## Gitコマンドのエラー

### Q. fatal: refusing to merge unrelated histories
`git pull`をしたら
````
* branch            master     -\> FETCH_HEAD
	fatal: refusing to merge unrelated histories
````
と言われた。

A. 以下を試す。
````
$ git merge --allow-unrelated-histories origin/master
````

## GitHubへのアクセス

### Q. Proxyの内側からGitHubにアクセスしたい。

`~/.gitconfig`に以下の設定を加えます。
```
[http]
	proxy = http://proxy.cc.yamaguchi-u.ac.8080
[https]
	proxy = https://proxy.cc.yamaguchi-u.ac.8080
```

## Q. 二段階認証(2FA)を導入したら`git clone`できなくなった。

できればssh接続で`git clone`できるように設定をしましょう。
ただ，proxy超えでssh接続しないといけないときには，設定ではまることもあるので，
https接続を使いたい時にはPersonal access tokenの設定をします。

1. github.com の個人設定メニューの「Settings/Developer settings」を選択
2. 左に出てくるメニューの"Personal access token"を選択
3. "Generate new token"をクリック
4. "Token description"には適当な名称を入力
5. "Select scopes"では"□ repo"にチェック
6. 以下のような内容のファイル`~/.netrc`を作成
```
machine github.com
login <githubのid>
password <取得したtoken>
protocol https
```

<!--
6. 下の方の"Generate token"をクリックして，表示されたtokenを`git clone https://...`を実行した時に聞かれるパスワードとして入力
7. tokenを再度発行したい時には上記の手順2まで実行後，
	1. 作成済みのtokenを選択
	2. ページ下の"Regenerate token"をクリック
-->

## Q. origin に設定しているリモートリポジトリURLを変更したい。

originに設定しているリポジトリの接続先をhttpsにしていたが，やっぱりssh接続にした
いとか，リモートリポジトリのURLが変更になったときには，以下のようにoriginの設定を変更する。
```
$ git remote set-url origin <new repository>
```

## Q. remote: Repository not found
`git clone`をしたら`remote: Repository not found` と言われた。

A. private repository (非公開のリポジトリ)からgit cloneしようとするとこのエラーが出る。

もしくは，sshで`git clone`する。
```
$ git clone git@github.com/someone/somerepo.git

```
もしくは，(セキュリティ上あまり勧めないが)，以下のように認証情報を加えてgit cloneをする。
```
$ git clone https://<username>:<password>@github.com/someone/somerepo.git
```

## Q. fatal: unable to access
`git push` で`fatal: unable to access 'https://github.com/someone/somerepo.git': The requested URL returned error: 403`と言われた。

A. remote repository の URLにユーザ名を加えたら治った。
```
$ git remote set-url origin https://<user name>@github.com/someone/somerepo.git
```

## Q. デフォルトブランチの名前をmasterからmainに変えたい

githubはデフォルトブランチの名前をmasterからmainに変更した。これにあわせて，すでに作っていたリポジトリのブランチ名を変える方法は[ここ](https://qiita.com/masakinihirota/items/1a657674e609be112fc6)が詳しかった。
