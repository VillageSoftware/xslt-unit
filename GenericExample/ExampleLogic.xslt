<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	exclude-result-prefixes="msxsl"
>
	<!-- Our transformations -->
	
	<!-- Master template -->
	<xsl:template match="task">
		
		<html>
			<head>
				<title>Report for task <xsl:value-of select="task_name"/></title>
			</head>
			<body>
				<h1>Task: <xsl:value-of select="task_name"/></h1>
				
				Started:
				<time>
					<xsl:call-template name="to-iso-8601">
						<xsl:with-param name="british-date-time" select="uk_time_started"/>
					</xsl:call-template>
				</time>
				
				<p>
					<xsl:call-template name="rounded-to-2dpl">
						<xsl:with-param name="value" select="meters_width"/>
					</xsl:call-template>m width (2dp)
				</p>
				
				<h2>Resources:</h2>
				<xsl:call-template name="resources-table">
					<xsl:with-param name="resources" select="resources"/>
				</xsl:call-template>
				
			</body>
		</html>
		
	</xsl:template>

	<!-- Sub-templates -->
	<xsl:template name="resources-table">
		<xsl:param name="resources"/>
		
		<table>
			<thead>
				<tr>
					<th>Name</th>
					<th>Qty</th>
				</tr>
			</thead>
			<tbody>
				<xsl:for-each select="$resources/resource">
					<xsl:call-template name="resource-row">
						<xsl:with-param name="resource" select="."/>
					</xsl:call-template>
				</xsl:for-each>
			</tbody>
		</table>
		
	</xsl:template>
	
	<xsl:template name="resource-row">
		<xsl:param name="resource"/>
		
		<tr>
			<td><xsl:value-of select="@name"/></td>
			<td><xsl:value-of select="."/></td>
		</tr>
		
	</xsl:template>
	
	
	<!-- ==== Utility routines ==== -->

	<xsl:template name="to-iso-8601">
		<xsl:param name="british-date-time"/>
		<xsl:value-of select="concat(substring($british-date-time,7,4), '-',
								substring($british-date-time,4,2), '-',
								substring($british-date-time,1,2), 'T',
							    substring($british-date-time,12,8), 'Z')"/>
	</xsl:template>

	<xsl:template name="rounded-to-2dpl">
		<xsl:param name="value"/>
		<xsl:value-of select="number(format-number($value,'##.00'))"/>
	</xsl:template>

</xsl:stylesheet>
