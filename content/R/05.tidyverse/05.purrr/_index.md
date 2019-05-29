---
title: purrr (反復計算)
---

[purrr](https://purrr.tidyverse.org/index.html)パッケージで，行データに対する反復処理を簡潔に行うことができる。


## 情報源
- [purrr](https://purrr.tidyverse.org/index.html)
- [R for Data Science: 21 Iteration](http://r4ds.had.co.nz/iteration.html)

## 準備
```
install.packages("tidyverse")
library(tidyverse)
```

### map

以下は全部同じ意味。
```
map(df,mean)
map(df,function(x){mean(x)})
df %>% map(~ {mean(.x)})
```
`map()`は出力をlistにするが，doubleで受け取るときには`map_dbl()`で。

### map2, pmap

2要素のリストに対する処理にはmap2, 3要素以上に対する処理にはpmapを使う。

tidyverseでの統計処理は基本的に列毎に行うが，行方向の平均や分散などの計算をするのに便利。

```
library(tidyverse)
library(magrittr) # to use %T>%
​
x<- list(
c(1:3),
c(3:5),
c(5:7))
x %>% pmap(sum)
```
実行結果
```
9
12
15
```
tibbleやvectorに対しても同様に計算できる。


```
y<- tibble(
a=c(1:3),
b=c(2:4),
c=c(3:5))
y %>% pmap(sum)
```

```
z<- tibble(
a=c(1:3),
b=c(2:4),
c=c(3:5))

z %>% pmap(sum)
```


```
size<-3
n<-0

x <- vector("list",size)
for(k in 1:size){
    n=n+1
    x[[n]]<-c(k,k+1,k+2)
}
x
x %>% pmap(mean)
x %>% pmap(~ var(c(...)))
```
`mean()`に対しては平均を計算するオブジェクトを渡せばよいが，`var()`にはリストを要素とするベクトルは受け取らず，unnested な　matrixやdata.frameにする必要がある。
そきで，最後の例にあるように，`...`で，要素を渡して`c()`でオブジェクト化している。

### その他

- [purrrの関数一覧](https://purrr.tidyverse.org/reference/index.html)
- [purrr::as_vector()](https://www.rdocumentation.org/packages/purrr/versions/0.2.5/topics/as_vector): list を vector にする
