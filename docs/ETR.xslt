<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:vomt="http://www.pitch.se/visualomt" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:clitype="clitype" xmlns:fn="http://www.w3.org/2005/xpath-functions" xmlns:iso4217="http://www.xbrl.org/2003/iso4217" xmlns:ix="http://www.xbrl.org/2008/inlineXBRL" xmlns:java="java" xmlns:link="http://www.xbrl.org/2003/linkbase" xmlns:ns="http://standards.ieee.org/IEEE1516-2010" xmlns:xbrldi="http://xbrl.org/2006/xbrldi" xmlns:xbrli="http://www.xbrl.org/2003/instance" xmlns:xlink="http://www.w3.org/1999/xlink" xmlns:xs="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:altova="http://www.altova.com" exclude-result-prefixes="clitype fn iso4217 ix java link ns xbrldi xbrli xlink xs xsi altova">
	
<xsl:output version="4.0" method="text" indent="no" encoding="UTF-8" doctype-public="-//W3C//DTD HTML 4.01 Transitional//EN" doctype-system="http://www.w3.org/TR/html4/loose.dtd"/>

<xsl:template match="/ns:objectModel">

<xsl:apply-templates select="ns:modelIdentification"/>
	
### Entity Tasks

This section summarizes the Entity Task interaction classes in the ETR FOM module.

&lt;img src="./images/etr_task.png" width="75%"/>

|Task|Description|
|---|---|
<xsl:apply-templates select="//ns:interactionClass[ns:name = 'ETR_Task']/ns:interactionClass" mode="detail"/>
	
### Entity Reports
This section summarizes the Entity Report interaction classes in the ETR FOM module, shown in the figure below.
 
&lt;img src="./images/etr_report.png" width="75%"/>

|Report|Description|
|---|---|
<xsl:apply-templates select="//ns:interactionClass[ns:name = 'ETR_Report']/ns:interactionClass" mode="detail"/>

### Task Management
This section summarizes the Task Management interaction classes in the ETR FOM module, shown in the figure below.
 
&lt;img src="./images/etr_taskmanagement.png" width="75%"/>


|Task Management|Description|
|---|---|
<xsl:apply-templates select="//ns:interactionClass[ns:name = 'ETR_TaskManagement']/ns:interactionClass" mode="detail"/>

### Simulation Control
This section summarizes the Simulaltion Control interaction classes in the ETR FOM module, shown in the figure below.

&lt;img src="./images/etr_simcon.png" width="75%"/>

|Simulation Control|Description|
|---|---|
<xsl:apply-templates select="//ns:interactionClass[ns:name = 'ETR_SimCon']/ns:interactionClass" mode="detail"/>
</xsl:template>


<xsl:template match="ns:modelIdentification">
	<xsl:text># </xsl:text><xsl:value-of select="ns:name"/>

	<xsl:text>&#xd;</xsl:text>
	<xsl:if test="ns:description"><xsl:value-of select="ns:description"/></xsl:if>
	<xsl:if test="ns:purpose">
		<xsl:text>&#xd;&#xd;## Purpose&#xd;</xsl:text>
		<xsl:value-of select="ns:purpose"/>	
	</xsl:if>
	<xsl:if test="ns:useLimitation">
		<xsl:text>&#xd;&#xd;## Scope&#xd;</xsl:text>
		<xsl:value-of select="ns:useLimitation"/>	
	</xsl:if>
	<xsl:if test="@notes">
	<xsl:text>&#xd;&#xd;## Overview&#xd;</xsl:text>
		<xsl:apply-templates select="@notes"/>
&lt;img src="./images/etr_baseclasses.png" width="50%"/>
      
	</xsl:if>
</xsl:template>


<xsl:template match="ns:interactionClass" mode="detail">|<xsl:value-of select="ns:name"/>|<xsl:apply-templates select="ns:semantics" mode="abbreviated"/>|
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


<xsl:template match="ns:interactionClass">
<xsl:if test="ns:parameter or ns:semantics">|<xsl:value-of select="ns:name"/>|<xsl:value-of select="ns:semantics"/>|
</xsl:if>
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

