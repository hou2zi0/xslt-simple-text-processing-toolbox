<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:err="http://www.w3.org/2005/xqt-errors"
    xmlns:idPkg="http://ns.adobe.com/AdobeInDesign/idml/1.0/packaging"
    exclude-result-prefixes="#all"
    version="3.0">
    <xsl:output method="xml" encoding="UTF-8" indent="true"/>
    <xsl:mode on-no-match="shallow-copy" />

    <xsl:template match="/idPkg:Story">
        <xsl:apply-templates/>
    </xsl:template>

    <xsl:template match="StoryPreference"/>


    <xsl:template match="InCopyExportOption"/>

    <xsl:template match="Story">
        <document>
            <xsl:apply-templates />
        </document>
    </xsl:template>

    <xsl:template match="ParagraphStyleRange">
        <xsl:variable name="styles" select="@AppliedParagraphStyle"/>
        <p style="{$styles}"><xsl:apply-templates/></p>
    </xsl:template>

    <xsl:template match="CharacterStyleRange">
        <xsl:variable name="styles" select="@AppliedCharacterStyle"/>
        <span style="{$styles}"><xsl:apply-templates/></span>
    </xsl:template>

    <xsl:template match="Content">
        <xsl:apply-templates />
    </xsl:template>

    <xsl:template match="Footnote">
        <footnote><xsl:apply-templates /></footnote>
    </xsl:template>

    <xsl:template match="Br">
        <br/>
    </xsl:template>

    <xsl:template match="TextFrame"/>

    <xsl:template match="Properties"/>


</xsl:stylesheet>
