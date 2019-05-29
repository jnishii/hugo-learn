---
title: GitHubを使う準備
---

習うより慣れよで，使ってみましょう。

## 準備1: アカウント作り
[GitHub](https://github.com/)や[Bitbucket](https://bitbucket.org)にアカウントを作る。これは各webページで。とりあえずはGitHubに無料アカウントを作りましょう。

## 準備2: git コマンドのインストール
git コマンドをローカルマシンにインストールする。
Mac OSの場合は，Xcode コマンドラインツールをインストールしていたら，gitコマンドもインストールされている。Linuxの場合，apt-get対応のディストリビューションなら

```
$ apt-get install git
```

で大抵OK。

## 準備3: 自分のアカウント情報をローカルマシンに登録

```
$ git config --global user.name “あなたの名前”
$ git config --global user.email “あなたのメールアドレス”
$ git config --global core.editor vi      # コメント編集に使いたいエディタを設定(デフォルトはvi)
```

`--global`は，ローカルリポジトリ作成時のデフォルト設定にするためのオプション。
特定のリポジトリでのみ別の設定にしたいときには，以下の準備3でダウンロードしたポジトリ内に移動してから`--local`を指定して実行する。

## 必要に応じてproxy設定

外部とのネットワーク接続にproxy設定が必要な環境の場合は，[Proxy設定](/proxy)のページを見て設定をする。ターミナルとgitのproxy設定をする。
