---
title: 自動採点のTips
weight: 30
---

## 自動採点の書式

nbgraderの`Autograder tests`セルにユニットテストを書くだけ。
関数`func(x=3)`の返り値が1である場合に正解とするなら，以下のように書く。

```
from nose.tools import eq_
eq_(func(x=3),1)
```

これを実行したとき，`func(x=3)`の返り値が不適切なときにエラーが出る。


## 自動採点に使えるメソッド

以下のメソッドのほとんどはエラーが出た時のメッセージ`msg="..."`を引数に追加できる。
`msg`を追加できない場合は後述のようにtryとexceptを使うと良い。

### 一般

メソッド | alias | 
------- | ----- | --------
`assert_true(x)`||bool(x) is True
`assert_false(x)`||bool(x) is False
`assert_is(a, b)`||a is b
`assert_is_not(a, b)`||a is not b
`assert_is_none(x)`||x is None
`assert_is_not_none(x)`||x is not None
`assert_is_instance(a, b)`||isinstance(a, b)
`assert_not_is_instance(a, b)`||not isinstance(a, b)


### 数値(int, float)の比較

メソッド | alias | 
------- | ----- | --------
`assert <expr>` | `ok_(<expr>)`|
`assert_equal(a,b)`| `eq_(a,b)`|a == b
`assert_not_equal(a, b)`||a != b
`assert_almost_equal(a,b)`||round(a-b, 7) == 0
`assert_greater(a, b)`||a > b
`assert_greater_equal(a, b)`||a >= b
`assert_less(a, b)`||a < b
`assert_less_equal(a, b)`||a <= b


### sequence(setなど)に対する判定

setの要素には順番が定義されないので，`assert_equal()`での判定は不適切。
例えば以下の関数がある。

メソッド | alias | 
------- | ----- | --------
`assert_in(a, b)`||a in b
`assert_not_in(a, b)`||a not in b
`assert_count_equal(a, b)`||a and b have the same elements in the same number, regardless of their order.


### リストに対する判定

リスト同士(list,np.array同士も含む)の比較には，[numpy.testing](https://docs.scipy.org/doc/numpy-1.14.1/reference/routines.testing.html)の`nt.assert_array_equal`を使うと良い。

リスト要素を持つリストが，あるリスト要素を含むか(順不同)を確認したいときには以下のような関数を定義使うとよい。
```
def _assert_array_involve(l, ans, msg=""):
    stat=False
    for i in l:
        if np.array_equal(ans,i):
            stat=True 
    if stat==False:
        raise ValueError(msg)
```

### dictに対する判定

[Python unittest - asserting dictionary with lists](https://stackoverflow.com/questions/14491164/python-unittest-asserting-dictionary-with-lists)にのっている以下の方法を使う。dictの要素がいろいろな形式のものに対応できる。
```
assert all( (k,v) in source_dict.items()
            for (k,v) in dest_dict.items() )
```


### 文字列に対する判定

メソッド | alias | 
------- | ----- | --------
`assert_regex(s, r)`||r.search(s)
`assert_not_regex(s, r)`||not r.search(s)

### 呼び出し
以下のように必要なものだけ`import`して使っている。

```
from nose.tools import eq_
from nose.tools import ok_
from nose.tools import assert_in
from nose.tools import assert_equal
from nose.tools import assert_not_equal
```

### 他のメソッド
利用できるメソッドは他にも色々ある。

- [nose](https://nose.readthedocs.io/en/latest/)
	- [nose.tools](https://nose.readthedocs.io/en/latest/testing_tools.html)
	- 以下の`unittest`の関数を概ね使えるみたい。ただし，関数名は`assertEqual`を`assert_equal`と，[PEP8](https://www.python.org/dev/peps/pep-0008/#function-names)準拠に変える。
- [unittest --- ユニットテストフレームワーク](https://docs.python.org/ja/3/library/unittest.html)
- [numpy.testing](https://docs.scipy.org/doc/numpy-1.14.1/reference/routines.testing.html)
	- numpy.testingには`assert_array_not_equal`など，`not`に対する判定ルーチンがない。必要な時には`numpy.testing.assert_raises`を使う。([情報源](https://stackoverflow.com/questions/38506044/numpy-testing-assert-array-not-equal))
- [math(python標準関数)](https://docs.python.org/3/library/math.html)
	- `math.isclose()`,`math.isfinite(x)`,`math.isinf(x)`, `math.isnan(x)`
	- 数値の比較には，`isequal()`や`==`より`math.isclose()`の方が有効数字を決めて比較できるので便利([参考](https://github.com/LDSSA/wiki/wiki/Using-nbgrader-for-Exercise-Notebooks))
- [文字列中に存在する必要のない空白を削除する方法
](https://qiita.com/ntakuya/items/1153940f3e9c6282b4c5)
- [jhamrick/plotchecker](https://github.com/jhamrick/plotchecker)
	- matplotlibの評価

## 小技のメモ
### 関数中に，指定した特定の関数が使われているかを確認する

- 方法1: [Checking whether a specific function has been used](https://nbgrader.readthedocs.io/en/stable/user_guide/autograding_resources.html#checking-how-functions-were-called-or-not-called-with-mocking)
	- 組み込み関数が利用されているか確認する場合，この方法ではエラーが出る
- 方法2: [Checking how functions were called or not called with mocking](https://nbgrader.readthedocs.io/en/stable/user_guide/autograding_resources.html#checking-how-functions-were-called-or-not-called-with-mocking)

以下は，`unittest`の`patch`を利用して，関数`show_list`に`enumerate()`が利用されているかを確認する例。`some_args`と`some_args_for_enumerate`は，`show_list()`および，`show_list`内の`enumerate()`に渡される引数。

```
from unittest.mock import patch
with patch('__main__.enumerate') as mock_enumerate:
    show_list(some_args)

mock_enumerate.assert_called_once_with(some_args_for_enumerate)
```

### 関数中の`print()`の出力を評価する

1. `print`文が1回だけ実行される場合
	- [mockオブジェクトを使う](https://nbgrader.readthedocs.io/en/stable/user_guide/autograding_resources.html#checking-how-functions-were-called-or-not-called-with-mocking)
2. `print`文`が複数回実行される場合([参考](https://stackoverflow.com/questions/2654834/capturing-stdout-within-the-same-process-in-python/3113913#3113913))

```
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

```
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

```
result=[rnd_func() for i in range(20)]
result2=[rnd_func() for i in range(20)]
assert_not_equal(result,result2)
```
さらに，平均値や分散, max, minを使った色々な判定も可能。
ランダムに"stone","paper","scissors"を発生させるような関数なら，上記の確認後に，以下のような確認をするのも良い。

```
assert "stone" in result
assert "paper" in result
assert "scissors" in result
```

### エラーメッセージをtryを使って表示する方法

エラーメッセージは，unittest関数の引数"msg"でも指定できるが，
背景色をつけたり等，メッセージを分かりやすくするにはtry&exceptを使うと便利。

```
from nose.tools import eq_

try:
	eq_(func(x=3),1)
except:
	display('func(x=3)の返り値は1でないといけません')
	raise
```
上記の`display()`で表示される内容を，もっと目立たせるためには，以下のようにエラー
メッセージ表示用の関数を作ると良い。

```
from IPython.display import HTML
from nose.tools import eq_

def _alert(msg):
        display(HTML('<div class="alert alert-danger">{msg}</div>'.format(msg=msg)))

try:
	eq_(func(x=3),1)
except:
	_alert('func(x=3)の返り値は1でないといけません')
	raise
```

## 注意点

採点対象になっている関数が，その後のセルの評価に影響するときは要注意。評価時には受講生の内容に全て置き換わるので，受講生に不適切に定義された関数がその後の評価を不適切なものにしてしまうことがある。

## おまけ

- [jharmrick/nbgrader-demo](https://github.com/jhamrick/nbgrader-demo)
	- jupyter notebook/nbgraderを使うための，学生ガイダンス用notebookなどがある。
- [bootstrap-theme.css](https://github.com/jupyter/nbgrader/blob/master/nbgrader/server_extensions/formgrader/static/components/bootstrap/css/bootstrap-theme.css)
	- nbgraderのcss
	- 以下の[alert class](https://getbootstrap.com/docs/4.0/components/alerts/)を使うと，Markdownセルの背景に色を付けることもできる。
		- `<div class="alert alert-success">`緑色
		- `<div class="alert alert-info">` 青色
		- `<div class="alert alert-warning">` 黄色
		- `<div class="alert alert-danger">` 赤色
- 自動採点のときにjupyter notebookの実行は途中のセルまでで停止する方法
	- 停止したいセルに以下を入力([情報源](https://stackoverflow.com/questions/40554446/how-to-stop-execution-of-all-cells-in-jupyter-notebook))

```
raise SystemExit("Stop right here!")
```

