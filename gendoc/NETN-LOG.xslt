<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:vomt="http://www.pitch.se/visualomt" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:clitype="clitype" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:fnk="http://www.w3.org/2005/02/xpath-functions" xmlns:iso4217="http://www.xbrl.org/2003/iso4217" xmlns:ix="http://www.xbrl.org/2008/inlineXBRL" xmlns:java="java" xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:ns="http://standards.ieee.org/IEEE1516-2010" xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:altova="http://www.altova.com" exclude-result-prefixes="clitype fn iso4217 ix java link ns xbrldi xbrli xlink xs xsi altova">
	
<xsl:output version="4.0" method="text" indent="no" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>


<xsl:template match="/ns:objectModel"># <xsl:apply-templates select="ns:modelIdentification/ns:name"/>
<xsl:text>&#xd;&#xd;</xsl:text>
<xsl:value-of select="ns:modelIdentification/ns:description"/>

## Purpose
<xsl:value-of select="ns:modelIdentification/ns:purpose"/>	

## Scope
<xsl:value-of select="ns:modelIdentification/ns:useLimitation"/>	
	
# Overview
<xsl:apply-templates select="ns:modelIdentification/@notes"/>

## Facility
<xsl:apply-templates select="//ns:objectClass[ns:name = 'LOG_Facility']" mode="detail"/>


</xsl:template>


<xsl:template match="ns:objectClass" mode="detail">
<xsl:text>&#xd;</xsl:text>
<xsl:apply-templates select="ns:semantics"/>

&lt;img src="/images/log_facility.png" width="500px"/>

<xsl:text>&#xd;&#xd;</xsl:text>
|Attribute|Datatype|Description|
|---|---|---|
<xsl:apply-templates select="ns:attribute"/>
</xsl:template>


<xsl:template match="ns:semantics" mode="abbreviated">
	<xsl:choose>
		<xsl:when test="contains(.,'&#xA;')">
			<xsl:value-of select="substring-before(.,'&#xA;')"/>
		</xsl:when>
		<xsl:otherwise>
			<xsl:value-of select="."/></xsl:otherwise>
		</xsl:choose>
</xsl:template>

<xsl:template match="ns:attribute">|<xsl:value-of select="ns:name"/>|<xsl:value-of select="ns:dataType"/>|<xsl:value-of select="ns:semantics"/>| 
</xsl:template>




<xsl:template match="@notes">
  <xsl:call-template name="tokenizeNotes">     
    <xsl:with-param name="string" select="." />   
  </xsl:call-template>
</xsl:template>

<xsl:template match="ns:note">
<xsl:value-of select="ns:semantics"/>
</xsl:template>



<xsl:template name="tokenizeNotes">   
  <xsl:param name="string" />   
  <xsl:param name="delimiter" select="' '" />   
  <xsl:choose>     
    <xsl:when test="$delimiter and contains($string, $delimiter)">              
	<xsl:apply-templates select="//ns:note[ns:label = substring-before($string, $delimiter)]"/>
	\\
	<xsl:call-template name="tokenizeNotes">         
	  <xsl:with-param name="string" select="substring-after($string, $delimiter)" />
	  <xsl:with-param name="delimiter" select="$delimiter" />       
	</xsl:call-template>     
    </xsl:when>     
	<xsl:otherwise>       
	  <xsl:apply-templates select="//ns:note[ns:label = $string]"/> 
	</xsl:otherwise>   
  </xsl:choose> 
 </xsl:template> 


</xsl:stylesheet>

