---
title: 深層学習
---

[深層学習](https://ja.wikipedia.org/wiki/%E3%83%87%E3%82%A3%E3%83%BC%E3%83%97%E3%83%A9%E3%83%BC%E3%83%8B%E3%83%B3%E3%82%B0#cite_note-2)(ディープラーニング)は，4層以上のニューラルネットワークモデルを使った機械学習の手法。

このページにはKerasで深層パーセプトロンと畳込みニューラルネットワークを作ってMNISTデータを学習するサンプルプログラムがあります。

## 畳込みニューラルネットワーク
畳み込みニューラルネットワーク(Convolutional Network)について参考になるサイト

- ネオ・コグニトロン(畳込みニューラルネットワークの元祖になる視覚系の神経処理モデル)の説明ビデオ(英語)
  - [Neocognitron Movie - Part #1](https://www.youtube.com/watch?v=Qil4kmvm2Sw)
  - [Neocognitron Movie - Part #2](https://www.youtube.com/watch?v=oVYCjL54qoY)
- [How do Convolutional Neural Networks work? by Brandon Roher](http://postd.cc/how-do-convolutional-neural-networks-work/)
  - [日本語訳](http://postd.cc/how-do-convolutional-neural-networks-work/)


## MNISTデータベース

[MNISTデータベース](https://en.wikipedia.org/wiki/MNIST_database)は，手書き数字画像とそのラベル(正解データ)のデータベース

- 28x28画素
- 訓練用データ: 60,000個
- テスト用データ: 10,000個
- クラス数: 10 (数字の0から9)

Kerasでは，MNISTデータベースの他，いくつかのデータセットをコマンド1行で読み込むことができる([参考URL](https://keras.io/ja/datasets/))。

## サンプルプログラム

<script src="https://gist.github.com/jnishii/cac4804b5fc267dbb86036c971c7eba4.js"></script>

畳み込みニューラルネットワークによる文字認識デモは[Keras-js](https://transcranial.github.io/keras-js/#/)にあります。
