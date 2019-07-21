---
title: ggplot2 (グラフ描画)
weight: 60
---

Rの標準のplotよりも，文法構造がわかりやすい。


## 参考リンク
- [ggplot2](https://ggplot2.tidyverse.org/)
- [R for Data Science: 3 Data visualisation
](http://r4ds.had.co.nz/data-visualisation.html)
- [R for Data Science: 28 Graphics for communication
](http://r4ds.had.co.nz/graphics-for-communication.html)
- [Cookbook for R >> Graphs](http://www.cookbook-r.com/Graphs/)


## 準備
```
install.packages("tidyverse")
library(tidyverse)
```

## 基本

データは[tidy data](../tplyr)にしておく。
```
p<-ggplot(data) +
	geom_line(mapping=aes(x=time,y=temperature))
```

- `ggplot()`
	- グラフ描画のレイヤーを重ねることができる座標系を作るための宣言
	- 引数はグラフ描画に使うデータ。
- `geom_なんとか()`
	- グラフのレイヤーを作る
	- `geom_line()`, `geom_point()`，他にもいろいろある
	- `aes()`を使って，各座標軸に対応する列名や，描画色等を指定


なにかの量の平均(mean)と標準偏差(sd)の列があれば，mean±SDの領域の描画もできる。

```
p<-ggplot(data) %>%
	geom_line(aes_string(x=time,y=mean))
q<-geom_ribbon(aes_string(x=mean, ymin=mean-sd, ymax=mean+sd), alpha=0.2)

print(p+q)
```

上記のようにグラフレイヤの重ね合わせは足し算でできる。

いろんなグラフを作るための関数一覧(cheatsheet)は [ggplot2](https://ggplot2.tidyverse.org/)にある。



## 複数のグラフを並べて配置する

### 参考URL
- [Write vignette about grid](https://github.com/tidyverse/ggplot2/issues/1239)
- [ggplot2、grid、gtable、gridExtraの関係とか](https://notchained.hatenablog.com/entry/2015/12/17/010904)


## 複数のグラフを並べて配置する

### multiplot()を使う

とりあえず何列かに整列させれば良いときはこれが便利。
```
install.packages("Rmisc")
library(Rmisc) 
```
**ただし，Rmiscはtidyverseより先に読み込むこと。**
Rmiscを後に読み込むと，tplyr::summariseがRmisc::summariseで上書きされてしまう。

```
multiplot(g1,g2,g3,g4,cols=2) # 2列に並べる
multiplot(g1,g2,g3,cols=2,layout=c(1,2,3,3)) # 上半分にg1とg2, 下半分にg3
```

- [RDocumentation >> multiplot
](https://www.rdocumentation.org/packages/scater/versions/1.0.4/topics/multiplot)
- [Multiple graphs on one page (ggplot2)
](http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/)


### cowplotライブラリを使う

[cowplot](https://github.com/wilkelab/cowplot)はggplot2のアドオンパッケージ。
"The cowplot package is meant to provide a publication-ready theme for ggplot2"とのことで，綺麗なテーマ設定を使える。特に，グラフ配置機能も充実。

- [cowplot](https://github.com/wilkelab/cowplot)
- [Introduction to cowplot](https://cran.r-project.org/web/packages/cowplot/vignettes/introduction.html)
- [（cowplotパッケージ）研究用にスッキリ簡潔にggplotを描画 & 複数パネル化](http://nhkuma.blogspot.com/2016/09/cowplotggplot2.html)

```
library(tidyverse)
library(cowplot)
```


### facet_grid()を使う

ggplot2純正の方法。個々のグラフにラベルを張ったり，同じグラフをすべてのグラフに重ねたり等には`facet_wrapper()`が便利。

- [Lay out panels in a grid
](https://ggplot2.tidyverse.org/reference/facet_grid.html)
- [Wrap a 1d ribbon of panels into 2d](https://ggplot2.tidyverse.org/reference/facet_grid.html)

### gridExtraライブラリを使う

- [Laying out multiple plots on a page
](https://cran.r-project.org/web/packages/egg/vignettes/Ecosystem.html)

### ggpubrライブラリのfacetを使う

[ggpubr](http://www.sthda.com/english/rpkgs/ggpubr/)は，ggplot2のwrapperで，
名称は"‘ggplot2’ Based Publication Ready Plots"の省略形。
ggplot2よりも簡単にグラフ作成ができる。
また，`ggpubr`の`facet`使うと，座標軸の位置やタイトル位置を揃えたりできる。

- [ggpubr: ‘ggplot2’ Based Publication Ready Plots](http://www.sthda.com/english/rpkgs/ggpubr/)
- [ggplot2 - Easy Way to Mix Multiple Graphs on The Same Page](http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/81-ggplot2-easy-way-to-mix-multiple-graphs-on-the-same-page/)
- [Create and Customize Multi-panel ggplots: Easy Guide to Facet](http://www.sthda.com/english/articles/24-ggpubr-publication-ready-plots/83-create-and-customize-multi-panel-ggplots-easy-guide-to-facet/)



## その他いろいろ

### jupyter notebook/lab 上のグラフ描画領域設定

```
options(repr.plot.width=8, repr.plot.height=4)
ggplot(...)+...
```
これでjupyter上でのグラフの大きさや余白を調整できる。


### 列名を表す文字列を軸名にする

```
draw_graph<-function(data,xcol="xname",ycol="yname",group="city"){
	data %>% ggplot() +
		plot_line(aes_string(x=xcol,y=ycol,group=group,color=group))
}
```

`aes_string()`のかわりに`aes_q()`を使う方法もある。

```
aes_q(x=as.name(xcol),y=as.name(group))
```

ただし，group分けに使う列がnumericだと，gradient colormapしか使えなくい。
無理やり discrete colormap　を与えようとすると”Error: Continuous value supplied to discrete scale”と怒られる。group情報のある列をcharacterに変換しておくのが，多分一番簡単。

```
q<- data %>% 
	mutate_at(vars(matches(group)),as.character)  %>%
	ggplot() %>%
	geom_line(mapping=aes_string(x=xcol,y=ycol,group=group,color=group))
```

### aes() と　aes_string()を両方使えるようにする
```
`+.uneval` <- function(a,b) {
    `class<-`(modifyList(a,b), "uneval")
}
```
[ここ](https://stackoverflow.com/questions/28777626/how-do-i-combine-aes-and-aes-string-options)にあった方法。
`aes()+aes_string()`とでようになる。



### 複数の列データを一つのグラフ上に表示する

データに，異なる線であることを判別できる列を作っておく。
気温変化データに(city,time,temerature)のデータ列があって，
都市(city) ごとに異なる線を描くには以下のようにする。

```
p<-data %>% arrange(city,time) %>%
	ggplot() %>%
	plot_line(aes_string(x=time,y=temperature,group=city,color=city))
print(p)
```


### 複数のtidyデータから作るグラフを同一グラフ上に表示

```
p<-ggplot(data1) +
	 geom_line(aes_string(x=time,y=temperature))
p2<-geom_line(data2, mapping=aes(x=time,y=humidity))
print(p1+p2)
```

### アニメーションを作る

**方法1:**
[gganimate](https://github.com/thomasp85/gganimate)を使う。

**方法2:**
[plotly](https://plot.ly/ggplot2/animations/)の関数`animation_opts()`を使う。


**参考URL**
- [plotly@RDocumentation](https://www.rdocumentation.org/packages/plotly/versions/4.8.0)
- [plotly for R](https://plotly-book.cpsievert.me/index.html)
- [animation_opts (plotly のアニメーション用オプション)](https://www.rdocumentation.org/packages/plotly/versions/4.8.0/topics/animation_opts)


## 関連リンク

- [Grammar of graphics with plotnine (Optional)](https://www.kaggle.com/residentmario/grammar-of-graphics-with-plotnine-optional)
	- plotnine (python版ggplot2)の解説


