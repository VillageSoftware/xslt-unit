# xslt-unit

Standalone unit testing for XSLT, written in XSLT.

## Setup

You have your source data, `Data.xml` which you would normally transform with `BusinessLogic.xslt` either by including it as an `xml-stylesheet` or by processing it with a tool like Technique. Your `BusinessLogic.xslt` may pull in other xsl files which it uses.

In order for code to be unit-testable, it needs to be split up into small components which can be tested individually. In XSLT, we expect your business code to be split into `template`s. 

To run tests, you will create unit test definitions in an xslt file, as described below, and use this as the `xml-stylesheet` on your data, instead of the usual BusinessLogic.


## The unit tests file

For example test definitions, and file structure, see `MyTests.xslt`.
You can give your tests file any name.

The tests file must:

 - [x] Include the unit testing tools `<xsl:include href="unitTestHelper.xslt"/>`
 - [x] Include the XSLT you want to test `<xsl:include href="MyTransformation.xslt"/>`
 - [x] Contain a series of tests implemented as templates
 - [x] Contain a template `match`ing your top-level node which calls all the tests
 
 
## Anatomy of a test

Please see `MyTests.xslt` for more commented examples.

	<!-- This is a test -->
	<xsl:template name="long-number-rounded-up-to-2-dp">
		<!-- Run the target template to get the actual result -->
		<xsl:variable name="actual">
			<!-- Call whatever template you want to test here. You can hardcode data or use a value from the data that you're transforming -->
			<xsl:call-template name="rounded-to-2dpl">
				<!-- Pass in fixture data -->
				<xsl:with-param name="value" select="2.8565"/>
			</xsl:call-template> 
		</xsl:variable>
		
		<!-- Pass the expected value, actual value, and the name of the test into the assert function -->
		<xsl:call-template name="assert-equal">
			<xsl:with-param name="expected" select="2.86"/>
			<xsl:with-param name="actual" select="string($actual)"/>
			<xsl:with-param name="test-name" select="'long-number-rounded-up-to-2-dp'"/>
		</xsl:call-template>
		
	</xsl:template>

	
## Running tests

In your `Data.xml`, set:

	<?xml-stylesheet type="text/xsl" href="MyTests.xslt"?>

It would be nice to automate this.


## Scope

Currently the `unitTestHelper.xslt` only contains the `assert-equal` method.
We may expand this in future as our needs grow.

----------

## Contact

We are [Village Software][VS], we were established in 1986, and we we write enterprise-grade software! We believe that all software should be well tested, even XSLT. Please visit our website or get in touch with us, [thinkingahead@villagesoftware.co.uk][email]

[VS]: http://villagesoftware.co.uk
[email]: mailto://thinkingahead@villagesoftware.co.uk

## License

The MIT License (MIT)  
See LICENSE.md