---
title: readr (ファイル入出力)
weight: 20
---

[readr](https://readr.tidyverse.org/)パッケージを使ったファイル入出力方法。
読み込んだデータの型は[tibble](../tibbles)(データフレームの一種)になる。


## 情報源
- [readr](https://readr.tidyverse.org/)
- [R for Data Science: 11 Data import](http://r4ds.had.co.nz/data-import.html)


## 準備
```
library(tidyverse)
```

## ファイルのデータ読み出し関数一覧

- `read_csv()`: ","区切りのファイルから
- `read_csv2()`: ";"区切りのファイルから
- `read_tsv()`: タブ区切りのファイルから
- `read_delim()`: 任意の区切り文字のファイルから
- `read_fwf()`: 固定幅(fixed width)のファイルから
	- `fwf_widths()`, `fwf_positions()`: フィールド幅や位置の取得
- `read_table()`: 空白区切りの固定長幅ファイルから
- `read_log()`: apacheのlogファイルから

例
```
heights <- read_csv("diet.csv")
```
```
read_csv("a,b
1,2")
```

Rの基本関数`read.csv()`に比べて10倍くらい速いらしい。

1. ヘッダ部の読み飛ばし方法
```
read_csv("diet.csv", skip=2) # 2行読み飛ばす
read_csv("diet.csv", comment="#") # "#"で始まる行を読み飛ばす
```
末尾を読み飛ばしたいときには，他のコマンドと組み合わせてなんとかする。
以下は，初めの10行と，終わりの3行をスキップする例。
```
read_lines("diet.csv",skip=10) %>% 
	head(-3) %>%
	read_csv()

```
2. 列名は除外する
```
read_csv("diet.csv",col_names = FALSE)
```
3. 列名をつける
```
read_csv("diet.csv", col_names = c("x", "y", "z"))
```
4. 欠損データを埋める
```
read_csv("diet.csv", na = ".")
```

## ファイル出力

### ファイル出力その1 (csv/tsv形式で保存)

`write_csv()`, `write_tsv()`

データの保存形式は以下になる
- UTF-8
- dates, dates-timesは ISO8601

**注意:** `write_csv()`では，各列のデータ型の情報がなくなる

### ファイル出力その2 (良い方法)

- 方法1: `write_rds()`, `read_rds()`を入出力に使う。(RDS は R's custom binary format)
- 方法2: featherパッケージの`write_feather()`，`read_feather`を使う。RDSよりも速くて，R以外でも使える。ただし，featherでは使えない形式がある。

以下は，ページャ機能`utils::page()`を使ってrdsファイル読み込んで表示するRスクリプト例。

```
height = 30L  # for example
width = 160L
options(
	tibble.width = Inf,
	tibble.print_max = Inf,
	width=10000L  # folding width on terminal
	)
fname <- commandArgs(trailingOnly=TRUE)[1]
dat <- read_rds(fname) %T>% page('print')
```

上記スクリプト名を`less.r`とした場合，以下のように実行すれば，rdsファイルの表示をできる。

```
$ Rscript less.r <filename>.rds
```
csvファイルを見るなら，スクリプト中の`read_rds`を`read_csv`に変えたらいいが，それよりは`less`を使って直接見たほうが早い。

## いろいろ

### あるパス内のcsvファイルを片っ端読み込む

```
library('tidyverse')

source_dir="/home/someone/data/"
files <- list.files(path=source_dir, pattern=".csv$", full.names=T) %>%
	map(read_csv, skip = 1) %>%
	reduce(bind_rows)
```
[purrr::reduce](https://purrr.tidyverse.org/reference/reduce.html)は，リスト要素を順に関数に引き渡す命令。
この例では，ファイルから読み込んだデータフレームが順にrbindで結合される。

nested dataframeにする方法もある。
```
data <- list.files(path=source_dir, pattern=".csv$", full.names=T) %>%
	data_frame(filename=.) %>%    
	mutate(contents=map(filename, ~ read_csv(file.path(source_dir, .)))
        )  
```
2行目でファイル名一覧を要素とするdataframeを作り，3行目で各ファイルの中身を格納したデータフレーム(nested dataframe)を要素とする列(contents)を追加している。
これを一つのデータフレームに変換したければ
```
unnest(data)
```

