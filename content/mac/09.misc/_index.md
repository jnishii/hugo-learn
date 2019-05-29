---
title: Macメモ
---

## 使い方メモ
### ショートカット
-  文字入力
 +  入力コードを間違えたまま入力した時は，入力したかったほうのモードのキーを２回押す
 +  変換間違い：選択後かなキーを２回おす
 +  漢字の読みがわからない：辺や作りをべつべつに入力した後，ことえりメニューで「部品の共通な漢字を検索」をクリック
- [キーボートショートカット](http://docs.info.apple.com/jarticle.html?artnum=58068)
-  Cmd+Ctl+D : 辞書起動


### アプリケーションの削除

アプリケーションを削除するには，関連ファイルも削除できるように専用コマンドを使う。

- `lsbom`を使う方法
  - インストールされているパッケージの内容を以下のようにlsbomで確認して消去
  ```
  $ lsbom /Library/Receipts/Mail.pkg/Contents/Archive.bom
  ```
- [FreeMacSoft](http://www.freemacsoft.net/)のAppCleanerを使う。
  - 捨てたいアプリをAppCleanerにドラッグするだけ

### 警告音を消す
```
defaults write com.apple.systemsound "com.apple.sound.uiaudio.enabled" -int 0
```

### CDが認識されず eject も出来ないとき
「ユーティリティ/ディスクユーティリティ」を起動。そこで挿入したCDが認識されていればそれを選択して「マウント」もしくは「取り出し」を選択


## アプリのメモ

AppStoreで入手できないフリーソフトはhomebrewでインストールするのがおすすめ。
以下もhomebrewで管理できるものが多いけど，便利なものを一応リストアップ。

- 開発環境
 + App StoreからXcodeをインストールするとgccとかいろいろ使える。
 + [ng-1.5beta1をUTF-8対応させてみた。](http://hidev.blog.so-net.ne.jp/2007-03-09) -- 簡易版Emacs
- オフィススイーツ
 + [LibreOffice](http://ja.libreoffice.org)
- お絵描き
 + [Gimp](http://macwiki.sourceforge.jp/wiki/index.php/Gimp)
 + [SeaShore](http://seashore.sourceforge.net/screenshot.php) - - gimpの簡易版みたいなの
- その他
 + [google日本語入力](http://www.google.com/intl/ja/ime/index-mac.html)


### ビデオ編集グッズ
- [動画狂コーナー技術資料](http://www.katch.ne.jp/~kakonacl/douga/douga.html)
- [MacTheRipper](http://veadardiary.blog29.fc2.com/blog-entry-341.html)
- [HandBrake](http://handbrake.fr/)
 +  vobファイルをいろいろな形式に変換できる。iPod用, iPad用等の設定があって便利
- [Avidemux](http://fixounet.free.fr/avidemux/)
 +  AVI, DVD compatible MPEG files, MP4 and ASF, vib等に対応したビデオ編集ソフト
- [DVD-VR ripper for linux](http://www.pixelbeat.org/programs/dvd-vr/)
 + DVD-VRからvobファイルを取り出すのに使える。"for linux"とあるがMac OS Xでも問題なし
 + 実行例
 * dvd- vr /media/cdrom0/DVD_RTAV/VR_MANGR.IFO /media/cdrom0/DVD_RTAV/VR_MOVIE.VRO
-  [SQUARED 5 MPEG STREAMCLIP](http://www.squared5.com/)
 + Supported input formats: MPEG, VOB, PS, M2P, MOD, VRO, DAT, MOV, DV, AVI, MP4, TS, M2T, MMV, REC, VID, AVR, M2V, M1V, MPV, AIFF, M1A, MP2, MPA, AC3, ...
 + export to QuickTime, AVI, DV and MPEG- 4 files
 + vob,mpeg- 2をいじるには[QuickTime MPEG-2再生コンポーネント](http://www.apple.com/jp/quicktime/mpeg2/)が必要
 + [MPEG Streamclip](http://www.katch.ne.jp/~kakonacl/douga/mpgstclip/mpgstclip.html)
- 編集はiMovieでもOK(のはず)
- [Burn](http://veadardiary.blog29.fc2.com/blog-entry-863.html)
 +  DVDを焼く(iDVDでもいい?)
