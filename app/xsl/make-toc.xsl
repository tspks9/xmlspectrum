<xsl:stylesheet version="2.0"
xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
xmlns:xs="http://www.w3.org/2001/XMLSchema"
xmlns:loc="com.qutoric.sketchpath.functions"
exclude-result-prefixes="loc f xs"
xmlns=""
xmlns:f="internal">


<xsl:template name="create-toc">
<xsl:param name="globals" as="element()" tunnel="yes"/>
<xsl:param name="output-path"/>
<xsl:param name="css-link"/>

<xsl:result-document href="{concat($output-path, 'index.html')}" method="html" indent="no">
<xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
<html>
<head>
<title><xsl:value-of select="'Summary View'"/></title>
<link rel="stylesheet" type="text/css" href="{$css-link}"/>
</head>
<body>
<div class="spectrum-toc">
<p class="av">
<span class="z">(HTML code rendering by XMLSpectrum)</span>
</p>
<h3>
<span class="av">Global XSLT Module Members</span>
</h3>
<p class="av">
<xsl:variable name="epath" select="($globals/file)[1]/@path"/>
<a class="solar" href="{concat($epath,'.html')}">
<span class="av">Entry file: <xsl:value-of select="$epath"/></span>
</a>
</p>

<ul class="spectrum-toc">
<xsl:apply-templates select="$globals/file" mode="toc"/>
</ul>
</div>
</body>
</html>
</xsl:result-document>

</xsl:template>

<xsl:template match="file" mode="toc">

<li>
<a class="solar" href="{concat(@path,'.html')}">
<span class="blue">File: <xsl:value-of select="@path"/>
</span>
</a>
</li>
<ul class="spectrum-toc">
<xsl:if test="exists(templates/item)">
<li>
<span class="en">Templates</span>
<ul>
<xsl:apply-templates select="templates/item" mode="toc">
<xsl:with-param name="path" select="@path"/>
</xsl:apply-templates>
</ul>
</li>
</xsl:if>
<xsl:if test="exists(functions/item)">
<li>
<span class="fname">Functions</span>
<ul>
<xsl:apply-templates select="functions/item" mode="toc">
<xsl:with-param name="path" select="@path"/>
</xsl:apply-templates>
</ul>
</li>
</xsl:if>
<xsl:if test="exists(variables/item)">
<li>
<span class="vname">Variables</span>
<ul>
<xsl:apply-templates select="variables/item" mode="toc">
<xsl:with-param name="path" select="@path"/>
</xsl:apply-templates>
</ul>
</li>
</xsl:if>
<xsl:if test="not(exists(*/item))">
<li><span>[None]</span></li>
</xsl:if>
</ul>

</xsl:template>

<xsl:template match="item" mode="toc">
<xsl:param name="path"/>
<xsl:variable name="char" select="substring(local-name(..),1, 1)"/>
<xsl:variable name="ns" select="substring(substring-before(., '}'), 2)"/>
<xsl:variable name="name" select="if ($ns eq '') then
  string(.)  
else
    substring-after(., '}')
"/>
<li>
<a class="solar" href="{concat($path, '.html', '#',$char,'?', string(.))}">
<span class="atn"><xsl:value-of select="$name"/></span>
</a>
</li>
</xsl:template>

</xsl:stylesheet>
