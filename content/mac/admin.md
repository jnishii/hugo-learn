---
title: ユーザ管理
weight: 5
---

Macにターミナル・コマンドでユーザやグループの追加をする方法


### プライマリグループIDの一覧表示
```
$ dscl . ls /Users PrimaryGroupID | sort -n -k2
$ dscl . ls /Groups PrimaryGroupID | sort -n -k2
```

### uid,gidの一覧表示

```
$ dscl . ls /Users UniqueID | sort -n -k2
$ dscl . ls /Groups UniqueID | sort -n -k2
```

### ユーザ・グループの登録

登録したいユーザ名を`<user>`, グループ名を`<group>`とする。
前述の方法で，uid, gidリストを確認し，使わせていない番号を`<user>`, `<group>`のidとする。

以下はuid, gidをそれぞれ1001, 500とし，ログインユーザではないデーモン用ユーザを登録する例。

**グループ登録**
```
$ sudo dscl . create /Groups/<group>
$ sudo dscl . create /Groups/<group> PrimaryGroupID 500
```

**ユーザ登録**
```
$ sudo dscl . create /Users/<user>
$ sudo dscl . create /Users/<user> RealName <real name>
$ sudo dscl . create /Users/<user> UniqueID 1001
$ sudo dscl . create /Users/<user> PrimaryGroupID 500
$ sudo dscl . create /Users/<user> UserShell /usr/bin/false
$ sudo dscl . create /Users/<user> Password \*
```

**ホームの作成と指定**
```
$ sudo mkdir /Users/<user>
$ sudo dscl . create /Users/<user> NFSHomeDirectory /Users/<user>
$ sudo cp -a /System/Library/User\ Template/English.lproj /Users/$TARGETUSER
$ chown -R <user> /Users/<user>
$ chgrp -R <group> /Users/<user>
```

**ユーザをPrimaryGroup以外のグループに追加登録**
```
$ sudo dscl . append /Groups/<group2> GroupMembership <user>
```

**ユーザ削除**
```
$ sudo dscl . delete /Users/<user>
```

**ユーザ・グループ情報の詳細確認**
```
$ dscl . read /Users/<user>
$ dscl . read /Groups/<group>
```

**グループに所属するユーザの確認**
```
$ dscl . search /Users PrimaryGroupID 500
```