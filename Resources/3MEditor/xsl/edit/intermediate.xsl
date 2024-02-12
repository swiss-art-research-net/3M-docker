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
    <xsl:import href="additional.xsl"/>

    <xsl:import href="../various.xsl"/>


    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    
    
    <xsl:template match="intermediate" name="intermediate">
        <xsl:param name="entPos"/>
       
        <xsl:variable name="container">
           
            <xsl:value-of select="@container"/>
                
        </xsl:variable>
        <xsl:variable name="pathSoFar">

            <xsl:value-of select="@xpath"/>
                   
        </xsl:variable>
        <div class="intermediate" id="{$pathSoFar}" data-xpath="{$pathSoFar}">
            <xsl:choose>
                <xsl:when test="position()=last()">
                    <xsl:attribute name="style">border-bottom: 0;</xsl:attribute>
                    
                </xsl:when>
                <xsl:otherwise>
                    <!--<xsl:attribute name="style">border-top: 1px solid red;</xsl:attribute>-->

                </xsl:otherwise>
            </xsl:choose>
            
            <!--            <xsl:if test="position()=last()">
                <xsl:attribute name="style">border-bottom: 0;</xsl:attribute>
            </xsl:if>-->
            <!--            <button title="Delete Intermediate" type="button"  class="close" id="{concat('delete***',$pathSoFar)}">
                <span aria-hidden="true">x</span>
                <span class="sr-only">Close</span>
            </button>-->
            <button title="Delete Intermediate" type="button"  class="close btn btn-sm"  id="{concat('delete***',$pathSoFar)}">
                <span class="fa fa-times smallerIcon" ></span>
                <span class="sr-only">Close</span>
            </button>
            
            <xsl:for-each select="*">
                <xsl:if test="name()='entity'">
                    <xsl:variable name="entPath">
                        <xsl:call-template name="string-replace-all">
                            <xsl:with-param name="text" select="$pathSoFar" />
                            <xsl:with-param name="replace" select="'/intermediate['" />
                            <xsl:with-param name="by" select="'/entity['" />
                        </xsl:call-template>
                    </xsl:variable>
                    
                    <div class="row  bottom-bordered">
                        <div class="col-xs-1 icon">
                            <label class="control-label" for="">&#160;</label>
                            <img src="images/intermediate.png"/>
                        </div>
                        <div class="col-xs-11 rels">
               
                            <xsl:call-template name="entity">
                                <xsl:with-param name="pos" select="1"/>
                                <xsl:with-param name="pathSoFar" select="$entPath"/>
                            </xsl:call-template>
                        </div>
                    </div>
                    
                    
                    
                    
                  
                </xsl:if>
                <xsl:for-each select="following-sibling::relationship[1]">
                
                    <xsl:variable name="relPath">
                        <xsl:call-template name="string-replace-all">
                            <xsl:with-param name="text" select="$container" />
                            <xsl:with-param name="replace" select="'/intermediate'" />
                            <xsl:with-param name="by" select="''" />
                        </xsl:call-template>
                    </xsl:variable>
                
                
                    <div class="row   ">
                        <div class="col-xs-1 icon">
                            <label class="control-label" for="">&#160;</label>
                            <img src="images/property.png"/>
                        </div>
                        <div class="col-xs-11 rels ">
                            <div style="padding-left:0;padding-right:18px;" class="container col-xs-6 right-bordered">
                                <xsl:call-template name="relationship">
                                    <xsl:with-param name="pos" select="../@relPos"/>
                                    <xsl:with-param name="pathSoFar" select="$relPath"/>
                                </xsl:call-template>
                            </div>
                        </div>
                    </div>
                </xsl:for-each>
                
       
            </xsl:for-each>
        </div>
    </xsl:template>
   
    <xsl:template match="entity" name="entity">
        <!--<xsl:param name="mappingPos"></xsl:param>-->
        <xsl:param name="entPos"/>
        <xsl:param name="pathSoFar"/>      
       
        <div  style="padding-left:0;padding-right:22px;"> <!-- Added padding to align relation-entity combos-->
            <xsl:choose>
                <xsl:when test="not(additional)">
                    <xsl:attribute name="class">container col-xs-6 right-bordered</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="class">container col-xs-6</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
                    
            <div class="types col-xs-12" data-xpath="{concat($pathSoFar,'/type')}" >
                <xsl:call-template name="type">
                    <xsl:with-param name="entPos" select="$entPos"/>
                    <xsl:with-param name="pathSoFar" select="$pathSoFar"/>

                </xsl:call-template>
            </div>
            <div class="col-xs-12" style="padding-right:0;padding-left:0;">
     
                <button data-loading-text="Adding..."   data-xpath="{concat('add***',$pathSoFar,'/type')}" id="{concat('add***',$pathSoFar,'/type')}" title="Add additional class" type="button" class="btn btn-link btn-sm  add ">
                    Add additional class</button>
     
            </div>
            
            <div class="variable col-xs-12 ">
                <xsl:attribute name="style">
                    <xsl:choose>
                        <xsl:when test="@variable">
                            <xsl:text>display:block;padding-left:0;padding-right:0;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>display:none;padding-left:0;padding-right:0;</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <img src="images/MapVariable-Icon.png" title="variable applied on map"/>

                <label class="control-label" for="sourceType" style="font-weight:normal;"> Is same as (map)</label>
                <div class="input-group input-group-sm col-xs-12">
                    <span class="input-group-addon">[</span>
                    <!--                    <input id="{concat($pathSoFar,'/@variable')}" title="is Same as (map)" type="text" class="form-control" placeholder="Fill in value" data-xpath="{concat($pathSoFar,'/@variable')}">
                        <xsl:attribute name="value">
                            <xsl:value-of select="@variable"></xsl:value-of>
                        </xsl:attribute>
                    </input>-->
                    <input placeholder="Select a value or add new"  style="width:100%" title="is Same as (map)" type="hidden" class="select2 input-sm" data-id="{@variable}"  id="{concat($pathSoFar,'/@variable')}" data-xpath="{concat($pathSoFar,'/@variable')}">
                        <xsl:attribute name="value">
                            <xsl:value-of select="@variable"></xsl:value-of>
                        </xsl:attribute>
                        <img class="loader" src="js/select2-3.5.1/select2-spinner.gif"></img>
                    </input>
                    <span class="input-group-addon">]</span>
                                           
                    <span class="input-group-btn">
                        <button class="btn btn-default toggle" type="button" title="Delete is Same as (map)">
                            <span class="fa fa-times"></span>

                        </button>      
                    </span>
                </div>
            </div> 
            <div class="global_variable col-xs-12 ">
                <xsl:attribute name="style">
                    <xsl:choose>
                        <xsl:when test="@global_variable">
                            <xsl:text>display:block;padding-left:0;padding-right:0;</xsl:text>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:text>display:none;padding-left:0;padding-right:0;</xsl:text>
                        </xsl:otherwise>
                    </xsl:choose>
                </xsl:attribute>
                <img src="images/GlobalVariable-Icon.png" title="variable applied globally"/>

                <label class="control-label" for="is Same as (global)" style="font-weight:normal;"> Is same as (global)</label>
                <div class="input-group input-group-sm col-xs-12">
                    <span class="input-group-addon">[</span>
                    <input id="{concat($pathSoFar,'/@global_variable')}" title="is Same as (global)" type="text" class="form-control" placeholder="Fill in value" data-xpath="{concat($pathSoFar,'/@global_variable')}">
                        <xsl:attribute name="value">
                            <xsl:value-of select="@global_variable"></xsl:value-of>
                        </xsl:attribute>
                    </input>
                    <span class="input-group-addon">]</span>
                                           
                    <span class="input-group-btn">
                        <button class="btn btn-default toggle" type="button" title="Delete is Same as (global)">
                            <span class="fa fa-times"></span>

                        </button>      
                    </span>
                </div>
            </div> 
           
            <div class="col-xs-12" style="padding:0 0 0 0;">
                <div class=" btn-group" style="padding:0;">
                    <button type="button" class="btn btn-link btn-sm  dropdown-toggle instance" data-toggle="dropdown" style="padding:0;border:0;">
                        Add instance info
                        <span class="caret"></span>
                    </button>
                    <ul class="dropdown-menu" role="menu">


                        <li>
                            <xsl:if test="@variable">
                                <xsl:attribute name="class">disabled</xsl:attribute>
                            </xsl:if>
                            <img src="images/MapVariable-Icon.png" title="variable applied on map"/>

                            <a class="add" title="add is Same as (map)" href="" id="{concat('add***',$pathSoFar,'/@variable')}" >Is same as (map)</a>
                        </li>
                        <li>
                            <xsl:if test="@global_variable">
                                <xsl:attribute name="class">disabled</xsl:attribute>
                            </xsl:if>
                            <img src="images/GlobalVariable-Icon.png" title="variable applied globally"/>

                            <a class="add" title="add is Same as (global)" href="" id="{concat('add***',$pathSoFar,'/@global_variable')}" >Is same as (global)</a>
                        </li>
                       
                    </ul>
                                      
                </div>
            </div>
            
        </div>
        <div style="padding-right:0px;">
            <xsl:choose>
                <xsl:when test="not(additional)">
                    <xsl:attribute name="class">container col-xs-6</xsl:attribute>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:attribute name="class">container col-xs-6 left-bordered</xsl:attribute>
                </xsl:otherwise>
            </xsl:choose>
                        
                  
            <div class="additionals" data-xpath="{concat($pathSoFar,'/additional')}">
                <xsl:call-template name="additional">
                    <xsl:with-param name="entPos" select="$entPos"/>
                </xsl:call-template>
            </div>
                    
            <button data-loading-text="Adding..."  data-xpath="{concat('add***',$pathSoFar,'/additional')}" id="{concat('add***',$pathSoFar,'/additional')}" title="Add Constant Expression" type="button" class="btn btn-link btn-sm  add ">
                Add constant expression</button>

        </div>
                    
                    
                    
        
        
        
      
    </xsl:template>
</xsl:stylesheet>
