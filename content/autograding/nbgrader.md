---
title: nbgrader
weight: 1
---

Pythonのプログラムの自動採点システム[nbgrader](https://nbgrader.readthedocs.io/en/stable/index.html)

## nbviewerの思想

[The philosophy and the approach
](https://nbgrader.readthedocs.io/en/stable/user_guide/philosophy.html)の冒頭。David Marrがここに出てくるとは思わなかった。

```
The nbgrader project evolved from my experiences as an instructor and a student. This excerpt from [David Marr’s book, Vision](https://www.dropbox.com/s/olrx40rzzvk1v1i/Marr%20-%20The%20Philosophy%20and%20the%20Approach.pdf?dl=0), is one of the core readings of the class that inspired the creation of nbgrader. ...

– Jess Hamrick, UC Berkeley
```

## インストール

- [インストール方法](https://nbgrader.readthedocs.io/en/stable/user_guide/installation.html)

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
複数のコースを作るなら，symbolic linkを張って切り替えるのも一手。

```
c = get_config()
c.CourseDirectory.root = '/home/your_account/nbtest'
```

### いじる

jupyter notebookのタブ"Formgrader"をクリックすると，問題をどんどん作れる。

### 困った点: jupyter notebookのタブ"Formgrader"をクリックしてもエラーが出る

そもそも`~/.jupyter/nbgrader_config.py`を参照してもらえない。
`/etc/jupyterhub/jupyterhub_config.py`の`default_url`の設定を変えたら解決。

```
#c.Spawner.default_url = '/lab' # デフォルト
c.Spawner.default_url = ''  # こちらにした
```


## 宿題の作り方

### 作れるセル
詳しくは[ここ](https://nbgrader.readthedocs.io/en/stable/user_guide/creating_and_grading_assignments.html)

1. “Manually graded answer” cells
	- 人力採点用セル。回答入力用セルを1つのみ用意。
2. "Manually graded task” cells
	- 人力採点用セル。回答入力用セルを複数用意。
	- `=== BEGIN MARK SCHEME ===`, `=== END MARK SCHEME ===`で囲んだ部分は学生用ファイルには出力されない。(採点時とフィードバック時に表示される)
3. “Autograded answer” cells
	- 自動採点の解答部分を含むセル
	- 解答部分は，`BEGIN SOLUTION`と`END SOLUTION`で囲む。
4. “Autograder tests” cells
	- 自動採点のために実行する動作確認用命令文用セル
	- 実行時にエラーが起きなかったら得点。エラーが生じたら0点
	- 動作確認用命令文を隠したい時には，`### BEGIN HIDDEN TESTS`, `END HIDDEN TESTS`で囲む。

