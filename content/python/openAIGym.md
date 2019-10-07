---
title: OpenAI Gym
weight: 40
---

## OpenAI Gymのメモ
- [Table of environment](https://github.com/openai/gym/wiki/Table-of-environments)
	- 各環境の状態空間，行動空間，報酬値一覧
- [gym/gym/envs/__init__.py](https://github.com/openai/gym/blob/master/gym/envs/__init__.py)
	- 各環境の設定値(`entry_point`, `max_episode_steps`,  `reward_threshold`)の一覧(registry情報)を見れる
	- CartPole-v0とCartPole-v1は，`max_episode_steps`と`reward_threshold`の違いであることがわかる。
- [How to create new environments for Gym]( https://github.com/openai/gym/blob/master/docs/creating-environments.md)
- [Gym準拠の環境(公式,非公式)一覧](https://github.com/openai/gym/blob/master/docs/environments.md)

## OpenAI Gymインストール

1. Anaconda環境をインストール。
インストール方法は[ここ](../install))。
2. gymのインストール
```
$ pip install gym
```

## FAQ

#### Q. [Google Colaboratory](https://colab.research.google.com/)でOpenAI Gymを使いたい

A. ライブラリのインストールやアニメーション表示が問題になりますが，そこそこにはなんとかなります。以下を見てください。

- [ColaboratoryでOpenAI gym](http://bcl.sci.yamaguchi-u.ac.jp/~jun/ja/blog/180828-openai-colaboratory)
- [ColaboratoryでKeras-rl+OpenAI Gym (classical_control)](http://bcl.sci.yamaguchi-u.ac.jp/~jun/ja/blog/180828b-kerasrl-colaboratory)
- [ColaboratoryでKeras-rl+OpenAI Gym (atari)](http://bcl.sci.yamaguchi-u.ac.jp/~jun/ja/blog/180829-kerasrl-atari-colaboratory)


#### Q. 実行時のエラー: "Error: Tried to reset environment which is not done. While the monitor is active for CartPole-v1, you cannot call reset() unless the episode is over."

A. max_episode_steps の値を調整する。

- 方法1: `env.tags['wrapper_config.TimeLimit.max_episode_steps'] = 500`
- 方法2: 
```
register(
    id='CartPole-v1',
    entry_point='gym.envs.classic_control:CartPoleEnv',
    tags={'wrapper_config.TimeLimit.max_episode_steps': 500},
    reward_threshold=475.0,
)
```
idの名前を変えれば，仮に違う名前の環境として定義できる。

参考URL: [How to configure the cartpole environment such that it is not capped at 200?](https://github.com/openai/gym/issues/463)

#### Q. FrozenLakeが滑り過ぎで困る。滑らない環境にしたい。

A. 以下のような設定を加える。
```
from gym.envs.registration import register
register(
    id='FrozenLakeNotSlippery-v0',
    entry_point='gym.envs.toy_text:FrozenLakeEnv',
    kwargs={'map_name' : '4x4', 'is_slippery': False},
    max_episode_steps=100,
    reward_threshold=0.78, # optimum = .8196
)
```
環境名(id)は自由に変えられる。上記の場合は`FrozenLakeNotSlippery-v0`

参考URL: [Setting is_slippery=False in FrozenLake-v0](https://github.com/openai/gym/issues/565)

## リンク

- [The Pac-Man Projects](http://ai.berkeley.edu/project_overview.html)