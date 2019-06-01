---
title: dplyr (データ変換)
weight: 40
---

[dplyr](https://dplyr.tidyverse.org/index.html)を使ったデータ変換の話。詳細は以下でもわかる。
```
vignette("dplyr")
vignette("two-table")
```

## 情報源
- [dplyr](https://dplyr.tidyverse.org/index.html)
- [R for Data Science: 5 Data Transformation](http://r4ds.had.co.nz/transform.html)
- [dplyrを使いこなす！基礎編](https://qiita.com/matsuou1/items/e995da273e3108e2338e#arrange)

## 準備
```
install.packages("tidyverse")
library(tidyverse)
```

## 基本
- **[filter()](https://dplyr.tidyverse.org/reference/filter.html)**: 行データの条件抽出
	```
	filter(data,x>1) # 列xのデータ値が1より大きいものを抽出
	```
- **[slice()](https://dplyr.tidyverse.org/reference/slice.html)**: 行データの切り出し
	```
	data %>% slice(5:10)
	data %>% slice(n())  # 最後の行だけ(n()はデータ数)
	data %>% slice(-5:-n())  # 5から最後の行**以外**
	```
- **[arrange()](https://dplyr.tidyverse.org/reference/arrange.html)**: ソート
- **[select()](https://dplyr.tidyverse.org/reference/select.html)**: 列データの取り出し
	```
	data %>% select(year,month,day) # year, month, dayの列を取り出す
	data %>% select(year:day) # year,month,dayの列が隣接していたら上と同じ
	data %>% select(-(year:day)) # year:day 以外を取り出す
	data %>% select(ends_with("time")) # "time"で終わる列名のデータを取り出す
	```
	- 列名の変更にも使える。ただし，指定した列以外のデータはなくなる。単にある列名のみを変えたいなら[rename()](https://dplyr.tidyverse.org/reference/select.html)を使う。
	- 列の並び替えにも使える。順番を変更しない列群については`everything()`と書いておけば良い。
	```
	data %>% select(year, month, date, everything())
	```
- **[mutate()](https://dplyr.tidyverse.org/reference/mutate.html)**: 列を追加
	```
	mutate(data,
	  duration = start_time - end_time, # 2つの列の差をdataに加える
	  speed = distance / duration  # 2つの列の演算結果を加える
	)
	```	
	元データを捨てて，新規列のみ加えたいときには transmute() を使う
- **[summarise()](https://dplyr.tidyverse.org/reference/summarise.html)**: 集計処理
	- データフレームのデータ中の各グループ(`grou_by()`で指定)に対して，平均値を計算する等の処理を行う。
	- スペルは**summarize()**でもOK。
	- 以下は，毎日の気温データ`data`をyear,monthでグループ分けして，月ごとの平均気温を計算する例。
	```
	by_month <- group_by(data, year, month) # yearを指定しないと，異なる年の同じ月のデータが，同じグループになる。
	summarise(by_month, temp_mean = mean(temperature, na.rm = TRUE))
	```

`summarise()`や`mutate()`には変形版`*_all`, `*_each`, `*_at`, `*_if`がある。
- `*_all`: すべての列に関数を適用
	```
	length_dat %>% mutate_all(funs(. / 2.54))
	length_dat %>% mutate_all(funs(inches = . / 2.54))
- `*_at`: 特定の名前の列に関数を適用
	```
	starwars %>% summarise_at(c("height", "mass"), mean)
	starwars %>% summarise_at(vars(height:mass), mean)
	iris %>% mutate_at(vars(starts_with("Sepal")), log)
	iris %>% mutate_at(vars(matches("Sepal")), funs(./2))
	```
	`matches`や`starts_with`等では正規表現も使える
- `*_if`: 特定の条件を満たす列に関数を適用
	```
	starwars %>% summarise_if(is.numeric, mean) # numericの列の平均
	iris %>% mutate_if(is.double, as.integer) # doubleの列をintegerにする
	```

## `nest`, `unnest`: データフレームの階層化
- **[nest()](https://tidyr.tidyverse.org/reference/nest.html)**: データフレームを階層化
	```
	dataset %>% nest(-city) # city コラムを外のほうに残す
	```
- **[unnest()](https://tidyr.tidyverse.org/reference/unnest.html)**: 階層化したデータフレームをもどす


## `bind_rows`, `bind_cols`: 列や行の追加

同じ列幅や行数の2つのデータフレームを結合させるときには[bind_rows()](https://dplyr.tidyverse.org/reference/bind.html)や[bind_cols()](https://dplyr.tidyverse.org/reference/bind.html)を使う。
`rbind()`や`cbind()`のデータフレーム用関数。



## `join`: tibbleの結合

キーとなる列情報を使って2のtibbleを結合するには[full_join()](https://dplyr.tidyverse.org/reference/join.html)とか，[right_joint()](https://dplyr.tidyverse.org/reference/join.html)とかを使う。データベース関数のjoinと同じようなもの。

## その他

- **[lead(), lag()](https://dplyr.tidyverse.org/reference/lead-lag.html)**: 前後の行の値を参照(列ベクトルに対するシフト演算)
- [dplyrの関数一覧](https://dplyr.tidyverse.org/reference/index.html)
	- `if_else()`, `case_when()`: 特定の要素や欠損値に対する処理をできる
	- `recode()`: ベクトルの特定の値のみを変更できる
