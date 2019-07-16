---
title: Quick Start
weight: 20
---

注) この文書は[Diazo:Quick Start](http://docs.diazo.org/en/latest/quickstart.html)をgoogle 翻訳にかけた後，フォーマットなどを少し修正したものです。少し訳を修正した部分もありますが，google 翻訳そのままの部分がほとんどです。

## テーマ作成

1. テーマディレクトリにtheme.htmlを配置

	```
	 <html>
		 <head>
			 <title>タイトル </ title>
			 <link rel = "stylesheet" href = "./ theme.css" />
		 </ head>
		 <body>
			 <h1 id = "title">Diazoのホームページ</ h1>
			 <div id = "content">
				 <！ - プレースホルダ - >
				 こんにちは。Diazoと言います。よろしく。
			 </ div>
		 </ body>
	 </ html>
	 ```

2. theme.css を作成

	```
	h1 {
		font-size: 18pt;
		font-weight: bold;
	}

	.headerlink {
		color: #DDDDDD;
		font-size: 80%;
		text-decoration: none;
		vertical-align: top;
	}

	.align-right {
		float: right;
		margin: 0 10px;
		border: dotted #ddd 1px;
	}
	``` 

3. rulesファイルを作成

-   rulesファイルには、コンテンツにテーマを適用するためのDiazoの命令文を書く。
- 以下は、diazo.orgのテーマ作成例。 
	- `indices-and-tables` のコンテンツを削除
	- `.content`の内容に置き換え
-  ファイル rules.xml は，ファイル構造の一番上のレベルに置く。
- ルール構文の詳細については、「 基本構文」を参照してください。

	```
	 <rules
	xmlns="http://namespaces.plone.org/diazo"
	xmlns:css="http://namespaces.plone.org/diazo/css"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<theme href="theme/theme.html" />

	<drop css:content="#indices-and-tables" />
	<replace css:theme-children="#content" css:content-children=".content" />

	</rules>
	```

## テーマ作成のためのヒント

FirefoxのFirebugやChromeの開発ツールなどのツールを使用して、テーマやコンテンツのページを調べ、適切なIDとクラスを探してルールを作成する。
