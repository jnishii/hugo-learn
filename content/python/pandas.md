---
title: Pandas
published: false
weight: 60
---

## Pandas関連のちょっとしたTips

### 付文字列を含むファイルを読み込むとき，日付文字列をindexにする

列名`date`のデータに日付(YYYY-MM-DD)がある場合の例。

```python
df = pd.read_csv('sample_date.csv',
                index_col='date', parse_dates=True)
```

日付形式の修正が必要なときは`pd_to_datetime()`を使う。
以下は'YYYY年MM月DD日'の形式のデータを標準形式にする例。
```python
df = pd.read_csv('sample_date.csv',
                index_col='date', parse_dates=True,
                date_parser=lambda x: pd.to_datetime(x, format='%Y年%m月%d日'))
                )
```

- 参考: [pandas.DataFrame, Seriesを時系列データとして処理](https://note.nkmk.me/python-pandas-time-series-datetimeindex/)

### 列ごとの欠損値の数

```python
print(df.isnull().sum(axis=0)) # 行ごとの場合 axis=1
```

### 各列にある異なる文字列要素の数

列名と，その列にある異なる文字列要素をを辞書に格納する。
ついでに，出現頻度でソートする。

```python
object_cols = [col for col in df.columns if df[col].dtype == "object"]
object_nunique = list(map(lambda col: df[col].nunique(), object_cols))
d = dict(zip(object_cols, object_nunique))
sorted(d.items(), key=lambda x: x[1])
```

- 参考: [Exercise:Categorical Variables (Kaggle)](https://www.kaggle.com/cellish/exercise-categorical-variables/)

### データフレーム`df_A`の各列(type object)の要素が, `df_B`の対応する列に存在するか確認

```python
object_cols = [col for col in df_A.columns if df_A[col].dtype == "object"]
gool_cols = [col for col in object_cols if 
                   set(df_B[col]).issubset(set(df_A[col]))]
bad_cols = list(set(object_cols)-set(good_label_cols)) # some object is found only in df_B
        
print('common strings:', common_cols)
print('\n involve elements only in df_B`, bad_cols)
```

- 参考: [Exercise:Categorical Variables (Kaggle)](https://www.kaggle.com/cellish/exercise-categorical-variables/)
