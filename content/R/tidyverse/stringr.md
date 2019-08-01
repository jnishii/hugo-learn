---
title: stringr (文字列処理)
weight: 70
---

[stringr](https://stringr.tidyverse.org/)は，`paste()`の代わりに[str_c()](https://stringr.tidyverse.org/reference/str_c.html), `sprintf()`のかわりに[str_glue()](https://stringr.tidyverse.org/reference/str_glue.html)など，Rにもともとある文字列処理関数群を置き換えるもの。
関数名の見直し(`str_*`になってる)やマルチバイト文字への対応等の改善がされている。
文字列の加工の他，正規表現もバリバリ使える。


## 準備
```
library("stringr")
```

## 情報源
- [stringr](https://stringr.tidyverse.org/): このページにチートシートがあるので，これを見るとだいたい分かる。
