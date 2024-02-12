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
    <xsl:import href="arg.xsl"/>
   
    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template name="label_generator" match="label_generator">
        <xsl:param name="pathSoFar"/>

        <xsl:variable name="container">
            <xsl:choose>
                <xsl:when test="$pathSoFar!=''">
                    <xsl:value-of select="$pathSoFar"/>
                </xsl:when>
                  <xsl:when test="@xpath!=''">
                    <xsl:value-of select="@xpath"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="@container"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
        <xsl:variable name="generatorsStatus">
            <xsl:choose>
                <xsl:when test="@generatorsStatus">
                    <xsl:value-of select="@generatorsStatus"/>
                </xsl:when>
                <xsl:when test="//mappings/@status">
                    <xsl:value-of select="//mappings/@status"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="//output/generator/@mode"/>
                </xsl:otherwise>
            </xsl:choose>
        </xsl:variable>
                   
                   
        <div class="label_generator focus" id="{$container}" data-xpath="{$container}">
            <xsl:attribute name="style">
                <xsl:choose>
                    <xsl:when test="contains($container,'additional')">margin-left:0px;</xsl:when>
                </xsl:choose>
            </xsl:attribute>
            <button title="Delete Label Generator" type="button" class="close" id="{concat('delete***',$container)}" >
                <span class="fa fa-times smallerIcon" style="color:black;"></span>

            </button>
            <div class="row">
                <div class="col-sm-12">

                    <label class="control-label" for="{concat($container,'/@name')}">Label Generator Name</label>
                    
                    <xsl:choose>
                        <xsl:when test="$generatorsStatus='manual'">  
                            <input id="{concat($container,'/@name')}" type="text" class="form-control input-sm" placeholder="Fill in value" title="Label Generator Name" data-xpath="{concat($container,'/@name')}">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="@name"></xsl:value-of>
                                </xsl:attribute>
                            </input>
                        </xsl:when>
                        <xsl:otherwise>
                           
                            <input style="width:100%;" title="Label Generator Name" type="hidden" class="select2 input-sm"  id="{concat($container,'/@name')}" data-id="{@name}" data-xpath="{concat($container,'/@name')}">
                                <xsl:attribute name="value">
                                    <xsl:value-of select="@name"></xsl:value-of>
                                </xsl:attribute>
                                <img class="loader" src="js/select2-3.5.1/select2-spinner.gif"></img>
                            </input>
                        </xsl:otherwise>
                    </xsl:choose>
                </div>
            </div>
                      
            <div class="args" id="{concat($container,'/args')}">
                <xsl:for-each select="arg">
                      
                    <xsl:call-template name="arg">
                        <xsl:with-param name="pathSoFar" select="concat($container,'/arg[',position(),']')"/>
                    </xsl:call-template>
                           
                </xsl:for-each>
                    
            </div>
            <button data-loading-text="Adding..." style="padding:0;" data-xpath="{concat('add***',$container,'/arg')}" id="{concat('add***',$container,'/arg')}" title="Add Argument" type="button" class="btn btn-link btn-sm  add white">
                Add argument</button>              
            <button data-loading-text="Adding..." data-xpath="{concat('add***',$container,'/arg')}" id="{concat('add***',$container,'/arg')}" title="Add Arguments" type="button" class="btn btn-link btn-sm  add white" style="display:none;">
                Get arguments</button>  
               
                
              
        </div>
                    
           
                      
        

    </xsl:template>

</xsl:stylesheet>
