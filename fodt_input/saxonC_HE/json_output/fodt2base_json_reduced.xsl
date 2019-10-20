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
    <xsl:output indent="yes" method="text"/>
    <xsl:mode on-no-match="shallow-copy"/>
    

    <xsl:template match="/office:document">
        {
        <xsl:variable name="meta" >
            <xsl:text>"metadata": {
                        "title": "</xsl:text><xsl:value-of select="office:meta/dc:title"/><xsl:text>",</xsl:text>
                    <xsl:text>
                        "subject": "</xsl:text><xsl:value-of select="office:meta/dc:subject"/><xsl:text>",</xsl:text>
                    <xsl:text>
                        "description": "</xsl:text><xsl:value-of select="office:meta/dc:description"/><xsl:text>",</xsl:text>
            <xsl:text>
                        "keywords": [</xsl:text>
                <xsl:for-each select="office:meta/meta:keyword">
                        <xsl:choose>
                            <xsl:when test="position() != last()">
                                "<xsl:value-of select="."/>", 
                            </xsl:when>
                            <xsl:otherwise>
                                "<xsl:value-of select="."/>"
                            </xsl:otherwise>
                        </xsl:choose>
                </xsl:for-each>
            <xsl:text>]</xsl:text>
            <xsl:text>},</xsl:text>
        </xsl:variable>
        <xsl:value-of select="$meta"/>
        <xsl:text>
            "document": </xsl:text>
            [
                <xsl:apply-templates select="office:body/office:text/child::*"/>
            ]
        }
    </xsl:template>

    <!-- Empty Nodes -->
    <xsl:template match="office:forms"/>
    <xsl:template match="text:sequence-decls"/>

    <xsl:template match="*">
        <xsl:variable name="elementName" select="local-name(.)"/>
        <xsl:variable name="serial-params">
            <output:serialization-parameters>
                <output:omit-xml-declaration value="yes" />
            </output:serialization-parameters>
        </xsl:variable>
        <xsl:choose>
            <xsl:when test="matches($elementName, '^(h|p|table-cell|list-item)$')">
                <xsl:element name="{$elementName}">
                    {
                    "type": "<xsl:value-of select="$elementName"/>",
                    "text": "<xsl:value-of select="replace(normalize-space(.),'&quot;','”')"/>"
                    <!-- ,
                    "raw": "<xsl:value-of select="replace(normalize-space(serialize(., $serial-params/*)),'&quot;','”')"/>"
                     -->
                    }
                    <xsl:choose>
                        
                        <xsl:when test="(not(position() = last()) or following-sibling::*)">
                            <xsl:text>,</xsl:text>
                        </xsl:when>
                        <xsl:otherwise/>
                    </xsl:choose>
                    
                </xsl:element>
            </xsl:when>
            <xsl:otherwise>
                <xsl:apply-templates/>
            </xsl:otherwise>
                
            
        </xsl:choose>
    </xsl:template>
    
    
</xsl:stylesheet>
