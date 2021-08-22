---
title: Pandas
weight: 60
---

## Pandas関連のちょっとしたTips

### ファイルを読み込むとき，日付文字列をindexにする

列名`date`のデータに日付(YYYY-MM-DD)がある場合。

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

### 要素がある値以上であるセルの個数を数える。

0以上の値があるセルが各行にいくつあるか数える例
```python
concrete["result"] = concrete.gt(0).sum(axis=1)

```

### グループごとにある列の平均値を求め，もとのデータフレームの各行に追加する

データフレームの行数は変えず，各行に，該当する特徴(〇〇州在住)から得られる新たな特徴量(〇〇州在住平均年収)を追加する。
データの集約には"max","min","median","var","std","count"も使える。

```python

customer["AverageIncome"] = (
    customer.groupby("State")  # for each state
    ["Income"]                 # select the income
    .transform("mean")         # and compute its mean
)

customer[["State", "Income", "AverageIncome"]].head(10)
```

上記のように訓練データセットで作った特徴量を検証セットに流し込むこともできる。

```python
# Create splits
df_train = customer.sample(frac=0.5)
df_valid = customer.drop(df_train.index)

# Create the average claim amount by coverage type, on the training set
df_train["AverageClaim"] = df_train.groupby("Coverage")["ClaimAmount"].transform("mean")

# Merge the values into the validation set
df_valid = df_valid.merge(
    df_train[["Coverage", "AverageClaim"]].drop_duplicates(),
    on="Coverage",
    how="left",
)

df_valid[["Coverage", "AverageClaim"]].head(10)
```

- 参考URL[Creating Features (Kaggle)](https://www.kaggle.com/ryanholbrook/creating-features)

### 特定のデータ形式の列名の抽出

要素が文字列(object)である列の名前の抽出方法を2通り
```python
object_cols = [col for col in df.columns if df[col].dtype == "object"]
```
```python
cols_obj = train.select_dtypes('object').columns
```

`float`か`int`のいずれか列を抽出。

```python
cols_num = train.select_dtypes(include=['float','int']).columns
```

該当列のインデックス(0,1,..)を知りたいとき場合

```python
cols_num = train.columns.get_indexer(train.select_dtypes(include=['float','int']).columns)
```

### ある列の文字列を複数の列に分割する

データフレーム"members"の列`email`を'@'マークを区切り文字として2列に分割する例

```python
df[["ID", "domain"]] = (  # 分割結果を格納する
    members["email"]           # 列`email`を分割
    .str                         # 文字列に対する演算をする
    .split("@", expand=True)     # 空白で分割して複数列にする

)
```


### 各列にある異なる文字列要素の数

列名と，その列にある異なる文字列要素の数を辞書に格納する。
ついでに，出現頻度でソートする。

```python
object_cols = [col for col in df.columns if df[col].dtype == "object"]
object_nunique = list(map(lambda col: df[col].nunique(), object_cols))
d = dict(zip(object_cols, object_nunique))
sorted(d.items(), key=lambda x: x[1])
```

- 参考: [Exercise:Categorical Variables (Kaggle)](https://www.kaggle.com/cellish/exercise-categorical-variables/)


### データフレーム`df_B`の各列(type object)の要素が, `df_A`のsubsetか確認

```python
object_cols = [col for col in df_A.columns if df_A[col].dtype == "object"]
gool_cols = [col for col in object_cols if 
                   set(df_B[col]).issubset(set(df_A[col]))]
bad_cols = list(set(object_cols)-set(good_label_cols)) # some object is found only in df_B
        
print('all elements in df_B is subset of df_A:', common_cols)
print('\n some elements only in df_B`, bad_cols)
```

- 参考: [Exercise:Categorical Variables (Kaggle)](https://www.kaggle.com/cellish/exercise-categorical-variables/)
