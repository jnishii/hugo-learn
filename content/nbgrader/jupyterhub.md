---
title: jupyterhubとの連携
weight: 40
---

## 設定(1コースの場合)

- [Using nbgrader with JupyterHub](https://nbgrader.readthedocs.io/en/stable/configuration/jupyterhub_config.html)

### スタッフ，受講生共通の設定

- `/etc/jupyter/nbgrader_config.py`

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

- `~/.jupyter/nbgrader_config.py`

```
c = get_config()

c.CourseDirectory.root = '/home/<username>/<course_name>' # 適宜変更する
c.NbGrader.logfile = '/home/<username>/log/nbgrader.log'
```

### コース設定

- `~/home/<username>/<course_name>/nbgrader_config.py`
	- `nbgrader quickstart <course_name>`で出力されるものをそのまま使っている。

## 設定(複数コース)

まずは，上記の1コースの設定を一通り理解していることが必要。
多コースに拡張するための設定の概要は以下の通り。

- `/etc/nbgrader_config.py`に各コース用ホームディレクトリ(担当教員のホーム'/home/<username>/`等)を指定。
	- 各コースに対して異なるポートを割り振る
	- 各コースに対するユーザ指定(whitelist)設定をする。(ユーザ追加毎にjupyterhubの再起動が必要なのが厄介)
- 各コース用ホームディレクトリに`~/.jupyter/nbgrader_conf.py`を置いて，課題用ルートフォルダ('/home/<username>/<course_name>')を指定

- `/etc/nbgrader_config.py`もしくは，**学生**の`~/.jupyter/nbgrader_config.py`に以下を追記
```
from nbgrader.auth JupyterHubAuthPlugin
c = get_config()
c.Exchange.path_includes_course = True
c.Authenticator.plugin_class = JupyterHubAuthPlugin
```
- コース用ディレクトリに'/home/<username>/<course_name>/nbgrader_config.py'を準備(1コースの場合と同じ)
- 詳細はこちら: [Example Use Case: Multiple Classes](https://nbgrader.readthedocs.io/en/latest/configuration/jupyterhub_config.html#example-use-case-multiple-classes)を参照



## おまけ

### nbgitpuller

受講生がjupyterにログインした時に，git pullを簡単に実行させるためのjupyter plugin.

- [jupyterhub/nbgitpuller](https://github.com/jupyterhub/nbgitpuller)



### cull_idle

jupyterhubにログインしたままコマンド実行がないプロセスは止めるための設定。`/etc/jupyterhub/jupyterhub.conf`に以下を追記しておく。

```
# cull_idle
c.JupyterHub.services = [
    {
        'name': 'cull_idle',
        'admin': True,
#        'command': ['/home/adm/jupyterhub/cull_idle_servers.py'],
        'command': '/usr/local/anaconda3/bin/python3 <write path here>/cull_idle_servers.py --timeout=7200'.split(),
    }
]
```

実行コマンド[cull_idle_servers.py](https://github.com/jupyterhub/jupyterhub/blob/master/examples/cull-idle/cull_idle_servers.py)を，上記で指定するパスにおいておく。
