---
title: 課題作成から採点まで
weight: 2
---

## 課題の作り方


[Creating a new assignment](https://nbgrader.readthedocs.io/en/stable/user_guide/creating_and_grading_assignments.html#creating-a-new-assignment)

- Formgrader: "Add new assignment..."をクリック
- コマンド: `nbgrader db assignment add` ソースの置き場所は以下。
```
{course_directory}/source/{assignment_id}/{notebook_id}.ipynb
```

### 作れるセルの種類

詳しくは[ここ](https://nbgrader.readthedocs.io/en/stable/user_guide/creating_and_grading_assignments.html)

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
5. “Read-only” cells
	- 受講生が書き換えてはいけないセル
	- もし受講生が書き換えた場合，採点時(`nbgrader autograde` step)に，もとの内容に書き戻される。

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

[Releasing files to students and collecting submissions](https://nbgrader.readthedocs.io/en/stable/user_guide/creating_and_grading_assignments.html#releasing-files-to-students-and-collecting-submissions)

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


### フィードバック

#### フィードバック用htmlの生成

- Formgrader: "Generate Feedback"
- `nbgrader generate_feedback`: 以下にhtmlファイルができる。

```
feedback/{student_id}/{assignment_id}/{notebook_id}.html

```

#### リリース

- Formgrader: "Release Feedback"
- `nbgrader release_feedback`

### 成績集計

csvファイルを生成できる。

- `nbgrader export`
