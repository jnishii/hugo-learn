---
title: config
weight: 30
---

データを置いてるバスとか，データ保存先のパスとか，
ロケール情報などなどRを実行するための環境変数は，Rスクリプト中に書かないで，[configパッケージ](https://github.com/rstudio/config)を使ってconfigファイルに書いておくと便利。

## 情報源

- [config package](https://cran.r-project.org/web/packages/config/vignettes/introduction.html)

## 使い方メモ

### configパッケージのインストール。

```
install.packages("config")
library(config)
```

### configファイルの用意

`config.yml`と名前をつくる。以下はその中身の例。
```
default:
  dataset: "data.csv"
	destdir: "results"

newdata:
  dataset: "data2.csv"
	inherits: destdir  # 出力先はdefaultと同じ
```

### configファイルの読み込み

```
config <- config::get()
dest<-config$destdir
data<-config$dataset
```

defaultではなくnewdataの方の設定を読み込みたいとき。
```
config<-config::get("newdata")
```

読み込みたい設定名が，config.ymlにちゃんとあるか確認したいとき。
```
config::is_active("newdata")
```

Rスクリプトに読み込むconfigファイルの指定。
カレントディレクトリに`config.yml`を置いてたら設定不要。パスやファイル名を指定するときには以下で。
```
config <- config::get(file = "conf/config.yml")
```
