---
title: docstring
weight: 50
---

関数のヘッダ部分に，コメント文形式でその関数の仕様(Docstring)を書いておくと`help()`で参照したり出来る。
書くべき内容についてはPEPで決められていて，[PEP 257 -- Docstring Conventions](https://www.python.org/dev/peps/pep-0257/)に詳細の説明がある。
以下は，このPEPのページからのメモ。

## One-line Docstring

- 何をするのかと，返り値の型を"."(ピリオド)で終わる文で書く。
- 英語の場合，動詞で始まる命令文の形式("Do this", "Return that")にする。
- docstringの**前後に空行は入れない**。


```
def function(x):
    """Do something difficult and return a list."""
    if something: print("hello")
    ...
```

以下のように，関数の定義をそのまま書き直すようなのはダメ。
```
def function(x):
    """function(x) -> list"""
    ...
```

## Multi-line Docstring

### 基本的な書き方

1. まず，one-line docstringと同様に1行の概要
    - 索引作成に使われる
    - コメント開始の"""に続けて，もしくは次の行に書くこと
2. 次に一行分の空行
3. その後詳しい説明

### 単独で動くプログラムのdocstringの内容

- `-h`をつけて実行したときや，引数が足りない時などに表示するusage(使い方)に相当する内容
- 役割(機能)，コマンドライン度の利用例，環境変数，扱うファイル情報
- 初めて使う人へのガイド
- 引数の説明

### モジュールやパッケージのdocstringの内容

- モジュールのdocstringでは，モジュール内のクラス，例外処理，関数などのそれぞれの概要を1行ずつ書く。各オブジェクト内のdocstringにある概要よりも短くすること。
- パッケージのdocstring(パッケージ内の`__init__.py`のdocstring)では，パッケージ内のモジュール，サブパッケージの概要を書く

### 関数やメソッドのdocstringの内容

- 処理内容の要約
- 引数，返り値，例外処理，その他の処理，呼び出しについての注意事項

### クラスのdocstringの内容

- 処理内容の要約
- ブリックメソッドとインスタンス変数のリスト
- 派生クラス(subclass)をつくるときに役に立つ情報
ります。クラスがサブクラス化されることを意図しており、サブクラスのための追加のインターフェイスを持っている場合、このインターフェイスは（docstringの中に）別途記載する必要があります。
- コンストラクタについては、`__init__`メソッドのdocstringで文書化
- 各メソッドについては、それぞれのdocstringによって文書化

### 派生クラス(subclass)のdocstringの内容

- スーパークラス(親クラス)との違い
- スーパークラスのどのメソッドを置き換えるか(override), 拡張するか(extend)を説明

### 具体例


具体的な書き方には，いくつかお流儀がある。
以下は，Googleスタイルでの例。Google Styleのいろいろな例は[Example Google Style Python Docstrings](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html)を参照。


```
def example_function(param1, param2):
    """Example function with types documented in the docstring.

    Args:
        param1 (int): The first parameter.
        param2 (int): The second parameter.

    Returns:
        int: Sum of param1 and param2.

    Examples:
        Examples should be written in doctest format, and should illustrate how
        to use the function.

        >>> example_function(4, 5)])
        9

    """
    return param1 + param2
```

## docstringを抽出してmarkdownに

ソースコード中のdocstringを抽出してmarkdownにするスクリプトがいろいろある。
どれが良いかは不明。。。

-[coldfix/doc2md](https://github.com/coldfix/doc2md)
- [krassowski/docstring-to-markdown](https://github.com/krassowski/docstring-to-markdown)


