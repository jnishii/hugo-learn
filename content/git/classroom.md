---
title: GitHub Classroom
weight: 90
---

Classroom(講義・演習)でGitHubを使うための[GitHub Classroom](https://classroom.github.com/classrooms)がある。

- [GitHub Classroomの紹介ビデオ](https://classroom.github.com/videos)

使い方の手順の参考URL
- [Classroom guide](https://education.github.com/guide)
- [GitHub Classroom Guide for Teachers](https://github.com/jfiksel/github-classroom-for-teachers)
- [GitHub Classroom Guide for Students](https://github.com/jfiksel/github-classroom-for-students)

## 教員がする準備

### 方針
- 継続的にClassroomを管理するMaster Organizationと，年度ごとのClassroom管理をするOrganizationを設置する
- 年度ごとのClassroom Organizationに，各年度のTAや学生チームを登録する

### 設定手順
1. Master Organizationの準備
    - [Organization](https://github.com/settings/organizations)から登録
    - Master Organizationの名称例) "machine-learning-master"
2. 各年度用Organizationの準備
    - [Organization](https://github.com/settings/organizations)から登録
    - Organizationの名称例) "intro-machine-learning-2018"
    - (Optional) TA等の登録
    - (Optional)Teamの設置(学生チーム等を作る)。
3. Classroomの設置
    - [GitHub Classroom](https://classroom.github.com/classrooms)で，2で準備したOrganizationを登録し，誘導に従ってClassroomの設定をする
4. Classroom内にAssignments(宿題やシラバス等)の準備をし，宿題の"Invitation Link"を学生に送る
    - [Classroom guide/Assignments](https://education.github.com/guide/assignments)参照
    - 注意: 課題名がURLになる。スペーはは使えない
    - 課題名の例) "Perceptron-1"
5. 登録学生の一覧はClassroomのページで確認できる。Organization内の非公開リポジトリを学生には公開したい場合は，学生をさらに2で作ったOrganizationのメンバーに登録する。
    - (Optional) [Organizations](https://github.com/settings/organizations)のページで学生をチーム(Team)に登録。課題がプライベートリポジトリなら，"read access"をTeamに設定する。[teachers_pet](https://github.com/education/teachers_pet)を使うと楽らしい。
6. (Optional) シラバスや講義情報等を格納するリポジトリを作る。各年度用Organizationにでも，Master Organizationに作ったほうが長期的管理は(多分)楽。毎年のClassroom設置時にはforkする。

### 課題の設置

1. Starter Kitの作成
    - Master Organizationに宿題用リポジトリを作って，課題等必要なものを入れておく。
2. 課題追加作成
  - [GitHub Classroom](https://classroom.github.com/classrooms)で，assignmentレポジトリを追加
3. 1で作ったStarter Kitから課題を追加
4. 受講生に課題のリンクを知らせる


### 採点

**fork型で課題実施をする場合**

- 受講生からのPull Requestに対して，コメントする
- 終了したらPull Requestを閉じる。ただし，mergeはしない。

[sandbox型](https://education.github.com/guide/sandboxing)で課題実施する方法もある

- 各課題，各受講生ごとにリポジトリを作る必要があるので準備が面倒だが，提出課題を集めるのは楽。
- [teachers_pet](https://github.com/education/teachers_pet)で少し準備等の手間を省けるらしい。


## 学生側の準備

### 準備1: GitHubの基本用語

「[Gitの基本用語](../intro)」のページを読む

### 準備2: 手元のマシンの準備
Gitを使う方法を大別すると2通りある。**長期的には方法1を使えるようにする** こと。短期的には方法2でもいいが，使い方は各自調べること。

[方法1] コマンド直打ちで使う
- Windowsの場合は，google先生に聞いてGit Bashを使えるようにすれば，LinuxやMacと同様に
	ターミナル上で操作できる(はず...)。
<!--	https://qiita.com/shinsumicco/items/a1c799640131ae33c792-->
- Mac/Linuxはターミナル上で，[ここの準備3](../preparation)を実行しておく。

[方法2] GitHub DeskTopをつかう。
- [GitHub Destop](https://desktop.github.com/)をダウンロードする。
- 使い方は各自google先生に教わる。

### 準備3: 課題のリポジトリをfork

1. 教員から送られてくる，課題へのリンクをクリック
2. 表示された画面で"Accept this assignment"をクリック。
3. GitHubに登録したアドレスにメールが届くので”View invitation”をクリックしてGitHubにログイン。
4. 課題のリポジトリの"fork"ボタンをクリックしする。これで，GitHub上でリポジトリがコピー(fork)されて，自分のリモートリポジトリができる


### 準備4: 課題のリポジトリを手元にダウンロード

forkしてできたリモートリポジトリをブラウザで確認する。
"Clone or Download"のボタンをクリックして，リモートリポジトリのURLを入手する。
このリモートリポジトリをダウンロードする。
ダウンロード方法は，「準備2」の2つの方法のどちらを使うかで方法が異なる。

**方法1: コマンド直打ちで**

```
$ git clone  https://github.com/... <=このリポジトリのURLは各自異なる
```
- 関連コマンドの解説は[ここ](../init)にもある。

**方法2: GitHub Desktopで**

GitHub Desktopを起動して，ローカルリポジトリの場所と，上記リモートリポジトリのURLの登録をする。詳しいGitHub Desktopの使い方はgoogle先生に...


### 課題実施1: 課題をしてアップロードする

ダウンロードしてできたローカルリポジトリ内で課題をし，必要なファイルを追加したら
アップロードする。
修正途中でもパックアップをとるために，1日1回は githubに反映する方がよい。

以下はコマンド直打ちでのアップロード方法。
```
$ git status  # 更新したファイル一覧表示(省略可)
$ git add .   # 更新したファイル全てをgitに反映する
$ git commit -m "修正点を簡単に説明"  # 更新情報をローカルリポジトリに反映
$ git push origin master # 更新情報をGitHubに反映
```

その他，各種コマンドは[ここ](../commands)等を参照してください。

### 課題実施2: 課題終了の連絡をする

課題のリモートリポジトリ(教員から連絡があったページ)で，"Pull Request"をする
