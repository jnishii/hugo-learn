---
title: jupyterhubとの連携
weight: 40
---

## 設定

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

- `~//home/<username>/<course_name>/nbgrader_conf.py`
	- `nbgrader quickstart <course_name>`で出力されるものをそのまま使っている。


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
