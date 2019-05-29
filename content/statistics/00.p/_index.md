---
title: p値は使わない
---

## ASAの所見

ASA(アメリカ統計学会)は2016年に[p値についてのASAの所見](http://www.tandfonline.com/doi/abs/10.1080/00031305.2016.1154108)を発表。
冒頭に，2014年2月にG. CobbがASAのフォーラムに投稿した内容として以下を紹介。

> Q: Why do so many people still use p = 0.05? (どうしてみんな，未だにp=0.05を使うの?)

> A: Because that's what they were taught in college or grad school. (だってみんなそう習ったからね)


このASAの所見には，p値の使用上の注意を説明した上で，他の統計値や統計手法も利用して効果の大きさや仮説の妥当性の検討を行なうべきと説明。

出典
- [Ronald L. Wasserstein and Nicole A. Lazar, "The ASA’s statement on p-values: context, process, and purpose", The American Statistician, 2016](http://www.tandfonline.com/doi/abs/10.1080/00031305.2016.1154108)
160603-ASA/item.md (END)


## p値のダンス

<!--テストの平均点がある二群で異なるかを探るには，検定計算によってp値を求めて，優位水準より大きいか否かに基づいて有意差の有無を議論するのが一昔前まで主流だった。
前述のようにp値による議論はもうやめて，効果量とその有効区間に基づく議論をしよう...という方向に世の中は変わりつつある。
Cumming (2014)などに詳しく書かれている。-->
2つの母集団からランダムに20個くらいのサンプルをとって検定を行うと，p値は試行ごとに大きく変わりうる。Cumming (2014)はこれを"p値のダンス"と呼んで紹介し，効果量とその有効区間に基づく方法を使うべきと説明している。
また，p値による議論だと有意差の有無が議論の焦点になってしまい，結局のところ比較している群間にどの程度の差があるのか，その値の信頼性はどうなのかといった議論がなくなってしまう。例えば二群の平均値にはほんのわずかの差しかなくても，サンプル数が多いと優位と判定され，優位差があることばかり過度に強調される場合がある(参考資料の[効果量，Cohen's d，検出力，検出限界](http://oku.edu.mie-u.ac.jp/~okumura/stat/effectsize.html)にわかりやすい例がある)。

参考資料

- [G. Cumming, "The New Statidtics: Why and How", Psychological Science, 25(1), 7-29, (2014)](http://pss.sagepub.com/content/early/2013/11/07/0956797613504966)
    - p値は使った議論の問題点は何か，効果量や信頼区間によりどのような新たな議論が可能かを詳しく解説。
- [効果量，Cohen's d，検出力，検出限界](http://oku.edu.mie-u.ac.jp/~okumura/stat/effectsize.html)
- [効果量メモ（効果サイズ，エフェクトサイズ，effect size）](http://researchmap.jp/jo0f4s8qj-32069/?lang=japanese)
	- 参考文献等紹介が詳しくて役に立つ
