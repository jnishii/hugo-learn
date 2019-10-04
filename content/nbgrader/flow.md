---
title: 課題作成から採点まで
weight: 20
---

## 課題の作り方


[Creating a new assignment](https://nbgrader.readthedocs.io/en/stable/user_guide/creating_and_grading_assignments.html#creating-a-new-assignment)

- Formgrader: "Add new assignment..."をクリック
- コマンド: `nbgrader db assignment add` ソースは以下に配置される。
```
{course_directory}/source/{assignment_id}/{notebook_id}.ipynb
```

### 作れるセルの種類


1. “Manually graded answer” cells
	- 人力採点用セル。回答入力用セルを1つのみ用意。
2. "Manually graded task” cells
	- 人力採点用セル。回答入力用セルを複数用意。
	- `=== BEGIN MARK SCHEME ===`, `=== END MARK SCHEME ===`で囲んだ部分は学生用ファイルには出力されない。(採点時とフィードバック時に表示される)
3. “Autograded answer” cells
	- 自動採点の解答部分を含むセル
	- 解答部分は，`### BEGIN SOLUTION`と`### END SOLUTION`で囲む。
4. “Autograder tests” cells
	- 自動採点のために実行する動作確認用命令文用セル
	- 実行時にエラーが起きなかったら得点。エラーが生じたら0点
	- 動作確認用命令文を隠したい時には，`### BEGIN HIDDEN TESTS`, `### END HIDDEN TESTS`で囲む。
	- 採点後，フィードバック用に生成されるファイルには上記`HIDDEN TESTS`の部分も表示される。隠したい場合は，別ファイルに評価プログラムを作ってそれを呼び出すか，フィードバック用ファイルをさらにカスタマイズする必要あり
		- [Hiding autograder test code cells in feedback but retaining their output #1156](https://github.com/jupyter/nbgrader/issues/1156)
5. “Read-only” cells
	- 受講生が書き換えてはいけないセル
	- もし受講生が書き換えた場合，採点時(`nbgrader autograde` step)に，もとの内容に書き戻される。

- [自動採点のTips(本サイト内リンク)](../evaluation)
- [Developing assignments with the assignment toolbar](https://nbgrader.readthedocs.io/en/stable/user_guide/creating_and_grading_assignments.html)


### シートの検証

満点をとれる内容になっているかを検証

- Formgrader (jupyter notebook): アイコン欄の"Validate"をクリック。
- コマンド: `nbgrader validate source/ps1/*.ipynb`

### 課題シートの生成

[Generate and release an assignment](https://nbgrader.readthedocs.io/en/stable/user_guide/creating_and_grading_assignments.html#generate-and-release-an-assignment)

1. Formgrader (jupyter notebook)で生成: Generateボタンを押す
2. シェルコマンド: `nbgrader generate_assignment` (コースディレクトリのルートで実行)

変換後のファイルは以下に出力される
```
{course_directory}/release/{assignment_id}/{notebook_id}.ipynb
```
これを適当な手段で，受講生に配布する。

#### ヘッダの追加

課題シートの冒頭に`source/header.ipynb`の内容を追加できる。

```
nbgrader generate_assignment "ps1" --IncludeHeaderFooter.header=source/header.ipynb --force
```

### 課題シートのプレビューと検証

1. Formgrader: "Preview"
2. 課題シートの検証: 以下を実行して，いずれの課題も不合格になることを確認
```
nbgrader validate --invert release/ps1/*.ipynb
```

### 課題シートの配布と回収

- [Releasing files to students and collecting submissions](https://nbgrader.readthedocs.io/en/stable/user_guide/creating_and_grading_assignments.html#releasing-files-to-students-and-collecting-submissions)
- 提出された課題シートの回収後は，課題シートの修正・配布はできなくなる。

#### 配布

- Formgrader: "Release"
- コマンド: `nbgrader release_assignment` (`release`フォルダに移動)
- moodleとかに置いて配布しても良い。

#### 回収

- moodleとかで集めて，`submitted`フォルダに入れても良い
- Formgrader: "Collect"
- コマンド: `nbgrader collect`

回収したファイルは以下に配置される
```
submitted/{student_id}/{assignment_id}/{notebook_id}.ipynb
```

### 採点

- Formgrader: "Manage Assignments"タブで"Autograde"
- コマンド: `nbgrader autograde "ps1" --force`

自動採点後のシートは以下に格納される。
```
autograded/{student_id}/{assignment_id}/{notebook_id}.ipynb
```
人力採点が必要なら自動採点後に。Formgrader上でもできる。


〆切遅れに対して，ペナルティを設けることもできる([Late submission plugin](https://nbgrader.readthedocs.io/en/stable/plugins/late-plugin.html))。

- 1日につき1点減点などの設定可能。この場合，提出シートが3シートならば，それぞれに対して1点減点になる。ただし，0点が下限。



### フィードバック

#### フィードバック用htmlの生成

- Formgrader: "Generate Feedback"
- `nbgrader generate_feedback`

以下にhtmlファイルができる。(ipynbのシートがフィードバックされるわけではない)

```
feedback/{student_id}/{assignment_id}/{notebook_id}.html
```

#### リリース

- Formgrader: "Release Feedback"
- `nbgrader release_feedback`

### 成績集計

csvファイルを生成できる。

- `nbgrader export`

## 課題の再リリース

提出された課題(assignment) の回収をすると，その後は修正した課題シートを再リリースすることはできなくなる。
再リリースするには，まずunreleaseする。
```
nbgrader list --remove <assignment_name>
```

課題をデータベースからも消去したい場合
```
nbgrader db assignment remove <assignment_name>
```

回収済みの提出物等も消去する場合は，以下を実行する。

```
1. Delete the release directory (rm -r release/<assignment_name>)
2. Delete any submissions of it (rm -r submitted/*/<assignment_name>)
3. Delete any autograded versions of it (rm -r autograded/*/<assignment_name>)
4. Delete any feedback of it (rm -r feedback/*/<assignment_name>)
```

- [参考) Released assignments are still there after nbgrader db assignment remove](https://github.com/jupyter/nbgrader/issues/995)
