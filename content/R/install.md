---
title: Package control
weight: 10
---

## Rのインストール(Mac)
```
brew install r rstudio
```

## パッケージ管理

以下はRのコンソール上で実行。
- パッケージのインストール
```
install.packages("package name")
install.packages("package 1", "package 2") # 複数列挙もできる
```
- パッケージのアンインストール
```
remove.packages("package name")
```
- パッケージのアップデート
```
update.packages()
```

- インストール済みパッケージの一覧
```
library()
```

- パッケージの読み込み
```
library("package name")
```
- パッケージのアンロード
```
detach("package name")
```

### リンク

- [swirl](http://swirlstats.com/students.html)
  - R上で動くインタラクティブ教材
  - [紹介記事](http://bcl.sci.yamaguchi-u.ac.jp/~jun/blog/180223-swirl)
