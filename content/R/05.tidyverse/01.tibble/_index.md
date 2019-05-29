---
title: tibbles
---

[tibble](https://tibble.tidyverse.org/)はtidyverseで使うデータ形式の一種。
Rでの型表示は**tbl_df**。
data.frameを以下の点などで改良したもの。
- print()でtibbleを表示しても，デフォルトでは全データは表示しない。(可読性の向上)
- 列ごとにデータ型を決定し，各列中に異なる型のデータは混在できない。(厳密性)


## 情報源

- [tibble](https://tibble.tidyverse.org/)
- [R for Data Science: 10 Tibbles](http://r4ds.had.co.nz/tibbles.html)
- [tibbleの使い方](http://delta0726.web.fc2.com/packages/data/00_tibble.html#1_%E5%B0%8E%E5%85%A5%E7%B7%A8)
	- tibbleをいじる関数についてはここも有益 

## 準備
```
library(tidyvers)
```

## tibbleを作る

- listやarrayから[as_tibble()](https://www.rdocumentation.org/packages/tibble/versions/1.4.2/topics/as_tibble)で変換
```
as_tibble(listやarray)
```
- 数式で生成
```
tibble(
  x = 1:5, y = 1, z = x^2 + y
)
```
tibbleはデータフレームの一種だが，tibbleに対しては変数名や行名, データタイプ(stringsからdouble等)の変更はできない。
- `tribble()`を使うとMarkdownのような表で作ることもできる。tribbleはtransposed tibbleの意味。
```
tribble(
  ~city, ~T, ~weather,
  #-----|---|----
  "Tokyo", 28, "Fine",
  "Osaka", 26, "Cloudy"
)
```

## データ表示

```
<tibble> %>% print(n=10,width=Inf)  # はじめの10行のすべての列を表示
<tibble> %>% print(n=Inf)  # すべての列を表示
```

全データ表示。(jupyter notebookでは残念ながらこのコマンドはサポートされていない)

```
View(<tibble>)
```

列数が多いデータフレームは途中で折り返して表示される。
オプション`options`指定でこの折返し幅を大きくし，全列を表示する例。

```
options(
	tibble.width = Inf,
	width=10000L
	)

df %>% print(n=5)
```

## データの取り出し

```
df <- tibble(
  x = 1:3,
  y = c("cat","dog","mouse")
)
```
以下はどれも要素xへのアクセス方法
```
df$x
df[["x"]]
df[[1]]
df %>% .$x
df %>% .[["x"]]
```

## 列名から列番号

data 中の列名"weather"の列番号を調べる。
```
grep("^weather$", colnames(data) )
```
"time"と"date"の列番号
```
which(names(data)%in%c("time", "date"))
```

## 型変換

tibbleデータ(data)を他の型にする。データフレーム用の関数を使えば(多分)OK。

- [data.matrix()](https://www.rdocumentation.org/packages/base/versions/3.5.1/topics/data.matrix)
- [as.data.frame()](https://www.rdocumentation.org/packages/base/versions/3.5.1/topics/as.data.frame)