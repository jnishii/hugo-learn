---
title: 環境構築(pyenv/anaconda)
weight: 11
---

pyenv/anaconda を使って Mac/Linux上に python 環境を作る方法です。

## 準備: pyenv のインストール

[このページ](./install-pyenv.md)を見てpyenvを導入しましょう。

## Anacondaをインストール

1. インストール可能なanacondaのバージョンチェック
```
$ pyenv install -l | grep anaconda
```
インストールできるバージョンがずらずら出てくるので，どれにするか選ぶ
(希望がなければとりあえず最新で)

2. anaconda のインストール
```
$ pyenv install anaconda3-5.2.0 # anaconda3-5.2.0 の python  は version 3.6.5
$ pyenv rehash
$ pyenv global anaconda3-5.2.0 # anaconda3-5.2.0 を利用するための設定
$ conda update conda                    # パッケージのアップデート
```
pythonのモジュールは一般に`pip`コマンドで管理するが，anaconda 環境の python モジュールは`conda`で管理する。(`conda` の使い方
は下の方にメモ書きあり。)

3. 無事インストールできたかを確認する
```
$ pyenv versions
	system
* anaconda3-5.2.0 (set by /usr/local/var/pyenv/version)
$ which python
  /Users/jun/.pyenv/shims/python
$ python --version
Python 3.6.5 :: Anaconda 5.3.0 (x86_64)
```

## pythonの複数バージョンを管理する方法

### 方法1: anaconda上に複数バージョンをインストールする(おすすめ)

anacondaでpython 3 を使えるようにした環境で，さらにpython 2.7の仮想環境も構築したくなったら以下のようにインストールする。

- 仮想環境の構築
```
$ conda create -n py27 python=2.7 anaconda
```
これで，python 2.7の仮想環境がインストールされて，その仮想環境名が`py27`になる。

- インストールされている仮想環境の確認は
```
$ conda info -e
py27		~/.pyenv/versions/anaconda-3-2.5.0/envs/py27
root	* ~/.pyenv/versions/anaconda-3-2.5.0
```
- 仮想環境の切り替え
```
$ source activate py27   <= py27にする
$ source deactivate      <= 仮想環境から出る
```
ただし，このactivateでターミナルが落ちるときには以下のように`activate`をフルパスで指定する。
```
$ source ${PYENV_ROOT}/versions/anaconda3-5.1.0/bin/activate
```
anacondaのバージョンは，インストールされているものに合わせて修正する。
面倒なときにはaliasを設定しておく。
```
$ echo 'alias activate=source ${PYENV_ROOT}/versions/anaconda3-5.1.0/bin/activate" >> ~/.bash_profile'
```
- 仮想環境の削除
```
$ conda remove -n py27 --all
```

### 方法2: 複数のバージョンのanacondaをインストールする

以下のようにanacondaの複数のバージョンをインストールして，必要に応じて切り替えることができる。
```
$ pyenv install anaconda3-2.5.0 # anaconda3-2.5.0 の python  は version 3.5.1
$ pyenv install anaconda3-5.2.0 # anaconda3-5.2.0 の python  は version 3.6.5
$ pyenv rehash
$ pyenv global anaconda3-5.1.0  # デフォルトのanaconda3のバージョンを選択
$ conda update conda            # パッケージのアップデート
$ pyenv versions                # 確認
	system
* anaconda3-5.2.0 (set by /usr/local/var/pyenv/version)
	anaconda3-2.5.0
$ python --version
Python 3.6.5 :: Anaconda 5.2.0 (x86_64)
```

## conda の使い方
`conda` は anaconda に入っている python のモジュールを管理するツール。

- `conda info -e` : デフォルトの python の環境を表示
- `conda list` : インストールされているモジュール一覧
- `conda search <module>` : 利用できるモジュールのバージョン情報
- `conda install <module>` : モジュールのインストール
- `conda update conda` : conda 本体の更新
- `conda update --all` : パッケージ一式の更新


## 各種モジュールのインストール

<!--
- OpenCV2
```
$ conda install -c menpo opencv
```
-->
- [dfply](https://github.com/kieferk/dfply) : Rのdplyrと同様のデータフレーム操作をパイプで行えるようにするモジュール
```
pip install dfply
```
	- [dplyr使いのためのpandas dfplyすごい編](https://qiita.com/T_Shinomiya/items/c039451869382e0790f4)
- OpenCV3
```
$ conda install opencv
```
ちなみに，インストールするopencvのバージョンを変えたいときは，以下のコマンドでモジュール名を検索するとよい。
```
$ conda search -c conda-forge --spec `opencv=3*`
```
- [Chainer](https://github.com/chainer/chainer)
```
$ conda install chainer
```
- [ChainerCV](https://github.com/chainer/chainercv)はChainerによる画像処理モジュール
```
$ pip install chainercv==0.7
```
chainer のバージョンが3.4.0の場合は chainercv が 0.8だとエラーが出て，0.7にしないと動かなかった。

## とりあえず使う

pythonを起動して使う方法はいろいろありますが。。。
- [Spyder (Python用IDEの一つ)](https://pythonhosted.org/spyder/)を使う
```
$ spyder &
```
- Spyderのコンソールを使う
```
$ jupyter qtconsole &
```
- [jupyter notebook](http://jupyter.org/)で使う
```
$ jupyter notebook
```
jupyter notebookの解説は[こちらのページ](../jupyter)にも少しあります。

## アンインストール

```
$ conda install anaconda-clean
$ anaconda-clean
$ pyenv uninstall anaconda-<versions>
$ brew uninstall pyenv
```
