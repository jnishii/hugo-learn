---
title: tidyr (整然データ)
---

tidyverseでは，データをtidy data(整然データ)のフォーマットに変換してから解析をする。
言い換えると，tidy dataはtidyverseにおけるデータ解析のための標準フォーマット。
[tidyr](https://tidyr.tidyverse.org/)は，tidy data作成のためのパッケージ。

## 情報源
- [tidyr](https://tidyr.tidyverse.org/)
- [R for Data Science: 12 Tidy data](http://r4ds.had.co.nz/tidy-data.html)

## 準備
```
install.packages("tidyverse")
library(tidyverse)
```

## Tidy Dataとは

**Tidy**である条件
1. 各変数値を異なる列に格納
2. 各観測データセットと各行が対応
3. 各セルには値(ラベルではない)を格納

[R for Data Science: 12 Tidy data](http://r4ds.had.co.nz/tidy-data.html)にわかりやすい例とともに説明がある。以下はそこにある例のメモ。


## gather: いろいろなデータをtidy dataにする

[gather](https://tidyr.tidyverse.org/reference/gather.html)を使って加工する

```
table4b  # population
#> # A tibble: 3 x 3
#>   country         `1999`     `2000`
#> * <chr>            <int>      <int>
#> 1 Afghanistan   19987071   20595360
#> 2 Brazil       172006362  174504898
#> 3 China       1272915272 1280428583
```

このデータを，以下のように変換してtidy dataにする。

- 各列の値を表す列名が1999, 2000になっている。これは変数名でないので，これらを新たなkeyとする列yearとする列を作って，そこに年情報を格納する。
- 各セルの値(value)は人口を表す。そこで，列名をpopulationとする列を作ってそこに各セルの変数を格納する。

```
table4b %>% 
  gather(`1999`, `2000`, key = "year", value = "population")
#> # A tibble: 6 x 3
#>   country     year  population
#>   <chr>       <chr>      <int>
#> 1 Afghanistan 1999    19987071
#> 2 Brazil      1999   172006362
#> 3 China       1999  1272915272
#> 4 Afghanistan 2000    20595360
#> 5 Brazil      2000   174504898
```


## spread: 複数の行にまたがった観測値を整理した列データにする

[spread](https://tidyr.tidyverse.org/reference/spread.html)は2つの列の値がkeyとvalue(値)になっている時，それを列データに整理する。
大抵データ幅が広がる。

```
table2
#> # A tibble: 12 x 4
#>   country      year type           count
#>   <chr>       <int> <chr>          <int>
#> 1 Afghanistan  1999 cases            745
#> 2 Afghanistan  1999 population  19987071
#> 3 Afghanistan  2000 cases           2666
#> 4 Afghanistan  2000 population  20595360
#> 5 Brazil       1999 cases          37737
#> # ... with 6 more rows
```

データの特徴
- 変数名が格納されている列(type)がある
- 異なる変数に対する値が交互に格納されている列(count)がある

```
table2 %>%
    spread(key = type, value = count)
#> # A tibble: 6 x 4
#>   country      year  cases population
#>   <chr>       <int>  <int>      <int>
#> 1 Afghanistan  1999    745   19987071
#> 2 Afghanistan  2000   2666   20595360
#> 3 Brazil       1999  37737  172006362
#> 4 Brazil       2000  80488  174504898
#> 5 China        1999 212258 1272915272
```

## separate/unite: 列の分割・結合

### separate
[separate](https://tidyr.tidyverse.org/reference/separate.html)は一つの列を複数の列に分ける。

```
table3
#> # A tibble: 6 x 3
#>   country      year rate             
#> * <chr>       <int> <chr>            
#> 1 Afghanistan  1999 745/19987071     
#> 2 Afghanistan  2000 2666/20595360    
#> 3 Brazil       1999 37737/172006362  
#> 4 Brazil       2000 80488/174504898  
#> 5 China        1999 212258/1272915272
```

```
table3 %>% 
  separate(rate, into = c("cases", "population"))
#> # A tibble: 6 x 4
#>   country      year cases  population
#> * <chr>       <int> <chr>  <chr>     
#> 1 Afghanistan  1999 745    19987071  
#> 2 Afghanistan  2000 2666   20595360  
#> 3 Brazil       1999 37737  172006362 
#> 4 Brazil       2000 80488  174504898 
#> 5 China        1999 212258 1272915272
```

delimiterの指定方法
```
table3 %>% 
  separate(rate, into = c("cases", "population"), sep = "/")
```
上記の方法では，chr型の`rate`の列が，2つのchr型の列になっている。数値に変換したい。
```
table3 %>% 
  separate(rate, into = c("cases", "population"), convert = TRUE)
```

整数値を分割することもできる。

```
table3 %>% 
  separate(year, into = c("century", "year"), sep = 2) # yearを2桁目で分割
#> # A tibble: 6 x 4
#>   country     century year  rate             
#> * <chr>       <chr>   <chr> <chr>            
#> 1 Afghanistan 19      99    745/19987071     
#> 2 Afghanistan 20      00    2666/20595360    
#> 3 Brazil      19      99    37737/172006362  
#> 4 Brazil      20      00    80488/174504898  
#> 5 China       19      99    212258/1272915272
#> 6 China       20      00    213766/1280428583
```

### unite

[unite](https://tidyr.tidyverse.org/reference/unite.html)は`separate()`の逆。複数の列を1列に結合する。

## その他いろいろ

- [Spread a key-value pair across multiple columns.
](https://tidyr.tidyverse.org/reference/spread.html)
- [drop_na()](https://tidyr.tidyverse.org/reference/drop_na.html): NAを含む行を捨てる
