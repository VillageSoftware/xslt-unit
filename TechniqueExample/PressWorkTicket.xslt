<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:msxsl="urn:schemas-microsoft-com:xslt"
	exclude-result-prefixes="msxsl">
	
	<!--
	********************************************************
	This is a cut-down version of a work ticket,  
	showing how an XSLT template may be called in production
	********************************************************
	-->

	<xsl:output method="html" indent="yes"
              encoding="utf-8"
              doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
              doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" />

	<!-- Include XSL files used by this one -->
	<xsl:include href="Imposition.xslt"/>

	<xsl:template match="order">
		<html xmlns="http://www.w3.org/1999/xhtml">
			<head>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<title>Work Ticket</title>
			</head>
			<body>
				<xsl:call-template name="press-layout">
					<xsl:with-param name="order" select="/order"/>
				</xsl:call-template>
				<xsl:call-template name="samplesource">
				</xsl:call-template>
			</body >
		</html>
	</xsl:template>

	<xsl:template name="press-layout">
		<xsl:param name="order"/>

		<div class="MainBody" style="font-family:Arial, Helvetica, sans-serif; font-size:12px;">
			<table width="745">
				<tr>
					<td width="245">
						<xsl:value-of select="$order/cust_name"/>
					</td>
					<td width="245" style=" font-size:20px" align="center">
						<xsl:value-of select="$order/job_no"/>
						<br />Press Work Ticket
						<br />
						<span style="font-size:12px">
							Status: <xsl:value-of select="$order/job_status"/>
						</span>
					</td>
					<td width="245">
					</td>
				</tr>
				<xsl:if test="$order/job_bag_ready='False'">
					<tr>
						<td colspan="3" style="font-size:16px; font-weight:bold;" align="center">DRAFT</td>
					</tr>
				</xsl:if>
			</table>
			<br/>
			<br/>
		</div>

		<xsl:call-template name="show-folio">
			<xsl:with-param name="order" select="/order"/>
		</xsl:call-template>
	</xsl:template>

	<xsl:template name="show-folio">
		<xsl:text>Folios appear in the xml as pairs. For example, a cover might be 1-2,59-60 for a 60 page magazine</xsl:text>
		<br/>
		<xsl:text>However there may be a single range of pages (shown as '27-74' or '27-74,-');</xsl:text> 
		<xsl:text>missing midpoints '51-,-82';</xsl:text>
		<xsl:text>or an apparent pair '3-22, 23-32' which is really a single range.</xsl:text>
		<br/>
		<br/>
		<xsl:text>In this example, the folios looks separate but really run into each other: </xsl:text>
		<xsl:value-of select="/order/mow_folio_should_be_continuous/press_mow/mow_press_delivery/task_folio"/>
		<br/>
		<xsl:text>And after correct formatting should look like this: </xsl:text>
		<xsl:call-template name="formatfolio">
			<xsl:with-param name="folio" select="/order/mow_folio_should_be_continuous/press_mow/mow_press_delivery/task_folio"/>
		</xsl:call-template>
		<br/>
		</xsl:template>
	
	<xsl:template name="samplesource">
		<table width="745" border="1">
			<tr style="background-color:#CCC;">
				<td colspan="3">
					Press Delivery - 56pp 4e1u [R] PR
				</td>
			</tr>
			<tr>
				<td>Folder</td>
				<td width="212"/>
				<td width="212">
					<span style="font-weight:bold; font-size:16px;">RIGHT</span>
				</td>
			</tr>
			<tr>
				<td>Pagination:</td>
				<td/>
				<td>56</td>
			</tr>
			<tr>
				<td>Print Ups:</td>
				<td/>
				<td>1</td>
			</tr>
			<tr>
				<td>Folios:</td>
				<td/>
				<td>1-56</td>
			</tr>
			<tr>
				<td>Press Finishing Style:</td>
				<td/>
				<td>Press Finished Stitched</td>
			</tr>
			<tr>
				<td>Ribbons:</td>
				<td/>
				<td>7</td>
			</tr>
			<tr>
				<td>Description:</td>
				<td/>
				<td>56pp Text [R]</td>
			</tr>
		</table>
<br/>
<table width="745" border="1">
	<tr style="background-color:#CCC;">
		<td colspan="6">Version Info</td>
	</tr>
	<tr>
		<td>Sub job</td>
		<td>Version ID</td>
		<td>Version Desc</td>
		<td>Sub Job Desc</td>
		<td>Inner/Outer</td>
		<td>Data Approved On</td>
	</tr>
	<tbody>
		<tr>
			<td>AB2111213-001</td>
			<td>COMM</td>
			<td>Common</td>
			<td>56pp Text [R]</td>
			<td>4/4</td>
			<td>10/01/2016 12:00:00</td>
		</tr>
	</tbody>
</table>
<br/>
<table width="745" border="1" style="page-break-inside:avoid;">
	<tr>
		<td style="background-color:#CCC;" colspan="7">Paper Info</td>
	</tr>
	<tr>
		<td>Sub Job</td>
		<td>Paper Width</td>
		<td>Paper Brand</td>
		<td>Paper Grade</td>
		<td>GSM</td>
	</tr>
	<tbody>
		<tr>
			<td>Common</td>
			<td>2140</td>
			<td>PaperBrand</td>
			<td>PP/gg</td>
			<td>57</td>
		</tr>
	</tbody>
</table>
<br/>
<table>
	<tr>
		<td>
			<table width="350" border="1" style="page-break-inside:avoid;">
				<tr xmlns="">
					<td style="background-color:#CCC;" colspan="4">Imposition</td>
				</tr>
				<tr xmlns="">
					<td align="center">3 mm
					</td>
					<td align="center">300 mm
					</td>
					<td align="center">3 mm
					</td>
					<td> </td>
				</tr>
				<tr xmlns="">
					<td/>
					<td style="background-color:#FF0000;"/>
					<td/>
					<td>3 mm
					</td>
				</tr>
				<tr height="50" xmlns="">
					<td/>
					<td style="background-color:#CCC;"/>
					<td/>
					<td>215 mm
					</td>
				</tr>
				<tr xmlns="">
					<td/>
					<td/>
					<td/>
					<td>0 mm
					</td>
				</tr>
				<tr xmlns="">
					<td/>
					<td/>
					<td/>
					<td>0 mm
					</td>
				</tr>
				<tr height="50" xmlns="">
					<td/>
					<td style="background-color:#CCC;"/>
					<td/>
					<td>215 mm
					</td>
				</tr>
				<tr xmlns="">
					<td/>
					<td style="background-color:#FF0000;"/>
					<td/>
					<td>3 mm
					</td>
				</tr>
			</table>
		</td>
		<td/>
	</tr>
</table>
</xsl:template>
</xsl:stylesheet>

