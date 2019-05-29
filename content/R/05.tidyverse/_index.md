---
title: tidyverse
---

Rで表形式のデータ処理・解析をするための [tidyverse](https://www.tidyverse.org/)パッケージがとても良くできている。
Rを使うのに，別にtidyverseは使わなくても大抵のことはできるんだけど，Rの基本的なvectorとかmatrixとかarrayとかlapplyとかplotとかのお勉強はすっ飛ばして，さっさとtidyverseの世界に入った方が，可読性の高いスクリプトを早く書けるようになって良いのではと思う。

```
install.packages("tidyverse")
```
正確にはtidyverseは以下のパッケージをまとめたパッケージ集。

- ggplot2: グラフ描画パッケージ
- dplyr: データ操作パッケージ
- tidyr: tidy dataを作るためのパッケージ
- readr: データファイル読み込みパッケージ
- purrr: 繰り返し計算を行うためのツール
- tibble: tidyverseの世界で使うデータ形式。データフレームの一種
- stringr: 文字列操作ライブラリ
- forcats: ファクタ(因子)操作ライブラリ


tidyverseでのデータ解析の流れは以下の通り([R for Data Science: 9 Introduction](http://r4ds.had.co.nz/wrangle-intro.html))
。
1. データ取り込み
2. データをTidy(整然)にする
3. 変換, 可視化，モデル化を繰り返す
4. 出力


tidyverseの使い方の詳細は[tidyverseのホームページ](https://www.tidyverse.org/)か，以下の参考URLをどうぞ。


## 参考URL

- [R for Data Science](http://r4ds.had.co.nz/)
	- O'Reilly から出版されている本の全文。tidyverseの作者が書いた，tidyverse使ったデータ処理の入門書。要点が簡潔にまとまっており非常にわかりやすい
- [An Introduction to Statistical and Data Sciences via R](http://moderndive.com/index.html)
	- tidyverseを使った統計処理の入門

