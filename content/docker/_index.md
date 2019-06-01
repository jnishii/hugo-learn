---
title: Docker
weight: 14
---

卒論生が`anaconda + opencv`でプログラムを作ろうと，Linux上で
```
$ conda install -c menpo opencv
```
としたが，動画表示ができない。
opencvをbuildし直してffmpegと連携させる必要アリとのこと。
いろいろな事情で，WindowsでもLinuxでもMacでも同じ環境でテストできるようにしたいので, Dockerでイメージを作っておくのが，一番ラクかという結論に。

というわけで 以下はDockerイメージの作り方と使い方のメモ。

## 基本用語

かなり適当な説明なので，正確なことはgoogle先生に聞いて下さい。
- [Docker](https://www.docker.com/): 軽量なアプリケーション開発用仮想マシンのようなもの
- イメージ: 仮想マシンのOSのようなもの
- コンテナ: イメージを読み込んで実行する環境

## Dockerイメージを作る

どこかの誰かのをそのまま使えれば, Dockerを起動してKitematicでインストールするのがお手軽だけど，なかなか思い通りのはないもので。。。

### docker build

1. Dockerfileを作る。Linuxを普段使ってる人なら，適当に拾ってきたDockerfileを参考にしたら作り方は大体わかると思う。
2. [docker build](https://docs.docker.com/engine/reference/commandline/build/)コマンドでイメージを作る。

Dockerfileのあるディレクトリで以下を実行。
```
$ docker build --force-rm=true -t <イメージ名> .
```
- `--force-rm=true`: ビルド中にできる中間コンテナを削除する。
- `-t <イメージ名>`: イメージ名の設定
- 最後の引数はDockerfileのあるディレクトリ。カレントディレクトリに有るなら，上記のように`.`で良い。

プロキシ設定が必要なときには以下の指定する。
```
docker build --force-rm=true -t <イメージ名> --build-arg http_proxy=http://proxy:port --build-arg https_proxy=http://proxy:port .
```

## docker の実行

[docker run](https://docs.docker.com/engine/reference/commandline/run/): 新しいコンテナにイメージを載せて実行。

状況に応じていろんなオプションがある。
一番単純な方法は以下。
```
$ docker run --rm <イメージ名>
```
`--rm`は終了後にコンテナを消すオプション。これをつけないとお掃除が必要になる。

juyter notebook等のwebアプリケーションを使うときはコンテナとホストのポート転送設定をする。
```
$ docker run -p 8080:8080 --rm <イメージ名>
```
ホスト側で作ったファイルをDocker上で見れるようにコンテナにマウントするには`-v`オプションで指定する。
```
$ docker run -v /Users/pochi/:/home/pochi/ --rm <イメージ名>
```
これで，ホスト上の`/Users/pochi`がDocker上の`/home/pochi`にマウントされる。


## コンテナの停止/起動

- [docker stop](https://docs.docker.com/engine/reference/commandline/stop/): コンテナの停止
- [docker start](https://docs.docker.com/engine/reference/commandline/start/): 停止中のコンテナを起動

### お掃除

何度もbuildしていると結構大きなサイズのイメージが残る。
特に`docker build`で`--force-rm=true`の指定をしなかったときにはどんどんたまる。
ダウンロードしたイメージがたまっていることもある。

- [docker ps](https://docs.docker.com/engine/reference/commandline/ps/): 
	- コンテナの一覧表示
	- 停止中のものも表示するときは`-a`をつける
- `$ docker rm <コンテナID>`: 不要なコンテナがあったら，コンテナのIDを確認して削除する。ID指定は最初の3文字のみでもOK。
- `$ docker images`: 不要なイメージがないか確認。
- `$ docker rmi <イメージID>`: 不要なイメージを削除。

ちなみに以下はお掃除を少しサボっていた場合の例。なんどかbuildに失敗したりしてるとあっという間に数10GBを消費されてて大笑い。
中にはbuildのためにダウンロードされているイメージもあるので，どれを消すかは要注意。
```
$ docker images
REPOSITORY                         TAG                 IMAGE ID            CREATED             SIZE
<none>                             <none>              a5c45a7e6ba5        15 minutes ago      4.5GB
<none>                             <none>              f3e00f637740        5 hours ago         1.19GB
ubuntu-anaconda3-opencv3   latest              1ab351999a28        23 hours ago        6.77GB
<none>                             <none>              5c0142dffb0c        24 hours ago        6.77GB
<none>                             <none>              4244ce54ef9b        24 hours ago        6.77GB
<none>                             <none>              7508c15932f9        35 hours ago        6.42GB
ubuntu                             16.04               747cb2d60bbe        2 weeks ago         122MB
hello-world                        latest              05a3bd381fc2        6 weeks ago         1.84kB
ubuntu                             16.10               7d3f705d307c        3 months ago        107MB
```

## その他いろいろ
### 起動中のコンテナのbashターミナルを開きたい

```
docker exec -it <コンテナID> /bin/bash
```
コンテナIDは`docker ps`で取得。


### コンテナからイメージ作成

現在のコンテナの状態をイメージ化する。
```
$ docker commit <コンテナID> <イメージ名:タグ名>
```
イメージの変更履歴を確認する。
```
$ docker history <イメージ名>
```

ただし，`docker commit`だとどのような操作をしたかがわからなくなる。
docker内のターミナルで更新していって，その記録をもとにDockerfileの修正をするのが吉。
`docker commit`は，うまくいったところまでを保存しておくために使う。


### `set -x`

DockefileのRUNコマンドは，`set -x`で実行コマンドを出力しておくと便利

### Docker上の jupyter notebook に対するパスワード認証

Dockerイメージに，jupyter標準のdatascience-notebook等を使う時は以下でOK。

```
$ docker run -it --rm イメージ名 /bin/bash
jovyan$ python -c 'from notebook.auth import passwd;print(passwd())' 
jovyan$ exit
```

表示されるハッシュ文字列(sha1)を使って，dockerにアクセス

```
$ docker run  \
	... \
    start-notebook.sh \
    --NotebookApp.password='sha1:ここにハッシュ文字列を指定'
```

### Makefile

Dockerイメージの構築や実行方法等いちいち覚えていられらいないので，Makefileやスクリプトを作っておくと便利。
```
$ cat Makefile
build:
	docker build --force-rm=true -t <イメージ名> .

run:
	docker run -it --rm <イメージ名>

ps:
	docker ps -a

clean:
	rm *~
```
実行は，`$ make build`等で。

### 参考URL
- [Dockerfile作成のStep by Step](https://qiita.com/icoxfog417/items/2eba17cfd2a17aa5abde)

## Docker内のGUIアプリケーションを表示する

- Dockerイメージを作る時に，Dockerfileに以下のような記述が必要
```
# X
ENV DISPLAY :0.0
VOLUME /tmp/.X11-unix
```
- Docker側がXサーバになるので，利用するPC側にはXクライアントを起動できればOK
- 以下はMac用の方法です。Linux上ではsocatなしでOKなはず(未検証)。

### 準備

1. socatをインストール
```
$ brew install socat
```
2. Xクライアント([Xquartz](https://www.xquartz.org/))をインストール
3. 以下のようなスクリプトを`docker-X.sh`など適当な名前にして保存しておく

	<script src="https://gist.github.com/jnishii/45c21e3a686dc8d570b10d71a5020dc0.js"></script>


### 実行
1. Xquartzのターミナルで以下を実行
```
$ socat TCP-LISTEN:6000,reuseaddr,fork UNIX-CLIENT:\"$DISPLAY\"
```
2. Xquartzの別ターミナルを開いて Docker 起動
```
$ ./docker-X.sh
```