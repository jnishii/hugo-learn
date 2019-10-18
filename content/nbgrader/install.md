---
title: インストール
weight: 10
---

## nbviewerの思想

[The philosophy and the approach
](https://nbgrader.readthedocs.io/en/stable/user_guide/philosophy.html)の冒頭。David Marrがここに出てくるとは思わなかった。

> The nbgrader project evolved from my experiences as an instructor and a student. This excerpt from [David Marr’s book, Vision](https://www.dropbox.com/s/olrx40rzzvk1v1i/Marr%20-%20The%20Philosophy%20and%20the%20Approach.pdf?dl=0), is one of the core readings of the class that inspired the creation of nbgrader. ...
– Jess Hamrick, UC Berkeley


## インストール

### nbgraderのインストール

- [インストール方法](https://nbgrader.readthedocs.io/en/stable/user_guide/installation.html)

### nbgraderの有効化(マルチユーザ環境)

jupyterhubを使ったマルチユーザ環境(受講生も利用)でのおすすめ設定。

とりあえずすべての機能を有効化

```
# jupyter nbextension install --sys-prefix --py nbgrader --overwrite
# jupyter nbextension enable --sys-prefix --py nbgrader
# jupyter serverextension enable --sys-prefix --py nbgrader
```

受講生に対しては課題作成・管理機能は無効にしておく(課題取得や提出機能は有効に)。
nbgraderで用意するのがシングルコースのみなら，コースリストも無効に。

```
# jupyter nbextension disable --sys-prefix create_assignment/main
# jupyter nbextension disable --sys-prefix formgrader/main --section=tree
# jupyter serverextension disable --sys-prefix nbgrader.server_extensions.formgrader
# jupyter nbextension disable --sys-prefix course_list/main --section=tree
# jupyter serverextension disable --sys-prefix nbgrader.server_extensions.course_list

```

インストラクタは以下のシングルユーザ環境と同様に，各種機能を有効にしておく。

### nbgraderの有効化(シングルユーザ環境)

インストラクタのみがnbgraderを使う場合

```
$ jupyter nbextension install --user --py nbgrader --overwrite
$ jupyter nbextension enable --user --py nbgrader
$ jupyter serverextension enable --user --py nbgrader
```


## 試してみる

- [Quick Start](https://nbgrader.readthedocs.io/en/stable/user_guide/installation.html#quick-start)

以下の，nbtestの部分は適当なコース名。

```
$ nbgrader quickstart nbtest
...
    To get started, you can edit the source notebooks located in:
    
        /home/username/test/source/ps1
    
    Once you have edited them to your satisfaction, you can create
    the student version by running `nbgrader generate_assignment ps1` from the
    '/mnt/export1/at3/nishii/test' directory.
    
    For further details, please see the full nbgrader documentation at:
    
        https://nbgrader.readthedocs.io/en/stable/

```

`nbtest/`以下に，サンプルファイルができている。
```
$ find nbtest
nbtest
nbtest/source
nbtest/source/header.ipynb
nbtest/source/ps1
nbtest/source/ps1/problem1.ipynb
nbtest/source/ps1/problem2.ipynb
nbtest/source/ps1/jupyter.png
nbtest/nbgrader_config.py
```

サンプルは，[マニュアル](https://nbgrader.readthedocs.io/en/stable/user_guide/creating_and_grading_assignments.html)にも掲載されている。

## jupyterhub+nbgrader


### 参考
[Using nbgrader with JupyterHub](https://nbgrader.readthedocs.io/en/master/configuration/jupyterhub_config.html)を見ておくとよい。

`Quick Start`で生成される`nbgrader_config.py`に，以下のようにコースディレクトリを指定して，スタッフの`~/.jupyter/`以下においておく。

```
c = get_config()
c.CourseDirectory.root = '/home/your_account/nbtest'
```

各コース用の`nbgrader_config.py`は，各コースのトップディレクトリに置いておく。

### 課題シートを作ってみる

jupyter notebookのタブ"Formgrader"をクリックすると，課題シートをどんどん作れる。

### 困った点: jupyter notebookのタブ"Formgrader"をクリックしてもエラーが出る

そもそも`~/.jupyter/nbgrader_config.py`を参照してもらえない。
`/etc/jupyterhub/jupyterhub_config.py`の`default_url`の設定を変えたら解決。

```
#c.Spawner.default_url = '/lab' # デフォルト
c.Spawner.default_url = ''  # こちらにした
```
