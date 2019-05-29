---
title: 学習の種類と誤差関数
---


## 学習の種類と誤差関数(損失関数)

以下の説明で使う変数一覧
- $K$: 出力素子数
- $N$: 訓練データのサンプル数
- $\{(\boldsymbol{x}_n,\boldsymbol{d}_n)\}$ : 訓練データ
- $\boldsymbol{d}_n=(d_{n1},\ldots,d_{nK})$ : 訓練データの入力$\boldsymbol{x}_n$に対する望ましい出力
- $\boldsymbol{y}(\boldsymbol{x_n};\boldsymbol{w})=\boldsymbol{y}_n=(y_{n1},\ldots,y_{nK})$: 入力$\boldsymbol{x}_n$に対するネットワークの出力

## 回帰(regression)

**目的**: 滑らかな関数($\boldsymbol{y}=\boldsymbol{f}(\boldsymbol{x})$)を学習

**誤差関数**: **平均二乗誤差** (Kerasでの名称: mean_squared_error,mse)が一般的
$$
\displaystyle E(\boldsymbol{w})=\frac{1}{2}\sum_{n=1}^N ||\boldsymbol{d}_n-\boldsymbol{y}_n||^2
$$

## 多クラス分類

**目的**: 入力をKクラス($K\ge 3$)に分類する。(K=2の場合は後述)

**方法**:
- 出力層の素子数$K$は分類したいクラス数と同じにし，訓練データが第$k$クラスのときその教師データは
$[0,\ldots,0,1,0\ldots,0]$，と$k$番目の要素のみを1とする。
- ニューラルネットワークモデルの出力$\boldsymbol{y}$の各要素は，各クラスの出現(推定)確率に対応付ける。
- 出力素子からの各出力は0から1の範囲とし，総和は1になるように**softmax法**等で正規化する

**誤差関数**

**クロスエントロピー** (交差エントロピー, Kerasでの名称: categorical_crossentropy)が一般的
$$
\displaystyle E(\boldsymbol{w})=-\frac{1}{N}\sum_{n=1}^N\sum_{k=1}^K d_{nk}\log y_{nk}
$$

$N$個の訓練データに対する対数尤度$L(\boldsymbol{w})=\log P(data|model)$は
$$
\begin{align*}
L(\boldsymbol{w})
&=\log\prod_{n=1}^N\prod_{k=1}^Ky_k^{d_{nk}}(\boldsymbol{x_n};\boldsymbol{w})\\
&=\log\prod_{n=1}^N\prod_{k=1}^Ky_{nk}^{d_{nk}}\\
&=\sum_{n=1}^N\sum_{k=1}^Kd_{nk}\log y_{nk}
\end{align*}
$$
これを$N$で割って符号を反転したものがクロスエントロピーになる。

$d_{k}=1$なる訓練データに対してのみ($N=1$)，上式を計算すると$-\log y_k$になる。

## 二クラス分類

**目的**: 入力を2クラスに分類する

**方法**:
- 1出力とし，その出力$y\in[0,1]$の値が$1/2$より大きいか否かでクラス判定をする。

**誤差関数**

**二値交差エントロピー** (Kerasでの名称:binary_crossentropy, logloss)を使うことが多い。
考え方は多クラス分類と同じだが，出力$y$と$1-y$がそれぞれクラス1,2に属する確率を表すことを使って変形すると以下になる。

$$
E(\boldsymbol{w})=-\sum_n^N(d_n\log y_n+(1-d_n)\log(1-y_n))
$$

## Kerasで使える誤差関数

Kerasでは，学習において最小化したい関数をloss function，学習とは無関係にモデルの性能評価のために用意する関数をmetricと呼び，日本語マニュアルでは前者を誤差関数，後者を評価関数と訳している。

- [損失関数の利用方法(Keras)](https://keras.io/ja/losses/)
