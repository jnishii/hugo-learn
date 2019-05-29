---
title: magrittr
---

パイプ処理用パッケージ[magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html)。tidyverseの処理をパイプライン化して見やすくできる。
中毒になる可能性あり(やめられない，あらゆるパイプにしたくなる等)。

## 情報源
- [magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html)
- [pipe中毒になったら、更にわがままな人間になった](https://qiita.com/uri/items/17c213bf2bca7c95b154)

## 準備

```
install.packages("magrittr")
```

## パイプ演算子`%>%`

UNIXのパイプ`|`と同様の機能。以下の2文はそれぞれ同じ意味になる。
(ほとんどが[Package `magittr'より](https://cran.r-project.org/web/packages/magrittr/magrittr.pdf)にある例)
```
x %>% f(y)  # パイプで渡された変数が，第一引数になる
f(x,y)
```
```
y%>%f(x,.) # .で渡す場所をしていできる
f(x,y)
```
```
z%>%f(x,y,arg=.)
f(x,y,z)
```
いろいろな利用例
```
rnorm(100) %>% {c(min(.), mean(.), max(.))} %>% floor
y <- x %>% f() # y<-f(x) と同じ
```
無名関数を定義して使うこともできる。
```
data %>% {
	group_by(.)
	summary(.)
	}
```
下は，上の例と同様
```
data %>% (function(x)){
	group_by(x)
	summary(x)
})
```

### 要注意の例
```
data <- df1 + df2 %>% as_tibble() # df2のみがパイプ処理される
data <- (df1 + df2) %>% as_tibble() # df1+df2の結果がパイプ処理される
```

### 列名の付け替えに使う方法

```
df <- df1+df2
colnames(df) <- c("name1","name2")
```
上をひとつのパイプ処理にする。

```
df <- (df1+df2) %>%
	`colnames<-`(c("name1","name2"))
```



## パイプ演算子`%<>%`
```
library(magrittr)
```
以下はどれも同じ意味
```
x %<>% f()
x <- x %>% f()
x <- f(x)
```

## Tee演算子`%T>%`
```
library(magrittr)
```
以下のようにf,gで順次処理する途中経過の表示をしたいときに使う。plot()に渡すこともできる。
```
data %>% f() %T>% print() %>% g()
```
もし上の例で`%T>%`の代わりに`%>%`を使うと `print()`の出力が`g()`に渡されて，おかしなことになる。

## Dollar演算子 `%$%`
データフレームの変数にアクセスする。
```
data %$% ggplot(data=., aex(x=time,y=temperature))+geom_point()
```
