---
title: 音楽情報科学
weight: 40
---

## 楽曲解析

- [能動的音楽鑑賞サービスSongle](https://songle.jp/)
- [Sonic Visualiser](https://sonicvisualiser.org)
- [Piano Precision](https://github.com/yucongj/piano-precision)

## Database/Corppora

### Song data

- [Free Music Archive](http://freemusicarchive.org/)
- [Weimar jazz database](https://jazzomat.hfm-weimar.de/dbformat/dboverview.html)
- [Lakh Pianoroll Dataset](https://salu133445.github.io/lakh-pianoroll-dataset/)
- [Music corpora for harmonic analysis](https://github.com/pmcharrison/hcorp)
	- コード進行解析用コーパス

### Performance data

- [CrestMusePEDB](http://www.crestmuse.jp/pedb/)
- [演奏 deviation データベース　](https://ist.ksc.kwansei.ac.jp/~katayose/Download/Database/deviation/)
- [The MAESTRO Dataset](https://magenta.withgoogle.com/datasets/maestro)
- [Aligned Scores and Performances (ASAP) dataset](https://github.com/fosfrancesco/asap-dataset)
	- A dataset of aligned musical scores (both MIDI and MusicXML) and performances (audio and MIDI), all with downbeat, beat, time signature, and key signature annotations.
	- Maestro dataset v2.0.0に情報追加したもの
- [(n)ASAP: the (note-)Aligned Scores And Performances dataset](https://github.com/CPJKU/asap-dataset)
	- ASAP datasetのMIDIデータと楽譜データを一音ごとに対応づけをしたもの
- [ATEPP: A Dataset of Automatically Transcribed Expressive Piano Performances](https://github.com/tangjjbetsy/ATEPP)
	- a dataset of expressive piano performances by virtuoso pianists.
	- ByteDanceのツールの修正版(?)を使ってMIDI変換
- [Vienna 4x22 Piano Corpus -- Match, MusicXML, and PDF files](https://github.com/CPJKU/vienna4x22)
	- Chopin, op. 38, measures 1-46
	- Chopin, op. 10, measures 1-22
	- Schubert, D783, 1st movement, measures 1-33
	- Mozart, K331, 1st movement, measures 1-36
- [Mazurka Project](https://mazurka.org.uk)

### コード解析

- [chordwiki](https://ja.chordwiki.org)
- [Hookthoery](https://www.hooktheory.com)

## Libraries

### General Analysis

- [music21](http://web.mit.edu/music21/)
	- a toolkit for computer-aided musicology
- [Rhythm Pattern Audio Feature Extractor](https://github.com/tuwien-musicir/rp_extract)
- [librosa](https://github.com/librosa/librosa)
	- A python package for music and audio analysis.
- [aubio](https://github.com/aubio/aubio)
	- A library to label music and sounds. It listens to audio signals and attempts to detect events. For instance, when a drum is hit, at which frequency is a note, or at what tempo is a rhythmic melody.
- [Pop Music Highlighter](https://github.com/remyhuang/pop-music-highlighter)
- [MuseGAN](https://github.com/salu133445/musegan)
	- 音楽自動生成
- [Instructional notebooks on music information retrieval](https://github.com/stevetjoa/musicinformationretrieval.com)

### Expectation models

- [Representing harmony with the hrep package](https://github.com/pmcharrison/hrep)

### プログラミング

- [Cycling 74 Max](http://www.mi7.co.jp/products/cycling74/)
	- [イントロダクション、Max/MSP Jitter入門](http://yoppa.org/ssaw10/798.html)
	- [筋電センサ関係情報 by 長嶋洋一先生](http://nagasm.org/ASL/CQ_mbed_EMG.html)のサイトにもMaxの概要についての解りやすい説明がある
- [Pure Data](http://puredata.info/)
	- Maxのオープンソース版. MatlabとOctaveのような関係
	- [Max & PureData](http://psyto.s26.xrea.com/pd/whatispd.html)
	- [Pd入門1 . Pdとは? プログラミングの基本](http://yoppa.org/ssaw13/4449.html)
- [SuperCollider](http://supercollider.sourceforge.net/)
	- リアルタイム音響処理用のプログラミング言語
- [Qt](http://www.qt.io/)
	- KDEとかで結名な汎用ライブラリ．音のリアルタイム処理に使っている方も多いらしい
