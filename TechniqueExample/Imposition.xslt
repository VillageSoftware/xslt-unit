<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	exclude-result-prefixes="msxsl">

  <xsl:template name="formatfolio-original">
    <xsl:param name="folio"/>
    <xsl:param name="pagination"/>
    <xsl:value-of select ="string($folio)"/>
  </xsl:template>
 
  <xsl:template name="formatfolio">
    <xsl:param name="folio"/>
    <xsl:param name="pagination"/>
    <xsl:variable name="firstpair">
      <xsl:choose>
      <xsl:when test="contains($folio,',')">
        <xsl:value-of select ="substring-before($folio,',')"/>
      </xsl:when>
        <xsl:otherwise >
          <xsl:value-of select ="string($folio)"/>
        </xsl:otherwise>
      </xsl:choose>
    </xsl:variable> 
    <xsl:variable name="secondpair" select="substring-after($folio,',')"/>
    <xsl:variable name="folio1" select="substring-before($firstpair,'-')"/>
    <xsl:variable name="folio2" select="substring-after($firstpair,'-')"/>
    <xsl:variable name="folio3" select="substring-before($secondpair,'-')"/>
    <xsl:variable name="folio4" select="substring-after($secondpair,'-')"/>
    <xsl:choose>
      <!-- if we can't parse it, just return what's there (e.g. 'C1-C4', not numeric)-->
      <xsl:when test="string($folio1)='NaN'">
        <xsl:value-of select="$folio"/>
      </xsl:when>
      <!-- Pick out first and last folios if folio 2 and 3 are consecutive -->
      <xsl:when test="number($folio2) + 1 = number($folio3)">
        <xsl:value-of select="$folio1"/>-<xsl:value-of select="$folio4"/>
      </xsl:when>
      <!-- Pick out first and last folios if folio 2 and 3 are missing -->
      <xsl:when test="string($folio1)!='' and string($folio2)='' and string($folio3)='' and string($folio4)!=''">
        <xsl:value-of select="$folio1"/>-<xsl:value-of select="$folio4"/>
      </xsl:when>
      <!-- Pick out first and second folios if folio 3 and 4 are missing -->
      <xsl:when test="string($folio1)!='' and string($folio2)!='' and string($folio3)='' and string($folio4)=''">
        <xsl:value-of select="$folio1"/>-<xsl:value-of select="$folio2"/>
      </xsl:when>
      <!-- Pick out first plus pagination if folios 2,3 and 4 are missing -->
      <xsl:when test="string($folio1)!='' and string($folio2)='' and string($folio3)='' and string($folio4)=''">
        <xsl:value-of select="$folio1"/>-<xsl:value-of select="number($folio1)+number($pagination)-1"/>
      </xsl:when>
      <xsl:otherwise>
        <xsl:value-of select="$folio"/>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
