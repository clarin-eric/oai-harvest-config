<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet 
    xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="3.0"
    xmlns:dc="http://purl.org/dc/elements/1.1/" 
    xmlns:oai_dc="http://www.openarchives.org/OAI/2.0/oai_dc/"
    xmlns:oai="http://www.openarchives.org/OAI/2.0/"
    xmlns:xs="http://www.w3.org/2001/XMLSchema">

    <xsl:output method="xml" version="1.0" encoding="UTF-8" indent="yes"/>
    
    <xsl:param name="provider_uri" select="()"/>
    <xsl:param name="config" select="()"/>
    
    <xsl:include href="mmsh.xsl"/>
    
    <xsl:template match="/" priority="1">
        <xsl:message>Welcome to dc-filter</xsl:message>
        <xsl:apply-templates>
            <xsl:with-param name="filter" tunnel="yes" select="exists($config//provider[@url=$provider_uri]/xpath-filter)"/>
        </xsl:apply-templates>
    </xsl:template>

    <xsl:template match="oai:record">
        <xsl:param name="filter" tunnel="yes"/>
        <xsl:variable name="rec" select="."/>
        <xsl:choose>
            <xsl:when test="$filter">
                <xsl:variable name="isValid" as="xs:boolean">
                    <xsl:evaluate xpath="$filter">
                        <xsl:fallback>
                            <xsl:sequence select="true()"/>
                        </xsl:fallback>
                    </xsl:evaluate>
                </xsl:variable>
                <xsl:if test="$isValid">
                    <xsl:next-match/>
                </xsl:if>
            </xsl:when>
            <xsl:otherwise>
                <xsl:next-match/>
            </xsl:otherwise>
        </xsl:choose>
    </xsl:template>

    <xsl:template match="node() | @*" mode="#all">
        <xsl:copy>
            <xsl:apply-templates select="node() | @*"  mode="#current"/>
        </xsl:copy>
    </xsl:template>
</xsl:stylesheet>
