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
    <xsl:output indent="yes" method="xml"/>
    <xsl:mode on-no-match="shallow-copy"/>


    <xsl:variable name="auto-styles" select="/office:document/office:automatic-styles"/>

    <xsl:variable name="meta">
        <metadata>
            <title>
                <xsl:value-of select="/office:document/office:meta/dc:title"/>
            </title>
            <subject>
                <xsl:value-of select="/office:document/office:meta/dc:subject"/>
            </subject>
            <description>
                <xsl:value-of select="/office:document/office:meta/dc:description"/>
            </description>
            <keywords>
                <xsl:for-each select="/office:document/office:meta/meta:keyword">
                    <keyword>
                        <xsl:value-of select="."/>
                    </keyword>
                </xsl:for-each>
            </keywords>
        </metadata>
    </xsl:variable>

    <xsl:template match="/">
        <document>
            <xsl:copy-of select="$meta"/>
            <text>
                <xsl:apply-templates select="office:document/office:body/office:text/child::*"/>
            </text>
        </document>
    </xsl:template>

    <!-- Empty Nodes -->
    <xsl:template match="office:forms"/>
    <xsl:template match="text:sequence-decls"/>

    <!-- Spans -->
    <xsl:template match="text:span[ancestor::office:text]">
        <xsl:variable name="elementName" select="local-name(.)"/>
        <xsl:variable name="styleName" select="@text:style-name"/>

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


        <xsl:element name="{$elementName}" namespace="">
            <xsl:if test="$styleName != ''">
                <xsl:attribute name="stylename">
                    <xsl:choose>
                        <xsl:when test="not($auto-styles//style:style[@style:name = $styleName])">
                            <xsl:value-of select="$styleName"/>
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
                                <xsl:otherwise>no-matching-styles</xsl:otherwise>
                            </xsl:choose>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>


    <!-- Common Block Elements -->
    <xsl:template
        match="text:p[ancestor::office:text] | text:h[ancestor::office:text] | text:soft-page-break[ancestor::office:text] | table:*[ancestor::office:text]">
        <xsl:variable name="elementName" select="local-name(.)"/>
        <xsl:variable name="styleName" select="@text:style-name"/>
        <xsl:variable name="parStyles">
            <xsl:if test="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:text-underline-style"><xsl:text>underline </xsl:text></xsl:if>
            <xsl:if test="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:font-weight-complex = 'bold'"><xsl:text>bold </xsl:text></xsl:if>
            <xsl:if test="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:font-style-complex = 'italic'"><xsl:text>italic </xsl:text></xsl:if>
        </xsl:variable>

        <xsl:element name="{$elementName}" namespace="">
            <xsl:if test="$styleName != ''">
                <xsl:if test="$parStyles != ''">
                    <xsl:attribute name="paragraphstyles">
                        <xsl:value-of select="normalize-space($parStyles)"/>
                    </xsl:attribute>
                </xsl:if>
                <xsl:attribute name="stylename">
                    <xsl:choose>
                        <xsl:when test="$auto-styles//style:style[@style:name = $styleName]">
                            <xsl:value-of
                                select="$auto-styles//style:style[@style:name = $styleName]/@style:parent-style-name"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$styleName"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Footnotes & Endnotes -->
    <xsl:template
        match="text:note[ancestor::office:text] | text:note-citation[ancestor::office:text] | text:note-body[ancestor::office:text]">
        <xsl:variable name="elementName" select="local-name(.)"/>
        <xsl:variable name="styleName" select="@text:style-name"/>
        <xsl:variable name="parStyles">
            <xsl:if test="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:text-underline-style"><xsl:text>underline </xsl:text></xsl:if>
            <xsl:if test="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:font-weight-complex = 'bold'"><xsl:text>bold </xsl:text></xsl:if>
            <xsl:if test="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:font-style-complex = 'italic'"><xsl:text>italic </xsl:text></xsl:if>
        </xsl:variable>

        <xsl:element name="{$elementName}" namespace="">
            <xsl:if test="$parStyles != ''">
                <xsl:attribute name="paragraphstyles">
                    <xsl:value-of select="normalize-space($parStyles)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="$styleName != ''">
                <xsl:attribute name="stylename">
                    <xsl:choose>
                        <xsl:when test="$auto-styles//style:style[@style:name = $styleName]">
                            <xsl:value-of
                                select="$auto-styles//style:style[@style:name = $styleName]/@style:parent-style-name"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$styleName"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>


    <!-- Spaces -->
    <xsl:template match="text:s[ancestor::office:text]">
        <xsl:element name="space" namespace="">
            <xsl:attribute name="count">
                <xsl:value-of select="@text:c"/>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Tabs -->
    <xsl:template match="text:tab[ancestor::office:text]">
        <xsl:element name="tab" namespace="">
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Lists -->
    <xsl:template
        match="text:list[ancestor::office:text] | text:list-item[ancestor::office:text]">
        <xsl:variable name="styleName" select="@text:style-name"/>
        <xsl:variable name="parStyles">
            <xsl:if test="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:text-underline-style"><xsl:text>underline </xsl:text></xsl:if>
            <xsl:if test="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:font-weight-complex = 'bold'"><xsl:text>bold </xsl:text></xsl:if>
            <xsl:if test="$auto-styles//style:style[@style:name = $styleName]/style:text-properties/@style:font-style-complex = 'italic'"><xsl:text>italic </xsl:text></xsl:if>
        </xsl:variable>

        <xsl:variable name="elementName">
            <xsl:choose>
                <xsl:when test="$auto-styles//text:list-style[@style:name = $styleName]/text:list-level-style-number"><xsl:text>ol</xsl:text></xsl:when>
                <xsl:when test="$auto-styles//text:list-style[@style:name = $styleName]/text:list-level-style-bullet"><xsl:text>ul</xsl:text></xsl:when>
                <xsl:otherwise><xsl:text>li</xsl:text></xsl:otherwise>
            </xsl:choose>
        </xsl:variable>


        <xsl:element name="{$elementName}" namespace="">
            <xsl:if test="$parStyles != ''">
                <xsl:attribute name="paragraphstyles">
                    <xsl:value-of select="normalize-space($parStyles)"/>
                </xsl:attribute>
            </xsl:if>
            <xsl:if test="$styleName != '' and not(matches($styleName, 'L[0-9]{1,2}'))">
                <xsl:attribute name="stylename">
                    <xsl:choose>
                        <xsl:when test="$auto-styles//style:style[@style:name = $styleName]">
                            <xsl:value-of
                                select="$auto-styles//style:style[@style:name = $styleName]/@style:parent-style-name"
                            />
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:value-of select="$styleName"/>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:element>
    </xsl:template>

    <!-- Are there other formats worth processing? -->

</xsl:stylesheet>
