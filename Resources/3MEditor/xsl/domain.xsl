<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright 2014-2019  Institute of Computer Science,
Foundation for Research and Technology - Hellas

Licensed under the EUPL, Version 1.1 or - as soon they will be approved
by the European Commission - subsequent versions of the EUPL (the "Licence");
You may not use this work except in compliance with the Licence.
You may obtain a copy of the Licence at:

http://ec.europa.eu/idabc/eupl

Unless required by applicable law or agreed to in writing, software distributed
under the Licence is distributed on an "AS IS" basis,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the Licence for the specific language governing permissions and limitations
under the Licence.

Contact:  POBox 1385, Heraklio Crete, GR-700 13 GREECE
Tel:+30-2810-391632
Fax: +30-2810-391638
E-mail: isl@ics.forth.gr
http://www.ics.forth.gr/isl

Authors : Georgios Samaritakis, Konstantina Konsolaki.

This file is part of the 3MEditor webapp of Mapping Memory Manager project.

-->

<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="1.0">
    <xsl:import href="various.xsl"/>
    <xsl:import href="entity.xsl"/>
    <xsl:import href="viewOnly.xsl"/>   
    <xsl:include href="comments.xsl"/>
    <xsl:import href="if-rule.xsl"/>


    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
  
    <xsl:template match="domain" name="domain">
        <xsl:param name="mappingPos"/>
                                 
        <tr class="domain clickable" data-xpath="{concat('//x3ml/mappings/mapping[',$mappingPos,']/domain')}"> 
            <xsl:if test="$action=0">
                <xsl:attribute name="title">Click to edit domain</xsl:attribute>
            </xsl:if>
            <xsl:variable name="index">
                <xsl:choose>
                    <xsl:when test="$mappingPos!=''">
                        <xsl:value-of select="$mappingPos"></xsl:value-of>
                    </xsl:when>
                    <xsl:when test="@index!=''">
                        <xsl:value-of select="@index"></xsl:value-of>
                    </xsl:when>
                </xsl:choose>
            </xsl:variable>
            
            <td class="index" title="{$index}" style="text-align:center;">
                <xsl:value-of select="$index"/>
            </td>

            <td>D</td>
            <td class="sourceCol">
                <div class="row">
                    <div class="col-xs-1 iconContainer">
                        <img src="images/domain.png"/>
                    </div>
                    <div class="col-xs-11 nextToIcon">
                        <xsl:call-template name="stripPath">
                            <xsl:with-param name="path" select="source_node" />
                        </xsl:call-template>
                    </div>
                </div>
            </td>          
            <td class="templateCol">
                <span class="domainTemplate">
                    <xsl:value-of select="@template"/>
                </span>
            </td>
            <td class="targetCol">
                <xsl:apply-templates select="target_node">
                    <xsl:with-param name="pathSoFar" select="concat('//x3ml/mappings/mapping[',$mappingPos,']/domain/target_node')"/>
                </xsl:apply-templates>
            </td>
            <td class="ifCol">                
                <xsl:for-each select="target_node">
                    <xsl:call-template name="if-rule"></xsl:call-template> 
                </xsl:for-each>            
            </td>
            <td class="commentsHead">                
                <xsl:apply-templates select="comments"/>
            </td>
        </tr>
                         
    </xsl:template>
    

</xsl:stylesheet>
