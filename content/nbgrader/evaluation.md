---
title: 自動採点のTips
weight: 30
---

## 自動採点に使える関数例

- [nose](https://nose.readthedocs.io/en/latest/)
	- [nose.tools](https://nose.readthedocs.io/en/latest/testing_tools.html)
	- 以下の`unittest`の関数を概ね使えるみたい。ただし，関数名は`assertEqual`を`assert_equal`と，[PEP8](https://www.python.org/dev/peps/pep-0008/#function-names)準拠に変える。
- [unittest --- ユニットテストフレームワーク](https://docs.python.org/ja/3/library/unittest.html)
- [numpyより](https://docs.scipy.org/doc/numpy-1.14.1/reference/routines.testing.html)
- 数値の比較には，`isequal()`や`==`より`math.isclose()`の方が有効数字を決めて比較できるので便利([参考](https://github.com/LDSSA/wiki/wiki/Using-nbgrader-for-Exercise-Notebooks))
- [文字列中に存在する必要のない空白を削除する方法
](https://qiita.com/ntakuya/items/1153940f3e9c6282b4c5)

## 小技のメモ
### 関数中に，指定した特定の関数を使われているかを確認する

- 方法1: [Checking whether a specific function has been used](https://nbgrader.readthedocs.io/en/stable/user_guide/autograding_resources.html#checking-how-functions-were-called-or-not-called-with-mocking)
	- 組み込み関数が利用されているか確認する場合，この方法ではエラーが出る
- 方法2: [Checking how functions were called or not called with mocking](https://nbgrader.readthedocs.io/en/stable/user_guide/autograding_resources.html#checking-how-functions-were-called-or-not-called-with-mocking)

以下は，`unittest`の`patch`を利用して，関数`show_list`に`enumerate()`が利用されているかを確認する例。`some_args`と`some_args_for_enumerate`は，`show_list()`および，`show_list`内の`enumerate()`に渡される引数。

```python
from unittest.mock import patch
with patch('__main__.enumerate') as mock_enumerate:
    show_list(some_args)

mock_enumerate.assert_called_once_with(some_args_for_enumerate)
```

### 関数中の`print()`の出力を評価する

1. `print`文が1回だけ実行される場合
	- [mockオブジェクトを使う](https://nbgrader.readthedocs.io/en/stable/user_guide/autograding_resources.html#checking-how-functions-were-called-or-not-called-with-mocking)
2. `print`文`が複数回実行される場合([参考](https://stackoverflow.com/questions/2654834/capturing-stdout-within-the-same-process-in-python/3113913#3113913))

```python
import sys, io, contextlib

class Data(object):
	pass

@contextlib.contextmanager
def capture_stdout():
	old = sys.stdout
	capturer = io.StringIO()
	data = Data()
	try:
		sys.stdout = capturer
		yield data
	finally:
		sys.stdout = old
		data.result = capturer.getvalue()
```
ここまでが宣言部分。以下が利用方法。

```python
with capture_stdout() as capture:
	print("hello")   # ここに，監視する関数を列挙する。
	print("goodbye")

res=capture.result
ans="hello\n\
goodbye"
assert res.replace(" ","").strip()==ans.replace(" ","").strip() # usually better to remove spaces, and spaces/tabs/\n at the end
```

### 乱数を使った関数の動作を確認する

関数の返り値が乱数を使って生成される場合，正解か否かの判定は難しいことも多いが，少なくとも乱数で生成されているかどうかの確認は簡単にできる。

```python
result=[rnd_func() for i in range(20)]
result2=[rnd_func() for i in range(20)]
assert_not_equal(result,result2)
```
さらに，平均値や分散, max, minを使った色々な判定も可能

