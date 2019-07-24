---
title: Proxy設定
weight: 6
---

以下は，特記してない限りUNIX系のシステムでのProxy設定の説明です。
以下の`<proxyserver>`と`<port>`の部分は，それぞれのLANで適切なホスト名やポート番号に変えましょう。


### ターミナルの環境変数設定

設定が既にされていないことを確認してから，作業すること。
以下で，環境変数に設定の有無をチェックできる
```
$ printenv |grep proxy
$ printenv |grep PROXY
```
設定が見当たらなかったら，以下を`~/.bash_profile`に追加。
ただし，計算機を使う全てのユーザに対応できるようにする場合は`/etc/profile.d/proxy.sh`に追加。
**pyenvコマンドでpythonのモジュール等をインストールする場合**，`https_proxy`の設定をhttpにする。
```
PROXY_SERVER=<proxyserver>:<port>  # 各自設定
export http_proxy="http://$PROXY_SERVER"
export https_proxy="https://$PROXY_SERVER"
# export https_proxy="http://$PROXY_SERVER"　# pyenvコマンドを使う場合はこちら
export ftp_proxy="ftp://$PROXY_SERVER"
export HTTP_PROXY=$http_proxy
export HTTPS_PROXY=$https_proxy
export FTP_PROXY=$ftp_proxy
export all_proxy=$http_proxy
export NO_PROXY=localhost,192.168.*,10.250.*,127.0.*
```


proxyを有効/無効を必要に応じて切り替えたいときには，以下のような関数設定を`~/.bash_profile`に加える。
<script src="https://gist.github.com/jnishii/f21948ddc974234869b1743d4cca93ad.js"></script>
実行は
```
$ setProxy start # proxy設定開始
$ setProxy stop  # proxy設定終了
```

### R
proxyの問題で`install.packages()`が動かないときは，Rコンソール上で以下を実行する。
```
> Sys.setenv("http_proxy"="http://<proxyserver>:<port>")
> options(repos=local({ r <- getOption("repos"); r["CRAN"] <- "http://cran.ism.ac.jp"; r }))
> install.packages("some_package")
```
ちなみに2行目はミラーサイトのどこを選ぶかの設定。

設定を確認するコマンドは以下の通り。
```
> Sys.getenv("http_proxy")
> getOption("repos")
```

毎回入力するのが面倒な時には，`~/.Rprofile`に以下のように書いておく。
```
Sys.setenv("http_proxy"="http://<proxyserver>:<port>")
options(repos=local({ r <- getOption("repos"); r["CRAN"] <- "http://cran.ism.ac.jp"; r }))
```

### git
`~/.gitconfig`に以下を追加する。後半のエントリは，普段sshでgithubに接続している人が，proxy経由での接続もできるようにするための設定。
```
[http]
	proxy = http://<proxyserver>:<port>
[https]
	proxy = https://<proxyserver>:<port>
[url "https://"]
        insteadOf = git://
[url "https://github.com/"]
	insteadOf = git@github.com:
```

以下のコマンドを実行するのでも良い。
```
$ git config --global http.proxy http://<proxyserver>:<port>
$ git config --global https.proxy http://<proxyserver>:<port>
$ git config --global url."https://".insteadOf git://
$ git config --global url."https://github.com/".insteadOf git@github.com:
$ git config --list  # 設定の確認
```
この設定を削除する時に以下の通り。
以下のコマンドを実行するのでも良い。
```
$ git config --global --unset http.proxy
$ git config --global --unset https.proxy
$ git config --global --unset url."https://".insteadOf git://
$ git config --global --unset url."https://github.com/".insteadOf git@github.com:
$ git config --list  # 設定の確認
```
頻繁にproxyの設定/解除が必要ならshell scriptにすると便利。
例えば以下を`setGitProxy`とかいう名前にしてパスの通ったところに置いておく。
<script src="https://gist.github.com/jnishii/05104690e6fe901f975705a74a1317ae.js"></script>
保存後に`chmod +x setGitProxy`をお忘れなく。

ただし，ここまでの設定だとsshによるgithubとの接続はできない。
ssh接続をできるようにするには，`~/.ssh/config`に，以下のようにHostName,Port,PoxyCommandの設定を追加する。
```
Host github.com
  User <ユーザ名>
  IdentityFile ~/.ssh/id_rsa
  HostName ssh.github.com
  Port 443
  ProxyCommand nc -X connect -x <proxyserver>:<port> %h %p
```

本当は接続ネットワークに応じた自動設定をできるとよいのだが...

### curl
`~/.curlrc`に以下を追加する。
```
proxy = "http://<proxyserver>:<port>"
```
コマンドオプションで指定する場合は
```
$ curl -x <proxyserver>:<port> -L 接続先

```

### wget
`/etc/wgetrc`か`~/.wgetrc`に以下を追加する。
```
https_proxy = http://<proxyserver>:<port>
http_proxy = http://<proxyserver>:<port>
ftp_proxy = http://<proxyserver>:<port>
```

### anaconda (python)
``~/.condarc`に以下を追加する。
```
proxy_servers:
	http: http://<proxyserver>:<port>
	https: https://<proxyserver>:<port>
```
### pip (python)
```
$ pip install -–proxy=<proxyserver>:<port>
```

### apt
aptを使うLinux ディストリビューションで必要な設定。
以下を`/etc/apt/apt.conf`に書く。
```
Acquire::ftp::proxy "ftp://<proxyserver>:<port>";
Acquire::http::proxy "http://<proxyserver>:<port>";
Acquire::https::proxy "https://<proxyserver>:<port>/";
```

### Processing (Windows OS)
解決策は[ここ](https://forum.processing.org/two/discussion/12578/sketches-not-running)から。

以下の設定を
`%appdata%\Processing\preferences.txt`か，`Processing-3.0.1\java\lib\net.properties`に書けば良いらしい
。
```
proxy.http.host=<proxyserver>
proxy.http.port=<port>
proxy.https.host=<proxyserver>
proxy.https.port=<port>
proxy.socks.host=<proxyserver>
proxy.socks.port=<port>
```
`%appdata%`の場所の探し方は例えば[ここ](http://www.jaskun.com/windows10/win10-appdata/)に書いてありました。
