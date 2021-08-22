---
title: 関数の引数
weight: 40
---

## 可変長の引数

Pythonでは関数の引数の個数を可変にできる。

### `*args`の利用例

個数が決まってない部分は習慣的に引数名`*args`としておく。


```python
def test(arg1, *args):
    print("arg1:", arg1)
    print("*kwargs:", *args)
    print("kwargs:", args)

test(1,2,3)
```
```
arg1: 1
*kwargs: 2 3
kwargs: (2, 3)
```
`test(1,2,3)`の第2,3引数を、関数内では`*args`にtupleとして参照できることがわかる。

逆に、タプルで複数の引数をまとめて渡すこともできる。
```python
def test(arg1, arg2, arg3):
    print("arg1:", arg1)
    print("arg2:", arg2)
    print("arg3:", arg3)

arg_list=[2,3]
test(1, *arg_list)
```
```
arg1: 1
arg2: 2
arg3: 3
```

これだけなら、引数の一つをtupleやlistにすれば同じ話になりそうだが、
呼び出した関数から、さらに他の関数を呼び出して、そこに色々な引数を指定
したいときには、とても便利に使える。
ただし、引数名もともに値をわたせた方が便利なので、具体的な例については
次の「`**kwargs`の利用例」の中で説明する。

### `**kwargs`の利用例


可変長の引数指定を引数名とともにしたいときには、以下のように`**kwargs`を使う。
`kwargs`はkeyworded argumentsの意味。他の名前にしても良いが、習慣的にこの名前が大抵使われる。

```python
def test(arg1, **kwargs):
    print("*kwargs:", *kwargs)
    print("kwargs:", kwargs)

test(arg1=1,arg2=2,arg3=3)
```
```
*kwargs: arg2 arg3
kwargs: {'arg2': 2, 'arg3': 3}
```

関数内では`kwargs`で参照するとdictとして参照できる。
逆に、dictで引数をまとめて渡すこともできる。

```python
def test(arg1, arg2, arg3):
    print("arg1:", arg1)
    print("arg2:", arg2)
    print("arg3:", arg3)

arg_list={"arg2":2, "arg3":3}
test(1, **arg_list)
```
```
arg1: 1
arg2: 2
arg3: 3
```

上の2つの組み合わせると、以下のように、関数内で呼び出す関数に色々な引数を渡せる。
```python
def test(df, *args)
    # ここで何かデータフレームdfの前処理をする
    df.plot(*args) # plotの引数を渡す

test(df, kind='bar', legend=True)
```

## 引数を関数にする

以下のように関数の引数に、関数を指定することができる。
ついでに可変引数`**kwargs`も利用して、色々な関数のグラフ化を簡単にしている。

```python
import matplotlib.pyplot as plt
import numpy as np

def plot_function(fn,**kwargs):
    x = np.linspace(0, 10, 100)
    y = fn(x)

    plt.plot(x, y, **kwargs)
    plt.show()

plot_function(fn=np.sin, color='green', marker='o', linestyle='dashed', linewidth=2, markersize=2)
```
![](images/function-plot)
