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
    <xsl:output method="html"/>
    <xsl:include href="namespace.xsl"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    
    
    <xsl:template name="namespaces">
        <xsl:param name="namespacesPath"/>
        
        <xsl:choose>
            <xsl:when test="name(..)='x3ml'">
                <fieldset>
                    <legend>Namespaces</legend>
                    <div class="row">
                        <span class="help-block col-sm-12">This section consists of information about namespaces not declared in source or target block.
                        </span>
                           
                    </div>  
                    <div class="namespaces" id="{$namespacesPath}">
                        <xsl:for-each select="namespace">
                            <xsl:variable name="namespaceXpath" select="concat($namespacesPath,'/namespace[',position(),']')"/>
                            <xsl:call-template name="namespace">
                                <xsl:with-param name="namespaceXpath" select="$namespaceXpath"/>
                            </xsl:call-template>

                        </xsl:for-each>
                    </div>
                    <div class="row">
                        <div class="col-sm-2 col-sm-offset-5">
                            <br></br>
                            <button data-loading-text="Adding..." id="{concat('add***',$namespacesPath)}" data-xpath="{$namespacesPath}" type="button" class="btn btn-default btn-block  add btn-sm">
                                <span class="glyphicon glyphicon-plus"></span>&#160;Namespace
                            </button>
                        </div>
                    </div>
                </fieldset>       
              
            </xsl:when>
            <xsl:otherwise>
                  
                <div class="namespaces" id="{$namespacesPath}">
                    <xsl:for-each select="namespace" >
                        <xsl:variable name="namespaceXpath" select="concat($namespacesPath,'/namespace[',position(),']')"/>
                        <xsl:call-template name="namespace">
                            <xsl:with-param name="namespaceXpath" select="$namespaceXpath"/>
                        </xsl:call-template>
            
           
                    </xsl:for-each>
                   
                </div>
             
                      
                <div class="row">
                    <div class="col-sm-2 col-sm-offset-8">
                        <br></br>
                        <button data-loading-text="Adding..." id="{concat('add***',$namespacesPath)}" data-xpath="{$namespacesPath}" type="button" class="btn btn-default btn-block  add btn-sm">
                            <span class="glyphicon glyphicon-plus"></span>&#160;Namespace
                        </button>
                    </div>
                </div>
            </xsl:otherwise>
        </xsl:choose>
        

                   
    </xsl:template>
    
    

</xsl:stylesheet>
