---
title: 効果量
weight: 20
---

## 効果量の定義

独立な2群の平均値の差を議論するには Cohen's d もしくはHedges' g (unbiased Cohen's d)を使うことが多い。
いずれも，二群のサンプル平均の差がpooled standard deviation (各群のサンプル数を考慮した標準偏差の平均値)に対してどの程度かを表す。
つまり，両群の標準偏差が等しい場合にd=1ならば，両群のサンプル平均の差がちょうど標準偏差に等しいことになる。

これらの量の定義式が文献によって微妙に違うことがあってややこしいが，
Nakagawa and Cuthill (2007) のTable 1 によると以下の通り。

Cohen's d:

\\[d=\frac{\bar{x}_1-\bar{x}_2}{s}\\]

\\[s=\sqrt{\frac{(n_1-1)s_1^2+(n_2-1)s_2^2}{n_1+n_2-2}}\\]

Hedges' g (unbiased Cohen's d):

\\[g\simeq \left(1-\frac{3}{4(n_1+n_2-9)}\right)d\\]

補正項のあるHedges'gを用いることが多くの文献で推奨されている。
また，Cumming (2014)はこれを Cohen's d　と記した上で，その定義式もしくはその出典を明記することを勧めている。

参考文献

- [S. Nakagawa and I. C. Cuthill, "Effect size, confidence interval and statistical significance: a practical guide for biologists", Biol. Rev. 82(4), 591-605 (2007)](http://www.ncbi.nlm.nih.gov/pubmed/17944619)


## 効果量の信頼区間

[Nakagawa and Cuthill (2007)](http://www.ncbi.nlm.nih.gov/pubmed/17944619)の Table 3 の(17)式によると，Cohen's dの標準誤差は以下の通り。

\\[
\sigma_d=\sqrt{\left(\frac{n_1+n_2}{n_1n_2}+\frac{d^2}{2(n_1+n_2-2)}\right)}
\\]

95% Confidence intervalは以下になる。

\\[d\in[d-1.96\sigma_d,d+1.96\sigma_d]\\]

もし，効果量が d=0.6 [0.3,0.9] ならば信頼区間がd=0(平均値の差がなし)を含まないので，有意水準5%で有意差がありといえる。
ただし，はじめの方にも触れたように, [Cumming (2014)]((http://pss.sagepub.com/content/early/2013/11/07/0956797613504966))は，信頼区間を報告しても結局有意差の有無しか議論しないのならp値を使った議論となんら変わらないので, 効果量の大きさや信頼区間の値に基づく議論をきちんとするようにと説明している。


## 効果量の計算手段

検索するとエクセルのマクロやらいろいろありますが...

### ESCI

- [ESCI(Exploratory Software for Confidence Intervals)](http://www.latrobe.edu.au/psychology/research/research-areas/cognitive-and-developmental-psychology/esci/understanding-the-new-statistics)
	- Cummingが公開しているエクセルシート
	- Cummingの著書にあるいろんな計算をできるようになっていて，著書を持っていなくても面白い
	- ただ，自分のデータの解析には使いにくい(使い方をきちんとわかっていないだけかもしれないが)

### Rで効果量の計算

#### パッケージ`compute.es`を使う

```R
install.packages("compute.es", dependencies = TRUE) # 初めて使うときのみ
library(compute.es)
mes(mean1, mean2, sd1, sd2, n1, n2,
level=95, cer=0.2, dig=2, verbose=TRUE, id=NULL, data=NULL)
```

関数mesで出力される値

- Cohen's d, Hedges's g は上記の定義式通り
\\[d=\frac{\bar{x}_1-\bar{x}_2}{s}\\]
\\[s=\sqrt{\frac{(n_1-1)s_1^2+(n_2-1)s_2^2}{n_1+n_2-2}}\\]

- Cohen's dの分散として，次式の値が表示されている
\\[\sigma_d^2=
	\left(\frac{n_1+n_2}{n_1n_2}+\frac{d^2}{2(n_1+n_2)}\right)\\]
- Cohen's dのCIはどうも計算が合わない(少なくともCIは\[1.96\sigma_d\]より大きな値になっている。
- Hedges's g の分散やCIの計算方法も不明


#### バッケージ`effsize`の関数`cohen.d`を使う

```
install.packages("effsize")
```

Cohen'd と Hedges' g のいずれについても計算方法は不明で，上記`compute.es`の関数`mes`よりも少しだけ大きい値が出力される。CIは大幅に大きい値になる。


## おまけ

「新しい検定方法」についてのCummingの講義がYoutubeに公開されています。

-[The New Statistics: Confidence Intervals, NHST, and p Values (Workshop Part 1)](https://www.youtube.com/watch?v=iJ4kqk3V8jQ)
-ほかにもいろいろ
[The New Statistics: Research Integrity & the New Statistics (Workshop Part 2)](https://www.youtube.com/watch?v=wb0rnZBlcRg)
- ["Cumming" "new statistics" でYoutubeを検索](https://www.youtube.com/results?search_query=Cumming+new+statistics)
