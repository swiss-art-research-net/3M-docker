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
    <xsl:include href="type.xsl"/>
    <xsl:import href="additional.xsl"/>
    <!--<xsl:include href="utils.xsl"/>-->

    <xsl:output method="html"></xsl:output>
    <!-- TODO customize transformation rules 
    syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="entity" name="entity">
        <!--<xsl:param name="mappingPos"></xsl:param>-->
        <xsl:param name="entPos"/>
        <xsl:param name="pathSoFar"/>
       
        <xsl:variable name="path">
            <xsl:choose>
                <xsl:when test="$pathSoFar!=''">
                    <xsl:value-of select="$pathSoFar"/>
                </xsl:when>
                <xsl:otherwise>
                    <xsl:value-of select="../../@xpath"/>
                </xsl:otherwise>
            </xsl:choose>
            
            
        </xsl:variable>

        
        <xsl:choose>
            <xsl:when test="name(..)='additional'">
                                        
                <div  data-xpath="{concat($path,'/',name(..),'/entity[1]/type')}">
                    <xsl:call-template name="type">
                        <xsl:with-param name="entPos" select="1"/>
                        <xsl:with-param name="pathSoFar" select="concat($path,'/entity[1]')"/>

                    </xsl:call-template>
                </div>
                    
                    
            </xsl:when>
            <xsl:otherwise>
                <div  style="padding-left:0;"> <!-- Added padding to align relation-entity combos-->
                    <xsl:choose>
                        <xsl:when test="not(additional)">
                            <xsl:attribute name="class">container col-xs-6 right-bordered</xsl:attribute>
                        </xsl:when>
                        <xsl:otherwise>
                            <xsl:attribute name="class">container col-xs-6</xsl:attribute>
                        </xsl:otherwise>
                    </xsl:choose>
                    
                    <div class="types col-xs-12" data-xpath="{concat($path,'/',name(..),'/entity[',$entPos,']/type')}">
                        <xsl:call-template name="type">
                            <xsl:with-param name="entPos" select="$entPos"/>
                            <xsl:with-param name="pathSoFar" select="concat($path,'/',name(..),'/entity[',$entPos,']')"/>

                        </xsl:call-template>
                    </div>
                    <div class="col-xs-12" style="padding-right:0;padding-left:0;">
     
                        <button data-loading-text="Adding..."  data-xpath="{concat('add***',$path,'/',name(..),'/entity[',$entPos,']/type')}" id="{concat('add***',$path,'/',name(..),'/entity[',$entPos,']/type')}" title="Add additional class" type="button" class="btn btn-link btn-sm  add ">
                            Add additional class</button>
     
                    </div>
                    <xsl:choose>
                        <xsl:when test="name(..)='target_relation'">
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
                                    <!--                                    <input id="{concat($path,'/',name(..),'/entity[',$entPos,']/@variable')}" title="is Same as (map)" type="text" class="form-control" placeholder="Fill in value" data-xpath="{concat($path,'/',name(..),'/entity[',$entPos,']/@variable')}">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="@variable"></xsl:value-of>
                                        </xsl:attribute>
                                    </input>-->
                                    <input placeholder="Select a value or add new"  style="width:100%" title="is Same as (map)" type="hidden" class="select2 input-sm" data-id="{@variable}"  id="{concat($path,'/',name(..),'/entity[',$entPos,']/@variable')}" data-xpath="{concat($path,'/',name(..),'/entity[',$entPos,']/@variable')}">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="@variable"></xsl:value-of>
                                        </xsl:attribute>
                                        <img class="loader" src="js/select2-3.5.1/select2-spinner.gif"></img>
                                    </input>
                                    <span class="input-group-addon">]</span>
                                           
                                    <span class="input-group-btn">
                                        <button class="btn btn-default toggle" type="button" title="Delete is Same as (map)">
                                            <!--<span class="glyphicon glyphicon-remove"></span>-->
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
                                    <input id="{concat($path,'/',name(..),'/entity[',$entPos,']/@global_variable')}" title="is Same as (global)" type="text" class="form-control" placeholder="Fill in value" data-xpath="{concat($path,'/',name(..),'/entity[',$entPos,']/@global_variable')}">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="@global_variable"></xsl:value-of>
                                        </xsl:attribute>
                                    </input>
                                    <span class="input-group-addon">]</span>
                                           
                                    <span class="input-group-btn">
                                        <button class="btn btn-default toggle" type="button" title="Delete is Same as (global)">
                                            <!--<span class="glyphicon glyphicon-remove"></span>-->
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
                                            <a class="add" title="add is Same as (map)" href="" id="{concat('add***',$path,'/',name(..),'/entity[',$entPos,']/@variable')}" >Is same as (map)</a>
                                        </li>
                                        <li>
                                            <xsl:if test="@global_variable">
                                                <xsl:attribute name="class">disabled</xsl:attribute>
                                            </xsl:if>
                                            <img src="images/GlobalVariable-Icon.png" title="variable applied globally"/>

                                            <a class="add" title="add is Same as (global)" href="" id="{concat('add***',$path,'/',name(..),'/entity[',$entPos,']/@global_variable')}" >Is same as (global)</a>
                                        </li>
                                   

                                  
                                    </ul>
                                       
                                </div>
                               
                            </div>
                        </xsl:when>
                            
                        <xsl:otherwise> <!-- Is additional entity-->
                            
                            <div class="constant col-xs-12">           
                                <xsl:attribute name="style">
                                    <xsl:choose>
                                        <xsl:when test="instance_info/constant and .!=''">
                                            <xsl:text>display:block;padding-left:0;padding-right:0;</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>display:none;padding-left:0;padding-right:0;</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <label class=" control-label" for="sourceType" style="font-weight:normal;">is Constant</label>
                                <div class="input-group input-group-sm col-xs-12">
                                    <span class="input-group-addon">&#160;=&#160;"</span>
                                    <input id="{concat($path,'/',name(..),'/entity[',$entPos,']/instance_info/constant')}" title="is Constant" type="text" class="form-control" placeholder="Fill in value" data-xpath="{concat($path,'/',name(..),'/entity[',$entPos,']/instance_info/constant')}">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="instance_info/constant"></xsl:value-of>
                                        </xsl:attribute>
                                    </input>
                                    <span class="input-group-addon">"</span>
                                             
                                    <span class="input-group-btn">
                                        <button class="btn btn-default toggle" type="button" title="Delete Constant">
                                            <!--<span class="glyphicon glyphicon-remove"></span>-->
                                            <span class="fa fa-times "></span>

                                        </button>      
                                    </span>
                                </div>
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
                                    <!--                                    <input id="{concat($path,'/',name(..),'/entity[',$entPos,']/@variable')}" title="is Same as (map)" type="text" class="form-control" placeholder="Fill in value" data-xpath="{concat($path,'/',name(..),'/entity[',$entPos,']/@variable')}">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="@variable"></xsl:value-of>
                                        </xsl:attribute>
                                    </input>-->
                                    <input placeholder="Select a value or add new"  style="width:100%" title="is Same as (map)" type="hidden" class="select2 input-sm" data-id="{@variable}"  id="{concat($path,'/',name(..),'/entity[',$entPos,']/@variable')}" data-xpath="{concat($path,'/',name(..),'/entity[',$entPos,']/@variable')}">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="@variable"></xsl:value-of>
                                        </xsl:attribute>
                                        <img class="loader" src="js/select2-3.5.1/select2-spinner.gif"></img>
                                    </input>
                                    
                                    <span class="input-group-addon">]</span>
                                           
                                    <span class="input-group-btn">
                                        <button class="btn btn-default toggle" type="button" title="Delete is Same as (map)">
                                            <!--<span class="glyphicon glyphicon-remove"></span>-->
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
                                    <input id="{concat($path,'/',name(..),'/entity[',$entPos,']/@global_variable')}" title="is Same as (global)" type="text" class="form-control" placeholder="Fill in value" data-xpath="{concat($path,'/',name(..),'/entity[',$entPos,']/@global_variable')}">
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
                           
                           
                            <div class="description col-xs-12">
                                <xsl:attribute name="style">
                                    <xsl:choose>
                                        <xsl:when test="instance_info/description">
                                            <xsl:text>display:block;padding-left:0;padding-right:0;</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>display:none;padding-left:0;padding-right:0;</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <label class=" control-label" for="sourceType" style="font-weight:normal;">Description</label>
                                <div class="input-group  ">

                                    <textarea id="{concat($path,'/',name(..),'/entity[',$entPos,']/instance_info/description')}" placeholder="Fill in value" class="form-control input-sm" rows="3" data-xpath="{concat($path,'/',name(..),'/entity[',$entPos,']/instance_info/description')}">
                                        <xsl:value-of select="instance_info/description"></xsl:value-of>
                                    </textarea>
                                    
                                    <span class="input-group-addon" style="background-color:white;">
                                        <button class="btn btn-default btn-sm toggle" type="button" title="Delete Description"  style="border:0;">
                                            <span class="fa fa-times "></span>
                                        </button>      
                                    </span>
                                
                                </div>
                            </div>          
                            <div class="language col-xs-12 ">
                                <xsl:attribute name="style">
                                    <xsl:choose>
                                        <xsl:when test="instance_info/language">
                                            <xsl:text>display:block;padding-left:0;padding-right:0;</xsl:text>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <xsl:text>display:none;padding-left:0;padding-right:0;</xsl:text>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:attribute>
                                <label class=" control-label" for="sourceType" style="font-weight:normal;">Language</label>
                                <div class="input-group input-group-sm col-xs-12">
                                    <input  style="width:100%" title="Language" type="hidden" class="select2 input-sm" data-id="{instance_info/language}"  id="{concat($path,'/',name(..),'/entity[',$entPos,']/instance_info/language')}" data-xpath="{concat($path,'/',name(..),'/entity[',$entPos,']/instance_info/language')}">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="instance_info/language"></xsl:value-of>
                                        </xsl:attribute>
                                        <img class="loader" src="js/select2-3.5.1/select2-spinner.gif"></img>
                                    </input>
                                    <!--                                    <input id="{concat($path,'/',name(..),'/entity[',$entPos,']/instance_info/language')}" title="Language" type="text" class="form-control" placeholder="Fill in value" data-xpath="{concat($path,'/',name(..),'/entity[',$entPos,']/instance_info/language')}">
                                        <xsl:attribute name="value">
                                            <xsl:value-of select="instance_info/language"></xsl:value-of>
                                        </xsl:attribute>
                                    </input>-->
                                           
                                    <span class="input-group-btn">
                                        <button class="btn btn-default toggle" type="button" title="Delete Language">
                                            <!--<span class="glyphicon glyphicon-remove"></span>-->
                                            <span class="fa fa-times "></span>
                                        </button>      
                                    </span>
                                </div>
                            </div>
                    
                            <div class="col-xs-12" style="padding:0 0 0 0;">
                                <!--<label class="control-label" for="">&#160;</label>-->
                                <!--<div class="input-group ">-->
                                <div class=" btn-group" style="padding:0;">
                                    <button type="button" class="btn btn-link btn-sm  dropdown-toggle instance" data-toggle="dropdown" style="padding:0;border:0;">
                                        Add instance info
                                        <span class="caret"></span>
                                    </button>
                                    <ul class="dropdown-menu" role="menu">

                                        <li>
                                            <xsl:if test="instance_info/constant">
                                                <xsl:attribute name="class">disabled</xsl:attribute>
                                            </xsl:if>
                                            <img src="images/Constant-Icon.png" title="constant"/>

                                            <a class="add" href="" id="{concat('add***',$path,'/',name(..),'/entity[',$entPos,']/instance_info/constant')}">is Constant</a>
                                        </li>
                                        <li>
                                            <xsl:if test="@variable">
                                                <xsl:attribute name="class">disabled</xsl:attribute>
                                            </xsl:if>
                                            <img src="images/MapVariable-Icon.png" title="variable applied on map"/>

                                            <a  class="add" title="add is Same as (map)" href="" id="{concat('add***',$path,'/',name(..),'/entity[',$entPos,']/@variable')}">Is same as (map)</a>
                                        </li>
                                        <li>
                                            <xsl:if test="@global_variable">
                                                <xsl:attribute name="class">disabled</xsl:attribute>
                                            </xsl:if>
                                            <img src="images/GlobalVariable-Icon.png" title="variable applied globally"/>

                                            <a class="add" title="add is Same as (global)" href="" id="{concat('add***',$path,'/',name(..),'/entity[',$entPos,']/@global_variable')}" >Is same as (global)</a>
                                        </li>
                                      
                                      
                                        <li>
                                            <xsl:if test="instance_info/description">
                                                <xsl:attribute name="class">disabled</xsl:attribute>
                                            </xsl:if>
                                            <img src="images/Description-Icon.png" title="description"/>

                                            <a class="add" href="" id="{concat('add***',$path,'/',name(..),'/entity[',$entPos,']/instance_info/description')}">Description</a>
                                        </li>
                                        <li>
                                            <xsl:if test="instance_info/language">
                                                <xsl:attribute name="class">disabled</xsl:attribute>
                                            </xsl:if>
                                            <img src="images/Language-Icon.png" title="language"/>

                                            <a class="add" href="" id="{concat('add***',$path,'/',name(..),'/entity[',$entPos,']/instance_info/language')}">Language</a>
                                        </li>
                                       
                                    
                               
                                  
                                    </ul>
                                       
                                </div>
                                <!--                                    <br/>FFF<br/>-->
                                <!--</div>-->
                            </div>
             
                        </xsl:otherwise>
                    </xsl:choose>
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
                        
                  
                    <div class="additionals" data-xpath="{concat($path,'/',name(..),'/entity[',$entPos,']/additional')}">
                        <xsl:call-template name="additional">
                            <xsl:with-param name="entPos" select="$entPos"/>
                        </xsl:call-template>
                    </div>
                    
                    <button data-loading-text="Adding..."  data-xpath="{concat('add***',$path,'/',name(..),'/entity[',$entPos,']/additional')}" id="{concat('add***',$path,'/',name(..),'/entity[',$entPos,']/additional')}" title="Add Constant Expression" type="button" class="btn btn-link btn-sm  add ">
                        Add constant expression</button>

                </div>
            </xsl:otherwise>
        </xsl:choose>           
           
      
    </xsl:template>
   
</xsl:stylesheet>
