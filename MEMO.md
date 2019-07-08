# メモ by Jun

## hugo-theme-learnのインストール
```
$ git submodule add https://github.com/matcornic/hugo-theme-learn.git themes/hugo-theme-learn/
```

## submodule-の削除

```
git submodule deinit -f themes/hugo-theme-learn
git rm -f themes/hugo-theme-learn
```

## highlight of code fence 

hugoデフォルトのhighlight機能は使わず[highlight.js](https://highlightjs.org/)を利用。

- styleを変えるには[css](https://github.com/highlightjs/highlight.js/tree/master/src/styles)を'static/css/highlight'にダウンロードし，'custom-header.html'で指定する。