---
title: magrittr
weight: 20
---

パイプ処理用パッケージ[magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html)。tidyverseの処理をパイプライン化して見やすくできる。
中毒性あり(あらゆるパイプにしたくなる等)なので要注意。

## 情報源
- [magrittr](https://cran.r-project.org/web/packages/magrittr/vignettes/magrittr.html)
- [pipe中毒になったら、更にわがままな人間になった](https://qiita.com/uri/items/17c213bf2bca7c95b154)

## 準備

```
install.packages("magrittr")
```

## いろいろなパイプ処理

### パイプ演算子`%>%`

UNIXのパイプ`|`と同様の機能。以下の2文はそれぞれ同じ意味になる。
(ほとんどが[Package `magittr'より](https://cran.r-project.org/web/packages/magrittr/magrittr.pdf)にある例)
```R
x %>% f(y)  # パイプで渡された変数が，第一引数になる
f(x,y)
```
```R
y%>%f(x,.) # .で渡す場所をしていできる
f(x,y)
```
```R
z%>%f(x,y,arg=.)
f(x,y,z)
```
いろいろな利用例
```R
rnorm(100) %>% {c(min(.), mean(.), max(.))} %>% floor
y <- x %>% f() # y<-f(x) と同じ
```
無名関数を定義して使うこともできる。
```R
data %>% {
	group_by(.)
	summary(.)
	}
```
下は，上の例と同様
```R
data %>% (function(x)){
	group_by(x)
	summary(x)
})
```

#### 要注意の例
```
data <- df1 + df2 %>% as_tibble() # df2のみがパイプ処理される
data <- (df1 + df2) %>% as_tibble() # df1+df2の結果がパイプ処理される
```

#### 列名の付け替えに使う方法

```
df <- df1+df2
colnames(df) <- c("name1","name2")
```
上をひとつのパイプ処理にする。

```
df <- (df1+df2) %>%
	`colnames<-`(c("name1","name2"))
```



### パイプ演算子`%<>%`
```
library(magrittr)
```
以下はどれも同じ意味
```R
x %<>% f()
x <- x %>% f()
x <- f(x)
```

### Tee演算子`%T>%`
```
library(magrittr)
```
以下のようにf,gで順次処理する途中経過の表示をしたいときに使う。plot()に渡すこともできる。
```R
data %>% f() %T>% print() %>% g()
```
もし上の例で`%T>%`の代わりに`%>%`を使うと `print()`の出力が`g()`に渡されて，おかしなことになる。

### Dollar演算子 `%$%`
データフレームの変数にアクセスする。
```
data %$% ggplot(data=., aex(x=time,y=temperature))+geom_point()
```

## magrittrの関数

tibbleの要素全部をまとめて2倍(`multiply_by()`)するとか1を引く(`subtract()`)とかといった処理のための関数がいろいろある。
一覧は以下で見れる。
```
ls("package:magrittr") %>% print()
 [1] "%<>%"                   "%>%"                    "%$%"                   
 [4] "%T>%"                   "add"                    "and"                   
 [7] "debug_fseq"             "debug_pipe"             "divide_by"             
[10] "divide_by_int"          "equals"                 "extract"               
[13] "extract2"               "freduce"                "functions"             
[16] "inset"                  "inset2"                 "is_greater_than"       
[19] "is_in"                  "is_less_than"           "is_weakly_greater_than"
[22] "is_weakly_less_than"    "mod"                    "multiply_by"           
[25] "multiply_by_matrix"     "n'est pas"              "not"                   
[28] "or"                     "raise_to_power"         "set_colnames"          
[31] "set_names"              "set_rownames"           "subtract"              
[34] "undebug_fseq"           "use_series"
```
