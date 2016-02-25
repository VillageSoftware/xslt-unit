<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	exclude-result-prefixes="msxsl"
>

	<!-- Don't change these bits -->
	<!-- Output as HTML -->
	<xsl:output
		method="html"
		encoding="utf-8"
		doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<!-- Include the unit testing tools -->
	<xsl:include href="unitTestHelper.xslt"/>

	<!-- ==== CONFIGURE THESE BITS ==== -->
	<!-- Include the XSLT files which contain the logic you want to test -->
	<xsl:include href="ExampleLogic.xslt"/>

	<!-- Keep this list up to date with your tests defined below -->
	<!-- Change the MATCH to = top level node type of your data -->
	<xsl:template match="task">
		<xsl:call-template name="british_date_to_iso_date"/>
		<xsl:call-template name="short-number-rounded-to-2-dp"/>
		<xsl:call-template name="long-number-rounded-up-to-2-dp"/>
		<xsl:call-template name="long-number-rounded-level-to-2-dp"/>
		<xsl:call-template name="test-built-to-fail"/>
	</xsl:template>
		
	<!-- This is a test -->
	<xsl:template name="british_date_to_iso_date">
		<!-- Run the target template to get the actual result -->
		<xsl:variable name="actual">
			<xsl:call-template name="to-iso-8601">
				<xsl:with-param name="british-date-time" select="string('24/04/2015 07:22:00')"/>
			</xsl:call-template> 
		</xsl:variable>
		
		<!-- Pass the expected value, actual, and the name of the test into the assert function -->
		<xsl:call-template name="assert-equal">
			<xsl:with-param name="expected" select="'2015-04-24T07:22:00Z'"/>
			<xsl:with-param name="actual" select="string($actual)"/>
			<xsl:with-param name="test-name" select="'british_date_to_iso_date'"/>
		</xsl:call-template>
	</xsl:template>
	
	<!-- This is another test -->
	<xsl:template name="short-number-rounded-to-2-dp">
	
		<xsl:variable name="actual">
			<xsl:call-template name="rounded-to-2dpl">
				<xsl:with-param name="value" select="1.5"/>
			</xsl:call-template> 
		</xsl:variable>
		
		<xsl:call-template name="assert-equal">
			<xsl:with-param name="expected" select="1.50"/>
			<xsl:with-param name="actual" select="string($actual)"/>
			<xsl:with-param name="test-name" select="'short-number-rounded-to-2-dp'"/>
		</xsl:call-template>
		
	</xsl:template>

	<!-- And another test of the same template -->
	<xsl:template name="long-number-rounded-up-to-2-dp">
	
		<xsl:variable name="actual">
			<xsl:call-template name="rounded-to-2dpl">
				<xsl:with-param name="value" select="2.8565"/>
			</xsl:call-template> 
		</xsl:variable>
		
		<xsl:call-template name="assert-equal">
			<xsl:with-param name="expected" select="2.86"/>
			<xsl:with-param name="actual" select="string($actual)"/>
			<xsl:with-param name="test-name" select="'long-number-rounded-up-to-2-dp'"/>
		</xsl:call-template>
		
	</xsl:template>
	
	<!-- And another test of the same template -->
	<xsl:template name="long-number-rounded-level-to-2-dp">
	
		<xsl:variable name="actual">
			<xsl:call-template name="rounded-to-2dpl">
				<xsl:with-param name="value" select="2.4444"/>
			</xsl:call-template> 
		</xsl:variable>
		
		<xsl:call-template name="assert-equal">
			<xsl:with-param name="expected" select="2.44"/>
			<xsl:with-param name="actual" select="string($actual)"/>
			<xsl:with-param name="test-name" select="'long-number-rounded-level-to-2-dp'"/>
		</xsl:call-template>
		
	</xsl:template>
	
	<!-- This test fails -->
	<xsl:template name="test-built-to-fail">
	
		<xsl:variable name="actual">
			<xsl:call-template name="rounded-to-2dpl">
				<xsl:with-param name="value" select="Eggs"/>
			</xsl:call-template> 
		</xsl:variable>
		
		<xsl:call-template name="assert-equal">
			<xsl:with-param name="expected" select="1.5"/>
			<xsl:with-param name="actual" select="string($actual)"/>
			<xsl:with-param name="test-name" select="'test-built-to-fail'"/>
		</xsl:call-template>
		
	</xsl:template>

</xsl:stylesheet>
