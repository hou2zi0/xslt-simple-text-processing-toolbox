<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:output="http://www.w3.org/2010/xslt-xquery-serialization"
    xmlns:office="urn:oasis:names:tc:opendocument:xmlns:office:1.0"
    xmlns:style="urn:oasis:names:tc:opendocument:xmlns:style:1.0"
    xmlns:text="urn:oasis:names:tc:opendocument:xmlns:text:1.0"
    xmlns:table="urn:oasis:names:tc:opendocument:xmlns:table:1.0"
    xmlns:draw="urn:oasis:names:tc:opendocument:xmlns:drawing:1.0"
    xmlns:fo="urn:oasis:names:tc:opendocument:xmlns:xsl-fo-compatible:1.0"
    xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:dc="http://purl.org/dc/elements/1.1/"
    xmlns:meta="urn:oasis:names:tc:opendocument:xmlns:meta:1.0"
    xmlns:number="urn:oasis:names:tc:opendocument:xmlns:datastyle:1.0"
    xmlns:svg="urn:oasis:names:tc:opendocument:xmlns:svg-compatible:1.0"
    xmlns:chart="urn:oasis:names:tc:opendocument:xmlns:chart:1.0"
    xmlns:dr3d="urn:oasis:names:tc:opendocument:xmlns:dr3d:1.0"
    xmlns:math="http://www.w3.org/1998/Math/MathML"
    xmlns:form="urn:oasis:names:tc:opendocument:xmlns:form:1.0"
    xmlns:script="urn:oasis:names:tc:opendocument:xmlns:script:1.0"
    xmlns:config="urn:oasis:names:tc:opendocument:xmlns:config:1.0"
    xmlns:ooo="http://openoffice.org/2004/office" xmlns:ooow="http://openoffice.org/2004/writer"
    xmlns:oooc="http://openoffice.org/2004/calc" xmlns:dom="http://www.w3.org/2001/xml-events"
    xmlns:xforms="http://www.w3.org/2002/xforms" xmlns:xsd="http://www.w3.org/2001/XMLSchema"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xmlns:rpt="http://openoffice.org/2005/report"
    xmlns:of="urn:oasis:names:tc:opendocument:xmlns:of:1.2"
    xmlns:xhtml="http://www.w3.org/1999/xhtml" xmlns:grddl="http://www.w3.org/2003/g/data-view#"
    xmlns:officeooo="http://openoffice.org/2009/office"
    xmlns:tableooo="http://openoffice.org/2009/table"
    xmlns:drawooo="http://openoffice.org/2010/draw"
    xmlns:calcext="urn:org:documentfoundation:names:experimental:calc:xmlns:calcext:1.0"
    xmlns:loext="urn:org:documentfoundation:names:experimental:office:xmlns:loext:1.0"
    xmlns:field="urn:openoffice:names:experimental:ooo-ms-interop:xmlns:field:1.0"
    xmlns:formx="urn:openoffice:names:experimental:ooxml-odf-interop:xmlns:form:1.0"
    xmlns:css3t="http://www.w3.org/TR/css3-text/" exclude-result-prefixes="#all" version="3.0">
    <xsl:output indent="yes" method="html"/>
    <xsl:mode on-no-match="shallow-copy"/>


    <xsl:variable name="auto-styles" select="/office:document/office:automatic-styles"/>

    <xsl:variable name="meta">
        <head>
            <title>
                <xsl:if test="/office:document/office:meta/dc:title">
                    <xsl:value-of select="/office:document/office:meta/dc:title"/>
                </xsl:if>
            </title>
        </head>
    </xsl:variable>
    
    <xsl:variable name="metadata">
        <div class="main-metadata" style="border: 1px solid black; padding: 1em 2em 1em 2em;">
            <xsl:if test="/office:document/office:meta/dc:title">
                <h2 class="title">
                    <xsl:value-of select="/office:document/office:meta/dc:title"/>
                </h2>
            </xsl:if>
            <xsl:if test="/office:document/office:meta/dc:subject">
                <h3 class="subject">
                <xsl:value-of select="/office:document/office:meta/dc:subject"/>
            </h3>
            </xsl:if>
            <xsl:if test="/office:document/office:meta/dc:description">
                <p class="description">
                <xsl:value-of select="/office:document/office:meta/dc:description"/>
            </p>
            </xsl:if>
        <xsl:if test="/office:document/office:meta/meta:keyword">
            <ul>
                <xsl:for-each select="/office:document/office:meta/meta:keyword">
                    <li>
                        <xsl:value-of select="."/>
                    </li>
                </xsl:for-each>
            </ul>
        </xsl:if>
        <xsl:if test="/office:document/office:meta/meta:initial-creator">
             <p class="description">
                 <xsl:value-of select="/office:document/office:meta/meta:initial-creator"/>
             </p>
        </xsl:if>
        <xsl:if test="/office:document/office:meta/dc:creator">
                <p class="description">
                    <xsl:value-of select="/office:document/office:meta/dc:creator"/>
                </p>
         </xsl:if>
        </div>
    </xsl:variable>

    <xsl:template match="/">
        <html>
            <xsl:copy-of select="$meta"/>
            <body>
                <xsl:copy-of select="$metadata"/>
                <xsl:apply-templates select="office:document/office:body/office:text/child::*"/>
            </body>
        </html>
    </xsl:template>

    <!-- Empty Nodes -->
    <xsl:template match="office:forms"/>
    <xsl:template match="text:sequence-decls"/>

    <xsl:template match="*">
        <xsl:variable name="elementName">
            <xsl:choose>
                <xsl:when test="local-name(.) = 'h'">
                    <xsl:choose>
                        <xsl:when test="@*:outline-level = '1'">
                            <xsl:text>h1</xsl:text>
                        </xsl:when>
                        <xsl:when test="@*:outline-level = '2'">
                            <xsl:text>h2</xsl:text>
                        </xsl:when>
                        <xsl:when test="@*:outline-level = '3'">
                            <xsl:text>h3</xsl:text>
                        </xsl:when>
                        <xsl:when test="@*:outline-level = '4'">
                            <xsl:text>h4</xsl:text>
                        </xsl:when>
                        <xsl:when test="@*:outline-level = '5'">
                            <xsl:text>h5</xsl:text>
                        </xsl:when>
                        <xsl:when test="@*:outline-level = '6'">
                            <xsl:text>h6</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>h1</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:when>
                <xsl:when test="local-name(.) = 'p' and ./ancestor::*:p">
                    <xsl:text>false</xsl:text>
                </xsl:when>
                <xsl:when test="local-name(.) = 'p'">
                    <xsl:text>p</xsl:text>
                </xsl:when>
                <xsl:when test="local-name(.) = 'span'">
                    <xsl:text>span</xsl:text>
                </xsl:when>
                <xsl:when test="local-name(.) = 'list'">
                    <xsl:text>ul</xsl:text>
                </xsl:when>
                <xsl:when test="local-name(.) = 'list-item'">
                    <xsl:text>li</xsl:text>
                </xsl:when>
                <xsl:when test="local-name(.) = 'table'">
                    <xsl:text>table</xsl:text>
                </xsl:when>
                <xsl:when test="local-name(.) = 'table-row'">
                    <xsl:text>tr</xsl:text>
                </xsl:when>
                <xsl:when test="local-name(.) = 'table-cell'">
                    <xsl:text>td</xsl:text>
                </xsl:when>
                <xsl:when test="local-name(.) = ''">
                    <xsl:text>td</xsl:text>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>false</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="x">
            <xsl:choose>
                <xsl:when test="$elementName != 'false'">
                    <xsl:value-of select="$elementName"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:text>span</xsl:text>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:element name="{$x}">
            <xsl:if test="$elementName = 'false'">
                <xsl:attribute name="data-xml-relict">
                    <xsl:value-of select="local-name(.)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="@*">
                <xsl:for-each select="@*">
                    <xsl:variable name="attributeName" select="local-name(.)"/>
                    <xsl:variable name="styleName" select="."/>
                    <xsl:variable name="font-style"
                        select="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:font-style-complex"/>
                    <xsl:variable name="font-weight"
                        select="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:font-weight-complex"/>
                    <xsl:variable name="text-underline-style"
                        select="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:text-underline-style"/>
                    <xsl:variable name="text-position"
                        select="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:text-position"/>
                    <xsl:variable name="text-bg-color"
                        select="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@fo:background-color"/>
                    <xsl:choose>
                        <xsl:when test="$attributeName = 'style-name'">
                            <xsl:attribute name="class">
                                <xsl:choose>
                                    <xsl:when test="$auto-styles//style:style[@style:name = $styleName]">
                                        <xsl:choose>
                                            <xsl:when test="$auto-styles//style:style[@style:name = $styleName]/@style:parent-style-name != ''">
                                                <xsl:text/><xsl:value-of select="$auto-styles//style:style[@style:name = $styleName]/@style:parent-style-name"/><xsl:text/>
                                            </xsl:when>
                                            <xsl:otherwise>
                                                <xsl:variable name="inlineStyles">
                                                    <xsl:if test="$font-weight = 'bold'">
                                                        <xsl:text>bold </xsl:text>
                                                    </xsl:if>
                                                    <xsl:if test="$font-style = 'italic'">
                                                        <xsl:text>italic </xsl:text>
                                                    </xsl:if>
                                                    <xsl:if test="$text-underline-style = 'solid'">
                                                        <xsl:text>underline </xsl:text>
                                                    </xsl:if>
                                                    <xsl:if test="contains($text-position, 'super')">
                                                        <xsl:text>super </xsl:text>
                                                    </xsl:if>
                                                    <xsl:if test="$text-bg-color != ''">
                                                        <xsl:text>color:</xsl:text><xsl:value-of select="$text-bg-color"/><xsl:text> </xsl:text>
                                                    </xsl:if>
                                                </xsl:variable>
                                                <xsl:choose>
                                                    <xsl:when test="$inlineStyles != ''"><xsl:value-of select="normalize-space($inlineStyles)"/></xsl:when>
                                                    <xsl:otherwise>
                                                        <xsl:value-of select="."/>
                                                    </xsl:otherwise>
                                                </xsl:choose>
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:when>
                                    <xsl:otherwise>
                                        <xsl:value-of select="."/>
                                    </xsl:otherwise>
                                </xsl:choose>
                            </xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="data-{$attributeName}" select="."/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:for-each>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>




</xsl:stylesheet>
