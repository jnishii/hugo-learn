---
title: Advanced Usage
---

注) この文書は[Diazo:Advanced Usage](http://docs.diazo.org/en/latest/advanced.html)をgoogle 翻訳にかけた後，フォーマットなどを少し修正したものです。少し訳を修正した部分もありますが，google 翻訳そのままの部分がほとんどです。

ほとんどのテーマでは、基本的なルールで十分です。 しかし、例えば、複雑なデザインやセマンティックマークアップが明確でないコンテンツソースを扱う場合など、もう少しパワーが必要な場合があります。

##条件付きルール

場合によっては、特定の要素がマークアップに表示されたり表示されなかったりする場合にのみ、ルールを適用すると便利です。 if 、 if-contentおよびif-path属性は、<theme />および<notheme />ディレクティブだけでなく、どのルールでも使用できます。

### コンテンツノードに基づく条件
if-contentをXPath式に設定する必要があります。 また、CSS3式で`CSS:if-content`を使用することもできます。 式がコンテンツ内のノードと一致する場合、ルールが適用されます。
```
<replace css:theme-children="#portlets" css:content=".portlet"/>
<drop css:theme="#portlet-wrapper" css:if-content="#content.wide"/>
```
これにより、クラスポートレットを持つすべての要素がportlets要素にコピーされます 。 コンテンツに一致する要素がない場合、おそらく余分なポートレット・ラッパー・エレメントがドロップされます 。
CSSセレクタを使用した別の例を次に示します。
```
<replace css:theme-children="#header" css:content-children="#header-box"
	  css:if-content="#personal-bar"/>
```
これにより、id パーソナルバーの要素がコンテンツのどこかに現れる限り、id ヘッダー付きの要素の子要素がコンテンツのid ヘッダー付きの要素にコピーされます。
空の`if-content` （または`css:if-content` ）は、「 `content`または`css:content`属性を条件として使用する」という意味のショートカットです。 したがって、次の2つのルールは同等です。
```
<replace css:theme-children="#header" css:content="#header-box"
	  css:if-content="#header-box"/>
<copy css:theme-children="#header" css:content="#header-box"
	  css:if-content=""/>
```
同じタイプの複数のルールが同じテーマノードに一致するが、異なるif式を持つ場合 、それらはif..else if ... elseブロックとして結合されます。
```
<replace theme-children="/html/body/h1" content="/html/body/h1/text()"
	  if-content="/html/body/h1"/>
<replace theme-children="/html/body/h1" content="//h1[@id='first-heading']/text()"
	  if-content="//h1[@id='first-heading']"/>
```
これらの規則はすべて、本文の中の<h1 />内のテキストを埋めようとします。 最初のルールは、同様の<h1 />タグを探し、そのテキストを使用します。 一致しない場合、第2のルールはidがfirst-headingの <h1 />を探し、そのテキストを使用します。 一致しない場合、最後のルールはコンテンツ文書の先頭にある<title />タグの内容を取ってフォールバックとして使用されます（ if-contentは存在しないため）。
コンテンツの条件は、 if-not-contentまたはcss：if-not-contentで否定できます。たとえば、次のようになります。
```
<drop css:theme="#portlet-wrapper" css:if-not-content=".portlet"/>
```

### パスに基づく条件

ライブトランスフォームが適切なパラメータ（ `$path`パラメータ）を渡すように正しく構成されている場合は、着信要求のURLパスセグメントに基づいて条件を作成すること
ができます。 これは、 if-path属性を使用します。

先頭に/があると、URLの先頭とパスが一致する必要があります。
```
<drop css:theme="#info-box" if-path="/news"/>
```
と書くと，`/news` 、 `/ news /`および`/news/page1.html`には一致しますが、 `/ newspapers`では一致しません。完全なパスセグメントのみが一致します。
末尾に/は、URLの末尾にパスが一致する必要があることを示します。
```
<drop css:theme="#info-box" if-path="news/"/>
```
これは，`/mysite/news`と`/mysite/news/`に一致します。

正確なURLに一致させるには、先頭と末尾の両方に`/`を使用します。
```
<drop css:theme="#info-box" if-path="/news/"/>
```
これは，`/news`と`/news/`に一致します。

先頭または末尾に/を付けないと、URL内の任意の場所にパスセグメントが一致する可能性があります。
```
<drop css:theme="#info-box" if-path="news/space"/>
```
これは，`/mysite/news/space/page1.html`と一致します 。
複数の代替パス条件が、 if-path属性に空白で区切られたリストとして含めることができます。
```
<drop css:theme="#info-box" if-path="/ /index.html/"/>
```
/と/index.htmlに一致します。 if-path = "/"は完全一致条件と見なされます
パス条件は、 if-not-pathで否定できます。たとえば、次のようになります。
```
<drop css:theme="#info-box" if-not-path="/news"/>
```

### 任意のパラメータに基づく条件文

if属性を使用すると、有効なXPath式でルールまたはテーマを条件付きにすることができます。
たとえば、文字列パラメータ`$mode`を受け取るようにトランスフォームが設定されている場合は、次のように記述できます。
```
<drop css:theme=".test-site-warning" if="$mode = 'live'" />
```
if-not属性を使用してconditonを否定します。たとえば、次のようにします。
```
<drop css:theme=".test-site-warning" if-not="$mode = 'live'" />
```

### 条件のグループ化とネスティング

`<rules>`タグに配置することで、複数のルールに条件を適用できます。
```
<rules
	xmlns="http://namespaces.plone.org/diazo"
	xmlns:css="http://namespaces.plone.org/diazo/css"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<rules css:if-content="#personal-bar">
		<after css:theme-children="#header-box" css:content="#user-prefs"/>
		<after css:theme-children="#header-box" css:content="#logout"/>
	</rules>

	...

</rules>
```
条件はネストすることもできます：
```
<rules if="condition1">
	<rules if="condition2">
		<copy if="condition3" css:theme="#a" css:content="#b"/>
	</rules>
</rules>
```
これは，次と同等です：
```
<copy if="(condition1) and (condition2) and (condition3)" css:theme="#a" css:content="#b"/>
```

### 複数の条件付きテーマ
条件を使用して複数のテーマを指定することは可能です。 例えば：
```
<theme href="theme.html"/>
<theme href="news.html" css:if-content="body.section-news"/>
<theme href="members.html" css:if-content="body.section-members"/>
```
潜在的なテーマは指定された順序でテストされます。 一致する最初のものが使用されます。
無条件テーマは、他のテーマの条件が満たされない場合のフォールバックとして使用されます。 無条件のテーマが指定されていない場合、ドキュメントはテーマなしで渡されます。
<notheme />を使って、条件付きでテーマを無効にすることもできます ：
```
<theme href="theme.html"/>
<notheme if-path="/assets" />
```
条件付きの<theme />ディレクティブに関係なく、一致する<notheme />がある場合、テーマは無効になります。
すべてのルールがすべてのテーマに適用されます。 ルールを1つのテーマにのみ適用するには、条件グループの構文を使用します。
```
<rules css:if-content="body.section-news">
	<theme href="news.html"/>
	<copy css:content="h2.articleheading" css:theme="h1"/>
</rules>
```

## テーマを少し変更する

時には、テーマはほぼ完璧ですが、たとえば、アクセス権がない遠隔地から提供されている、または他のアプリケーションと共有されているなど、変更することはできません。
Diazoでは、ルールファイルの "インライン"マークアップを使ってテーマを変更することができます。 これは、一致したコンテンツが、スタイル付けされているレスポンスから引き出されるのではなく、ルールファイルに明示的に記述されるルールとして考えることができます。

例えば：
```
<after theme-children="/html/head">
	<style type="text/css">
		/* From the rules */
		body > h1 { color: red; }
	</style>
</after>
```
上の例では、 <after />ルールは<style />属性とその内容をテーマの<head />にコピーします。 <before />と<replace />に対しても同様の規則を構築できます。
この方法でコンパイルされたテーマにXSLT命令を挿入することも可能です：
```
<replace css:theme="#details">
	<dl id="details">
		<xsl:for-each css:select="table#details > tr">
			<dt><xsl:copy-of select="td[1]/text()"/></dt>
			<dd><xsl:copy-of select="td[2]/node()"/></dd>
		</xsl:for-each>
	</dl>
</replace>
```
ここで、XSLコンテキストはコンテンツのルートノードです。
<cs：select >の使い方に注目して、 <xsl：for-each />ディレクティブで操作するノードを選択してください。 実際には、XPath式を指定するものにはcss：namespaceを使用でき、Diazoプリプロセッサはこれを同等のXPathに変換します。
インラインマークアップとXSLTは条件と組み合わせることができます：
```
<before css:theme"#content-wrapper" css:if-content="body.blog-page">
	<div class="notice">Welcome to our new blog</div>
</before>
```

## ちょっとコンテンツを変更する
<replace />を使用して、含めるコンテンツを変更することは可能です。

例えば：
```
<replace css:content="div#portal-searchbox input.searchButton">
	<button type="submit">
		<img src="images/search.png" alt="Search" />
	</button>
</replace>
```
これは、条件とインラインXSLTと組み合わせることができます。

## インラインXSLディレクティブ
ルール内でインラインXSLディレクティブを指定して、最終出力を調整することができます。 たとえば、出力文書からスペースを取り除くには、次のようにします。
```
<xsl:strip-space elements="*" />
```
（注：これはブラウザのページのレンダリングに影響する可能性があります）。
インラインXSLディレクティブは、ルート<rules>タグの内部に直接配置し、無条件に適用する必要があります。

## Doctypes
デフォルトでは、Diazoは出力ページをXHTML 1.0 Transitional doctypeで変換します。 厳密なdoctypeを使用するには、このインラインXSLをインクルードします。
```
<xsl:output
	doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
	doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
```
XHTML 1.0 StrictとXHTML 1.0 Transitionalのdoctypesだけがlibxml2のXMLシリアライザの特別なXHTML互換モードを起動することに注意することが重要です。これにより、 <br />および<div />として<div> </ div>としてレンダリングされます。これは、ブラウザがドキュメントをHTMLとして正しく解析するために必要です。
HTML5のdoctypeをXSLTから設定することはできないので、plone.app.themingと含まれるWSGIミドルウェアにはdoctypeオプションが含まれています。これは "<！DOCTYPE html>"に設定されています。

## Xinclude

ルールファイルの要素を複数のテーマにわたって再利用したい場合があります。 これは、特定のウェブサイトで異なるページのスタイルを設定するために同じテーマに複数のバリエーションがある場合に特に便利です。
ルールファイルは、XIncludeプロトコルを使用して含めることができます。
インクルードでは、標準のXInclude構文を使用します。 例えば：
```
<rules
	xmlns="http://namespaces.plone.org/diazo"
	xmlns:css="http://namespaces.plone.org/diazo/css"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:xi="http://www.w3.org/2001/XInclude">

	<xi:include href="standard-rules.xml" />

</rules>
```

## 外部コンテンツを取り込む

通常、任意のルールのcontent属性は、基礎となる動的Webサーバーによって返される応答からノードを選択します。 ただし、任意のルール（ <drop />以外）にhref属性を使用して別のURLのコンテンツを含めることは可能です。 例えば：
 ```
<after css:theme-content="#left-column" css:content="#portlet" href="/extra.html"/>
```
これにより、URL `/extra.html`が解決され、ID ポートレットを持つ要素が検索され、テーマのidがleft-columnの要素に追加されます。
コンテンツの取り込みは、次の3つの方法のいずれかで発生します。

### XSLT document（）関数の使用 
これはデフォルトですが、ルール要素に属性`method = "document"`を追加することで明示的に指定できます。 これがURLを解決できるかどうかは、コンパイルされたXSLTの実行方法と場所によって異なります。
```
<after css:theme-children="#left-column" css:content="#portlet"
		href="/extra.html" method="document" />
```

### サーバ側の取り込み命令の利用
これは、 method属性をssiに設定することで指定できます。
```
<after css:theme-children="#left-column" css:content="#portlet"
		href="/extra.html" method="ssi"/>
```
出力は次のようにレンダリングされます：
```
<!--#include virtual="/extra.html?;filter_xpath=descendant-or-self::*[@id%20=%20'portlet']"-->
```
このSSI命令は、ApacheやNginxのような最先端のWebサーバーで処理する必要があります。 また、filter_xpathクエリ文字列パラメータにも注意してください。コンパイルされたDiazo XSLT変換が実行された後にSSI処理が行われるまで、参照される文書の解決を延期するので、SSIプロセッサに、私たちが興味のないファイルの要素を除外するように要求する必要があります。特定の構成。 Nginxの例を以下に示します。

ドキュメント全体の単純なSSIインクルードの場合、ルールからコンテンツセレクタを省略することができます。
```
<append css:theme="#left-column" href="/extra.html" method="ssi"/>
```
出力は次のようにレンダリングされます。
```
<!--#include virtual="/extra.html"-->
```
Nginxのいくつかのバージョンでは、 wait = "yes" ssiオプションが安定している必要があります。 これは、 method属性をssiwaitに設定することで指定できます。

### エッジ側の取り込み命令の利用
これは、 method属性をesiに設定することで指定できます。
```
<after css:theme-content="#left-column" css:content="#portlet"
		href="/extra.html" method="esi"/>
```
出力はSSIモードの場合と似ています。
```
<esi:include src="/extra.html?;filter_xpath=descendant-or-self::*[@id%20=%20'portlet']"></esi:include>
```
ここでも、指令はワニスなどの前処理サーバーで処理する必要があります。 ESIを意識したキャッシュサーバーが任意のXPathフィルタリングをサポートしない可能性があります。 参照されたファイルが動的Webサーバーによって提供されている場合は、 ; filter_xpathパラメーターを検査し、調整された応答を返すことができます。 そうでない場合、これを認識できるサーバがキャッシュサーバとその下にあるWebサーバの間に配置されている場合、そのサーバは必要なフィルタリングを実行できます。
単純なESIに文書全体を含める場合は、ルールからコンテンツセレクタを省略することができます。
```
<append css:theme="#left-column" href="/extra.html" method="esi"/>
```
出力は次のようにレンダリングされます。
```
<esi:include src="/extra.html"></esi:include>
```
