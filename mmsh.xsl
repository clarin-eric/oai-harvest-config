<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns:xs="http://www.w3.org/2001/XMLSchema"
    xmlns:math="http://www.w3.org/2005/xpath-functions/math"
    xmlns:dc="http://purl.org/dc/elements/1.1/" 
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/"
    exclude-result-prefixes="xs math oai"
    version="3.0">
 
    <!--<xsl:template match="node() | @*" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*" mode="#current"/>
        </xsl:copy>
    </xsl:template>-->
    
    <!-- MMSH -->
    <xsl:template match="oai:OAI-PMH" priority="1">
        <xsl:message>[MMSH] Welcome to oai:OAI-PMH</xsl:message>
        <xsl:if test="oai:request='https://calames.abes.fr/oai/oai2.aspx'">
            <xsl:copy>
                <xsl:apply-templates select="node() | @*" mode="mmsh"/>
            </xsl:copy>
        </xsl:if>
    </xsl:template>
    
    
    <xsl:template match="dc:identifier[empty(preceding-sibling::dc:identifier)]" mode="mmsh">
        <xsl:message>[MMSH] Welcome to dc:identifier</xsl:message>
        <dc:identifier>
            <xsl:text>https://calames.abes.fr/pub/?id=</xsl:text>
            <xsl:value-of select="replace(ancestor::oai:record/oai:header/oai:identifier,'oai:oaicalames.abes.fr:','')"/>
        </dc:identifier>
        <xsl:next-match/>
    </xsl:template>
        
</xsl:stylesheet>