---
title: Apache
---

Macでapacheを起動するためにした設定
- Macのデフォルトapacheを利用
- ディレクトリ`~/Sites`にあるコンテンツに，`http://localhost/~jun`でアクセス。("jun"はユーザ名)

1. apache の設定ファイル`/etc/apache2/httpd.conf`の設定
  1. 以下の各命令文の行頭の`#`をとってコメントアウトを中止。
  ```
  LoadModule userdir_module libexec/apache2/mod_userdir.so
  LoadModule rewrite_module libexec/apache2/mod_rewrite.so
  LoadModule php7_module libexec/apache2/libphp7.so
  Include /private/etc/apache2/extra/httpd-userdir.conf
  ```
  2. `~/Sites/`においているCMSのキャッシュファイル等のアクセス権限設定の手間を省くため，apacheを起動するuid/gidを，自分のと一致させた。
  ```
  User _www
  Group _www
  ```
  とあったのを以下に変更。(これは各人のuid/gidに合わせて)
  ```
  User jun
  Group staff
  ```
  3. localhostしか参照しないのなら，アクセス制限を加えておくと良い
  ```
  <Directory />　<=さがす
      ...
      Order deny,allow <= 追加
      Deny from all <= 追加
      Allow from localhost <= 追加
  </Directory>
  4. さらにセキュリティのことを考えるならポート番号も変える
  ```

2. `/private/etc/apache2/extra/httpd-userdir.conf`を修正
  1. `UserDir`を修正
  ```
  UserDir Sites
  ```
  2. 以下の命令文の行頭の`#`をとってコメントアウトを中止。
  ```
  Include /private/etc/apache2/users/*.conf
  ```
3. `/etc/apache2/users/jun.conf`を追加
```
$ cat /etc/apache2/users/jun.conf
<Directory "/Users/jun/Sites/">
    Options Indexes FollowSymLinks Multiviews
    RewriteEngine on
    AllowOverride All
    Require all granted

    Order deny,allow
    Deny from all
    Allow from localhost
</Directory>
```

apacheの起動等のコマンドは以下のとおり。
```
$ sudo apachectl configtest # 設定ファイルのテスト
$ sudo apachectl restart    # apache起動
```

ブート時に自動起動する方法は以下のとおり。
```
$ sudo launchctl load -w /System/Library/LaunchDaemons/org.apache.httpd.plist
```
