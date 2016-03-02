<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	exclude-result-prefixes="msxsl">

<!--
***************************************************************
This is a cut-down version of a unit test suite,
showing how an XSLT template may be called in for unit testing
***************************************************************
-->

	<!-- Output as HTML -->
	<xsl:output
		method="html"
		encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<!-- Include the unit testing tools -->
	<xsl:include href="../lib/unitTestHelper.xslt"/>

	<!-- ==== CONFIGURE THESE BITS ==== -->
	<!-- Include the XSLT files which contain the logic you want to test -->
	<xsl:include href ="Imposition.xslt"/>
		
	<!-- Keep this list up to date with your tests defined below -->
	<!-- Change the MATCH to = top level node type of your data -->
	<xsl:template match="order">
		<xsl:call-template name="folioTests"/>
	</xsl:template>

	<xsl:template name="folioTests">
		<xsl:text>
			Writing a test that fails, in order to illustrate the issue:
		</xsl:text>
		<br/>
		<xsl:text>
			In this case, the original issue was that folio pair 1 and 2 are consecutive. They should show as a single range.
		</xsl:text>
		
		<xsl:call-template name="originalfoliopair1and2consecutiveFails"/>

		<br/>
		<xsl:text>And the unit tests that prove the fix:</xsl:text>
		<br/>
		
		<!-- Folios appear in the xml as pairs. For example, a cover might be 1-2,59-60 for a 60 page magazine-->
		<!-- However there may be a single range of pages (shown as '27-74' or '27-74,-'); missing midpoints '51-,-82';
		or apparently two pairs '3-22, 23-32' which is really a single range-->
		<xsl:call-template name="folioallspecifiedShouldFormat"/>
		<xsl:call-template name="foliopair1and2consecutiveShouldFormat"/>
		<!--
		<xsl:call-template name="folio1st2ndspecifiedShouldFormat"/>
		<xsl:call-template name="folio1st2ndnocommaspecifiedShouldFormat"/>
		<xsl:call-template name="folio1st4thspecifiedShouldFormat"/>
		etcetera  -->
		
	</xsl:template>

	<xsl:template name="originalfoliopair1and2consecutiveFails">
		<!-- This test case also illustrates retrieving the data from an order fragment.-->
		<xsl:variable name="actual">
			<xsl:call-template name="formatfolio-original">
				<xsl:with-param name="folio" select="/order/mow_folio_should_be_continuous/press_mow/mow_press_delivery/task_folio"/>
			</xsl:call-template>
		</xsl:variable >
		<xsl:call-template name="assert-equal">
			<xsl:with-param name="expected" select="'1-56'"/>
			<xsl:with-param name="actual" select="$actual"/>
			<xsl:with-param name="test-name" select="'originalfoliopair1and2consecutiveFails'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="folioallspecifiedShouldFormat">
		<xsl:variable name="formattedfolioallspecified">
			<xsl:call-template name="formatfolio">
				<xsl:with-param name="folio" select="'3-26,75-98'"/>
			</xsl:call-template>
		</xsl:variable >
		<xsl:call-template name="assert-equal">
			<xsl:with-param name="expected" select="'3-26,75-98'"/>
			<xsl:with-param name="actual" select="$formattedfolioallspecified"/>
			<xsl:with-param name="test-name" select="'folioallspecifiedShouldFormat'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="folio1st2ndspecifiedShouldFormat">
		<xsl:variable name="actual">
			<xsl:call-template name="formatfolio">
				<xsl:with-param name="folio" select="'27-74,-'"/>
			</xsl:call-template>
		</xsl:variable >
		<xsl:call-template name="assert-equal">
			<xsl:with-param name="expected" select="'27-74'"/>
			<xsl:with-param name="actual" select="$actual"/>
			<xsl:with-param name="test-name" select="'folio1st2ndspecifiedShouldFormat'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="folio1st2ndnocommaspecifiedShouldFormat">
		<xsl:variable name="actual">
			<xsl:call-template name="formatfolio">
				<xsl:with-param name="folio" select="'27-74'"/>
			</xsl:call-template>
		</xsl:variable >
		<xsl:call-template name="assert-equal">
			<xsl:with-param name="expected" select="'27-74'"/>
			<xsl:with-param name="actual" select="$actual"/>
			<xsl:with-param name="test-name" select="'folio1st2ndnocommaspecifiedShouldFormat'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="foliopair1and2consecutiveShouldFormat">
		<xsl:variable name="actual">
			<xsl:call-template name="formatfolio">
				<xsl:with-param name="folio" select="'3-22, 23-32'"/>
			</xsl:call-template>
		</xsl:variable >
		<xsl:call-template name="assert-equal">
			<xsl:with-param name="expected" select="'3-32'"/>
			<xsl:with-param name="actual" select="$actual"/>
			<xsl:with-param name="test-name" select="'foliopair1and2consecutiveShouldFormat'"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="folio1st4thspecifiedShouldFormat">
		<xsl:variable name="actual">
			<xsl:call-template name="formatfolio">
				<xsl:with-param name="folio" select="'51-,-82'"/>
			</xsl:call-template>
		</xsl:variable >
		<xsl:call-template name="assert-equal">
			<xsl:with-param name="expected" select="'51-82'"/>
			<xsl:with-param name="actual" select="$actual"/>
			<xsl:with-param name="test-name" select="'folio1st4thspecifiedShouldFormat'"/>
		</xsl:call-template>
	</xsl:template>

</xsl:stylesheet>
