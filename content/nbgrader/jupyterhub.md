---
title: jupyterhubとの連携
weight: 40
---

jupyterhub上でnbgraderを使うときの設定例。
1コース，1教員の単純な設定です。

## nbgraderのインストール

- [Installation](https://nbgrader.readthedocs.io/en/stable/user_guide/installation.html)

```
# conda install jupyter
# conda install -c conda-forge nbgrader
```

```
# jupyter nbextension install --sys-prefix --py nbgrader --overwrite
# jupyter nbextension enable --sys-prefix --py nbgrader
# jupyter serverextension enable --sys-prefix --py nbgrader
```

### 受講生は不要なものを無効に

- 課題作成メニュー

```
# jupyter nbextension disable --sys-prefix create_assignment/main
```
- Formgraderタブ
```
# jupyter nbextension disable --sys-prefix formgrader/main --section=tree
# jupyter serverextension disable --sys-prefix nbgrader.server_extensions.formgrader
```
- コースリスト(1コース(科目)のみの場合)
```
# jupyter nbextension disable --sys-prefix course_list/main --section=tree
# jupyter serverextension disable --sys-prefix nbgrader.server_extensions.course_list
```

### スタッフは上記を有効に

```
$ jupyter nbextension enable --user create_assignment/main
$ jupyter nbextension enable --user formgrader/main --section=tree
$ jupyter serverextension enable --user nbgrader.server_extensions.formgrader
$ jupyter nbextension enable --user course_list/main --section=tree
$ jupyter serverextension enable --user nbgrader.server_extensions.course_list
```

## 設定

[Using nbgrader with JupyterHub](https://nbgrader.readthedocs.io/en/stable/configuration/jupyterhub_config.html)

### スタッフ，受講生共通の設定

`/etc/jupyter/nbgrader_config.py`

```
c = get_config()
c.NbGrader.logfile = "/var/log/nbgrader.log"
c.Exchange.root = '/home/share/nbgrader/exchange'
c.Exchange.timestamp_format = '%Y-%m-%d %H:%M:%S %Z'
c.Exchange.timezone = 'JST'
```

注)

1. Exchange.rootは事前に作成して，ユーザが書き込み可にしておかないといけない
2. `c.Exchange.timestamp_format'`はデフォルトでは秒が小数になるが，経過時間等の処理の時に困ることがあるので小数部は切り捨て。
3. `c.Exchange.timezone = 'JST'`の設定がなぜか有効にならない。。。

### スタッフの設定

`~/.jupyter/nbgrader_config.py`

```
c = get_config()

c.CourseDirectory.root = '/home/<username>/<course_name>' # 適宜変更する
c.NbGrader.logfile = '/home/<username>/log/nbgrader.log'
```

### コース設定

`~//home/<username>/<course_name>/nbgrader_conf.py`

`nbgrader quickstart <course_name>`で出力されるものをそのまま使っている。