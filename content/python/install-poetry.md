---
title: 環境構築(pyenv/poetry)
weight: 15
---

pyenv/poetry を使って Mac/Linux上に python 環境を作る方法です。
pyenvでpythonをインストールして，必要なパッケージはpoetryで導入します。
開発したプログラムやライブラリの動作環境を明確にできるので，
本格的にプログラム開発をしたい人におすすめの方法です。

Macでhomebrewを使う人も，Linuxの人も以下の手順でOKのはずです。

## 準備: pyenv のインストール

[このページ](./install-pyenv.md)を見てpyenvを導入する。

## Pythonをインストール

1. インストール可能なpythonのバージョンチェック
```
$ pyenv install -l 
```
インストールできるパッケージがずらずら出てくる。
ここではPythonのみをインスールすることにして，バージョン名として表示されていた`3.10.2` を選ぶ。

2. Python のインストール
```
$ pyenv install 3.10.2
$ pyenv rehash
$ pyenv global 3.10.2 # インストールしたPython 3.10.2 を利用するための設定
```

3. 無事インストールできたかを確認する
```
$ pyenv versions
	system
* 3.10.2 (set by /Users/jun/.pyenv/version)
$ which python
  /Users/jun/.pyenv/shims/python
$ python --version
Python 3.10.2
```

## Poetryのインストール

簡単な概要のみの説明です。
詳細は[poetry](https://python-poetry.org/docs/)を見てください。


```
curl -sSL https://install.python-poetry.org | python3 -
```

poetryはデフォルトでは`$HOME/.poetry/bin`にインストールされる。
PATH設定も`~/.profile`等に追加されるが，シェルによっては各自で対応が必要。

新しいターミナルを起動，もしくはPATH情報を読み込んで`poetry`を実行可能か確認。
```
$ poetry --version
```

## 初期化

### 新規プロジェクト作成

Pythonのプロジェクト(開発する一まとまりのライブラリやプログラム)の名前をつける。

```
poetry new <project name>
```

いくつかのファイルが生成される。 その中の`pyproject.toml`がインストールするライブラリの依存関係の一覧になる。

### すでにあるプロジェクトをpoetryに反映

ある程度の作成したプログラムをpoetryで管理するプロジェクトにする方法
```
cd <project directory>
poetry init
```

### 依存性情報の追加

`pyproject.toml`の`[tool.poetry.dependencies]`のセクションに，必要なライブラリとバージョン情報を追記する。
エディタで編集してもよいが，以下のコマンドを使うと`pyproject.toml`への登録とともにインストールもしてくれる。
```
poetry add <library name>
```

## いろいろな操作
### パッケージのインストール

```
poetry install
```

### パッケージのアップグレード

```
poetry update (--dry-run) # --dry-runはテストのみ行う
```

### Pythonプログラムの実行

```
poetry run python <python script>
```
もしくは
```
poetry shell
python <python script>
```

### ライブラリの削除

```
poetry remove <package name>
```

### Poetryで作成した仮想環境の削除

```
poetry env remove --all
```

## Poetryのアンインストール

```
$ python get-poetry.py --uninstall
$ POETRY_UNINSTALL=1 python get-poetry.py
```