---
title: Jupyter Notebook
weight: 20
---

[Jupyter Notebook](https://jupyter.org/)は，PythonやR, Juliaなどのコードを書いたり実行したり，文章を書いたりするのに開発環境(Mathematicaのノートブックのようなもの)です。


anaconda/python をインストールしていれば，Jupyter Notebookももれなく使えます。
```
$ jupyter notebook
```


## 拡張機能のインストール

セルを畳んだりできるように[拡張機能(Jupyter notebook extensions)](https://jupyter-contrib-nbextensions.readthedocs.io/en/latest/)のインストールをする。

```
$ conda install -c conda-forge jupyter_contrib_nbextensions
$ conda install -c conda-forge jupyter_nbextensions_configurator
$ jupyter nbextension enable codefolding/main
$ jupyter nbextensions_configurator enable
```
<!-- $jupyter contrib nbextension install --symlink -->

## jupyter variants
- [jupyterlab](https://jupyterlab.readthedocs.io/en/stable/)
	- [Project jupyter](https://jupyter.org/) による jupyter notebookの後継版
	- 起動: `$ jupyter lab`
- [jupyter nteract](https://nteract.io/)
	- jupyter notebookの機能拡張版
	- インストール: `$ conda install nteract_on_jupyter`
	- 起動: `$ jupyter nteract`

<!--
- [hydrogen: jupyter on Atom]
	- [インストール](https://nteract.gitbooks.io/hydrogen/docs/Installation.html)
	```
	$ apm install hydrogen
	$ conda install ipykernel
	$ python -m ipykernel install --user
	```	
-->

## Magic command

jupyter notebookのセルに`%`や`%%`ではじまるコマンドを書くことで，いろいろな処理ができる。
(ただし，jupyterでRを使うときにはMagic commandは利用できない...みたい)


### `%run`: 外部コマンドの実行
```
In [2]: % run somscript.py
```

### `%timeit`: 実行時間を測る
```
In [3]: %timeit L=[n**3 for n in range(1000)]
```
```
In [4]: %%timeit
	L=[]
	for n in range(1000):
		L.append(n**3)
```

### `%paste`, `%cpaste`: ペースト
Jupyter上へのペーストは`%paste`か`%cpaste`を使う。

### `%%bash`: shell scriptの実行

```
In [1]: %%bash
       echo $PATH
```

## シェルコマンド

bashコマンドは`!`をコマンド名の頭につければjupyter notebook上で使える。変数への代入にも使える。
(ただし，こちらもjupyter labでは未対応...みたい)


### `%run`: 外部コマンドの実行
```
In [2]: % run somscript.py
```

### `%timeit`: 実行時間を測る
```
In [3]:
filelist=!ls
current=!pwd
!echo "hello"
```

以下でautomagicを有効にすれば，`!`は不要になる。
```
%automagic=True
```

## 各種設定

起動オプションは`jupyter notebook ―help`で表示される。
オプションを指定するための設定ファイルを作りたいときは，まず以下のコマンドで設定ファイルを生成する。
```
$ jupyter notebook --generate-config
```
これで，`~/.jupyter/jupyter_notebook_config.py`に設定ファイルができるので，必要に応じてこれをいじる。

### tokenの指定

jupyter notebookに接続するときに入力を要求されるtokenを，事前に設定ファイルに登録したり，起動オプションで指定したりできる。

- `~/.jupyter/jupyter_notebook_config.py`
```
c.NotebookApp.token = 'xxxxx'
```
- jupyter notebookの起動オプションでの指定
```
--NotebookApp.token='xxxxx'
```

### キーバインディングを emacs styleにする

[jupyter-emacskeys](https://github.com/rmcgibbo/jupyter-emacskeys)をインストール
```
$ pip install jupyter-emacskeys
```


## Tips

### Short Cut Key
コマンドモード(ESCを押す)で”h”を押すと一覧表示される


### 特定のセルを除いたシートを作る

1. 除きたいセルにタグ(例えば，`remove_cell`)をつける。タグは，View/Cell Toolbar/Tagsで入力可能に。
2. 以下でシートの変換
```
$ jupyter nbconvert nbconvert-example.ipynb --TagRemovePreprocessor.remove_cell_tags='{"remove_cell"}'
```

以下のように，入力や出力を消すための各種フィルタがある。
```
TagRemovePreprocessor.remove_input_tags
TagRemovePreprocessor.remove_single_output_tags
TagRemovePreprocessor.remove_all_outputs_tags
```

- 情報源: [How to hide one specific cell (input or output) in IPython Notebook?](https://stackoverflow.com/questions/31517194/how-to-hide-one-specific-cell-input-or-output-in-ipython-notebook)


### Rを Jupyter Notebookで使えるようにする

<!--**方法1:** Rに必要なパッケージをインストールする。-->

[Rはhomebrew等で事前にインストール](../../mac/brew#R)しておく。
Jupyter Notebook の起動前にRコンソールで以下を実行し，Jupyterに([R kernel](https://github.com/IRkernel/IRkernel))をインストールする。
```
$ r
> install.packages('devtools')
> devtools::install_github('IRkernel/IRkernel')
  # or devtools::install_local('IRkernel-master.tar.gz')
> IRkernel::installspec()  # to register the kernel in the current R installation
```

<!--
```R
$ R
> install.packages(c('repr', 'IRdisplay', 'evaluate', 'crayon', 'pbdZMQ', 'devtools', 'uuid', 'digest'))
> devtools::install_github('IRkernel/IRkernel')
> IRkernel::installspec()
```

**方法2:** anaconda上にRをインストールする
```
$ conda create -n r -c r r-irkernel
```
-->

### jupyter上でCodeの自動抽出

[jupytext](https://github.com/mwouts/jupytext)

- jupyterでの保存時に，Code部分のみのファイル`somename.py`が生成される
- Markdown部分の抽出も可能
- 生成された`somename.py`を修正すると，ipynbファイルの方にも反映される

### Markdown と jupyter notebook形式の変換

- [notedown](https://github.com/aaren/notedown)

### LaTeXコマンド

- Markdownセルで`$$`で囲めばOK
- nbextensionsで [LaTeX environments for Jupyter](https://jupyter-contrib-nbextensions.readthedocs.io/en/latest/nbextensions/latex_envs/README.html)を有効にすると，LaTeX用shortcutをいろいろ使える

### 英文コンテンツを日本語翻訳する

- [jupyter用のgoogle 翻訳モジュール](https://github.com/jfbercher/jupyter_nbTranslate)
- [jupyter notebookのgoogle翻訳ツール](https://github.com/devrt/nbtranslate)


### jupyter notebookのコンテンツをmarkdownで作りたい

- [notedown](https://github.com/aaren/notedown)

### gitでjupyter notebookのシートを管理する時に，merge/diff をするためのツール
- [nbdime](https://github.com/jupyter/nbdime)

git commit前に，シート内にある出力は全部消しておくと，厄介なことにはなりにくい。

- [Jupyter Notebookを出力を無視してgit管理する方法](https://qiita.com/ctyl/items/bbc04e0b0bd4557d54a6)

### コードブロックのクリア

jupyter notebook形式でテキストを作ったとき，テキストセルで作った説明文(問題文)は残して，
コードセルに入力した解答や出力を全部消したいことがあるので，以下のスクリプトを作った。
ついでに，highlighter extensionを使って挿入されたhighlight tagも消している。

- [nb_clear_codeblock.py](https://gist.github.com/jnishii/555c87a2219d35fb3f082e1e3a13c51e)

### コード実行にスライドバーを利用したい
- [ipywidgets](https://ipywidgets.readthedocs.io/en/latest/)
	- [voida](https://github.com/voila-dashboards/voila)で，web化もできる

### スライド対応にする

#### 方法1: メニュー「View/Cell Toolbar/Slideshow」を選択すると，各セルをスライドにするとかしないとか選択できる。
最後に以下でスライドモードで表示を行う。
```
$ jupyter nbconvert <file name>.ipynb --to slides --post serve
```

#### 方法2: [RISE](https://github.com/damianavila/RISE)

jupyter の拡張機能[RISE](https://github.com/damianavila/RISE)を使うとお手軽にスライド化できる。

```
$ conda install -c damianavila82 rise
```

jupyter notebook のメニューにスライド表示のボタンが出て，それをクリックすれば直ちにプレゼンを出来る。
プレゼン上でプログラムの実行もできる。
どのセルをスライドにするかは，方法1と同様にして選択する。

- カスタマイズ方法: [Customizing RISE](https://github.com/damianavila/RISE/blob/master/doc/customize.md)
- メタデータの編集方法: [ここ](https://github.com/damianavila/RISE/blob/master/doc/customize.md#notebook-metadata)

例えば，コンテンツがページからはみ出るときには，[scroll bar](https://github.com/damianavila/RISE/blob/master/doc/customize.md#enable-a-right-scroll-bar)をつけられる。以下はカスタマイズ例。"Edit→Edit Notebook Metadata"を選択して，以下を追加。

```
  "rise": {
    "enable_chalkboard": true,
    "height": 768,
    "scroll": true,
    "transition": "slide",
    "width": 1024
  },
```

#### 方法4: [nbpresent](https://github.com/Anaconda-Platform/nbpresent)

[nbpresent](https://github.com/Anaconda-Platform/nbpresent)にはスライド作成のいろいろな機能がある。
```
conda install -c conda-forge nbpresent
```

#### 方法5: GitHub上で

GitHubにJupyter notebookをおくと，[Jupyter Notebook Viewer](http://nbviewer.jupyter.org)で表示できる。プレゼン形式にも出来る。


### コンテンツをweb application化する

[Voila](https://github.com/voila-dashboards/voila)を使うと，ソースコードは隠して，markdown部分と出力のみ見せられる。
スライダーなどでinteractive widget化しておくと，スライダーを操作しながらデモをできる。

インストール
```
$ conda install -c conda-forge voila
$ pip install voila-gridstack  
```

使う
```
$ voila some.ipynb
```

### pdfを出力できるようにする

XeLaTeXをインスールしておくこと。

**方法1:**
texに変換してからpdfにする
```
jupyter nbconvert --to latex notebook_name.ipynb
```

**方法2:** 
jupyterのメニューからpdfを出力したいときは，`/usr/local/anaconda3/lib/python3.6/site-packages/nbconvert/templates/latex/base.tplx`を修正。

```
--- base.tplx.org   2019-12-20 11:30:09.881902845 +0900
+++ base.tplx   2019-12-20 11:32:55.112929136 +0900
@@ -21,6 +21,10 @@
     \else
        \usepackage{fontspec}
     \fi
+    \usepackage{xeCJK}
+    \setCJKmainfont[BoldFont=IPAexGothic]{IPAexMincho}
+    \setCJKsansfont{IPAexGothic}
+    \setCJKmonofont{IPAGothic}

     % Basic figure setup, for now with no caption control since it's done
     % automatically by Pandoc (which extracts ![](path) syntax from Markdown).
```

**問題点**

Markdownに`!()[]`を使って埋め込んだ画像は出力されるが，htmlタグ`"<img src="images/imagefile.png">`で埋め込んだ画像は消えてなくなる。画像サイズを変えるにはhtmlタグを使わないといけないので困る。

- **解決法1**: notebookをmarkdown形式にして，markdownのビューア等でpdfにする
- **解決法2**: htmlタグをlatexコマンドに変える前処理をしてから変換する。


## トラブル
### Q. セルの分割(Ctr-shift-"minus")を実行できない
日本語キーボードの問題らしい。
以下のサイトに書いてあるようににショートカット設定をする。

[Jupyter Notebook Ctrl+Shift+- (splitting cell) does not work](https://stackoverflow.com/questions/49485753/jupyter-notebook-ctrlshift-splitting-cell-does-not-work)

## いろいろ


- [nbviewer-app](https://github.com/tuxu/nbviewer-app): jupyterのファイルのビューア
```
$ brew cask install jupyter-notebook-viewer
```
- [shoprunner/jupyter-notify](https://github.com/shoprunner/jupyter-notify): jupyterのセル入力に対してブラウザに完了シグナルを送る。
- [sjpfenninger/ipython-extensions](https://github.com/sjpfenninger/ipython-extensions): jupyter kernelがidleになったのを検出。待ち時間が長いジョブを走らせるときに便利。
