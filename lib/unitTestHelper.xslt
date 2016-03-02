<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt" exclude-result-prefixes="msxsl"
>

  <xsl:template name="assert-equal">
    <xsl:param name="expected"/>
    <xsl:param name="actual"/>
    <xsl:param name="test-name"/>
    <xsl:choose >
      <xsl:when test="string($expected)=string($actual)">
        <div style="color:green;">Pass: <xsl:value-of select="$test-name"/></div>
      </xsl:when>
      <xsl:otherwise >
        <p style="color:red;">Fail: <xsl:value-of select="$test-name"/>
          <br/>  <xsl:value-of select="$expected"/> expected,
          <br/>  <xsl:value-of select="$actual"/> calculated,
        </p>
      </xsl:otherwise>
    </xsl:choose>
  </xsl:template>

</xsl:stylesheet>
