---
title: plotly
weight: 70
---

[plotly](https://plotly.com/)は，Pythonでインタラクティブ・プロットを簡単に作れるライブラリの一つ。以下は折れ線グラフの作り方の説明。

まずは基本モジュール読み込み。


```python
import pandas as pd
import datetime
import warnings
warnings.filterwarnings('ignore')
```

jupyter notebookでplotlyの出力をファイル保存すると，plotlyのグラフがjupyter上に表示されなくなることがある。そのときは以下を実行する。


```python
from plotly.offline import init_notebook_mode
init_notebook_mode(connected = True)
```

## 読み込むデータ形式

データは[Altair](../Altair)と同様に，以下の[データサンプル](https://altair-viz.github.io/user_guide/data.html)のようなlong formatにする。


```python
from vega_datasets import data

source = data.stocks()
display(source.head())
```

## とりあえずグラフ化

たった数行(実質1行)で出来上がり。

- マウスオーバでの情報表示もされる。
- マウスでグラフの一部を選択したら，ただちに拡大もできる。
- マウスドラッグで表示領域の変更もできる。

すばらしい。

情報源
- [Line Charts in Python
](https://plotly.com/python/line-charts/)


```python
import plotly.express as px

fig = px.line(source, x="date", y="price",
              color="symbol", title='stock price chart')
fig.show()
# fig.write_html("plotly.html") # htmlファイルにしたいとき
```

{{<include "images/plotly.html">}}

## グラフサイズの変更

グラフサイズはブラウザの横幅に応じて自動で調整されるが，以下のように決め打ち(`fig.update_layout()`)も出来る。
また，マウスオーバで表示されるテキスト枠のタイトルも設定(`hover_name`)できる。


```python
fig = px.line(source, x="date", y="price",
              color="symbol", title='stock price chart', hover_name="symbol")
fig.update_layout(
    autosize=False,
    width=600,
    height=400)
fig.show()
# fig.write_html("plotly2.html") # htmlファイルにしたいとき
```

{{<include "images/plotly2.html">}}

## スタイル変更

グラフの配色等のスタイルもいろいろある。
こちらは`plotly_white`。


```python
fig.update_layout(template="plotly_white")
# fig.write_html("plotly_white.html") # htmlファイルにしたいとき
```

{{<include "images/plotly_white.html">}}

こちらは`plotly_dark`


```python
fig.update_layout(template="plotly_dark")
# fig.write_html("plotly_dark.html") # # htmlファイルにしたいとき
```

{{<include "images/plotly_dark.html">}}

[Theming and templates in Python](https://plotly.com/python/templates/)を見ると他にもいくつかある。

## jupyter で作ったファイルを静的ジェネレータhugoでweb化する方法

jupyter 上で plotly グラフを作り，md形式でファイルで出力してhugoでhtml化すると，plotlyのグラフは表示されない。
そこで以下のように自動化した。

### 事前準備

hugoで，markdownにファイルを挿入するための以下のショートコードを作って，``layouts/shortcoes/include.html`としておく。
これで，hugoでwebページ化するときにhtmlやmd形式のファイルを挿入できる。

```
{{ $base_path := $.Page.Dir }}
{{ $file := .Get 0  }}
{{ $file_path := printf "content/%s%s" $base_path $file }}

{{ if strings.HasSuffix $file ".html" }}
    {{  $file_path  | readFile  | safeHTML }}
{{ else if strings.HasSuffix $file ".md" }}
    {{  $file_path  | readFile  | markdownify  }}
{{ end }}
```

### jupyter形式のファイルの変換

1. jupyter 上では`fig.write_html("filename.html")`で，plotlyのグラフをhtml化する。
2. plotlyのグラフ生成をしたセルのすぐ下に，markdown cellを作って 

{{&lt;include "filename.html"&gt;}} 
  


と書いておく。ファイル名は，前のセルで生成したグラフのhtmlファイル名にする。
3. jupyter上で，出力は全てクリアしてからmd形式でエクスポート。このファイルと，plotlyのhtml化したファイルをhugoに持っていけばOK。
