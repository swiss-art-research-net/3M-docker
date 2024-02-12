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
    <xsl:include href="source_intermediate.xsl"/>
    <!--    <xsl:include href="if-rule.xsl"/>-->

    <xsl:output method="html"/>

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="path">
        <xsl:param name="mappingPos"/>
             

        <tr data-xpath="{//path/@xpath}" id="{//path/@xpath}">
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="//path/@noRelation">
                        <xsl:text>edit noRelation</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>  
                        <xsl:text>edit</xsl:text>              
                    </xsl:otherwise>
                </xsl:choose>    
            </xsl:attribute>
            
           
            
            <td rowspan="2" style="text-align:center;vertical-align:middle;">
                <xsl:value-of select="@index"></xsl:value-of>
            </td>
            <td title="{//path/@xpath}">P</td>
            <td  style="background-color:white;padding:0 0 0 0;min-width:200px;" class="sourceCol">
                

                <xsl:choose>
                    <xsl:when test="//path/@noRelation">
                        <div style="margin-top:15px;margin-left:30px;">
                            <i class="fa fa-repeat" aria-hidden="true"></i>
                            <button data-xpath="" id="" title="" type="button" class="btn noRelationRestore btn-link btn-sm">
                                Restore source relation
                            </button>
                        </div>
                    </xsl:when>
                    <xsl:otherwise>                
                        <xsl:apply-templates select="source_relation"/>               
                    </xsl:otherwise>
                </xsl:choose>    
                           
            </td>
             <td style="padding:1 1 1 1;min-width:50px;" class="templateCol">
                    <div class="row">
                    <label class="control-label topPadded" for="{concat(//path/@xpath,'../@template')}">Template</label>
                                    
                    <input placeholder="Select a value or add new"  style="width:100%" title="template" type="hidden" class="select2 input-sm" data-id="{../@template}"  id="{concat(//path/@xpath,'/../@template')}" data-xpath="{concat(//path/@xpath,'/../@template')}">
                        <xsl:attribute name="value">
                            <xsl:value-of select="../@template"></xsl:value-of>
                        </xsl:attribute>
                        <img class="loader" src="js/select2-3.5.1/select2-spinner.gif"></img>
                    </input>
                </div>
            </td>
            <td style="min-width:600px;padding:0 0 0 0;" class="targetCol">        
                <xsl:for-each select="target_relation">
                    <xsl:call-template name="target_relation"/>
                </xsl:for-each>
                               
            </td>
            <td class="ifCol">                

                <xsl:for-each select="target_relation">
                    <div class="rules" data-xpath="{concat(//path/@xpath,'/target_relation/if')}">
                        <xsl:call-template name="if-ruleBlock"></xsl:call-template>    
                        <xsl:call-template name="addRuleButton"></xsl:call-template>    
                    </div>
                </xsl:for-each>         
            </td>
            <td class="commentsHead">        
                <div class="comments" id="{concat(//path/@xpath,'/comments')}" data-xpath="{concat(//path/@xpath,'/comments')}">                       
                    <xsl:apply-templates select="comments"/>                         
                </div>
                <xsl:call-template name="addCommentButton"></xsl:call-template>    

                <!--<span class="glyphicon glyphicon-plus"></span>&#160;Comments</button>-->
            </td>
            <td class="actions" style="display:none;" >
             
                <div class="btn-group-vertical pull-right">
                   
                    
                    <button title="Copy Link" type="button" class="btn btn-default btn-xs closeLike copy" id="{concat('copy***',//path/@xpath,'/..')}"> 
                        <span class="fa fa-files-o smallerIcon" ></span> 
                    </button>
                    <br/>
                    <button title="Paste Link" type="button" class="btn btn-default btn-sm closeLike paste" id="{concat('paste***',//path/@xpath,'/..')}"> 
                        <span class="fa fa-clipboard smallerIcon"></span> 
                    </button>
                    <br/>
                    <button title="Delete Link" type="button" class="close btn btn-sm" id="{concat('delete***',//path/@xpath,'/..')}">
                        <!--<span aria-hidden="true">x</span>-->
                        <span class="fa fa-times smallerIcon" ></span>
                        <span class="sr-only">Close</span>
                    </button>
                    <!--<i class="fa fa-scissors"></i>-->
                </div>
              
               
                            
            </td>

        </tr>         
 
                   
    </xsl:template>

    

    <xsl:template match="source_relation">
              
        <xsl:apply-templates select="relation[1]">
            <xsl:with-param name="pos" select="1"/>
        </xsl:apply-templates>
     
        
        <div class="intermediates" id="{concat(//path/@xpath,'/source_relation/intermediate')}" data-xpath="{concat(//path/@xpath,'/source_relation/intermediate')}">

            <xsl:for-each select="node">
                <xsl:variable name="nodePos" select="position()"/>
                <div class="source_intermediate" id="{concat(//path/@xpath,'/source_relation/intermediate[',$nodePos,']')}" data-xpath="{concat(//path/@xpath,'/source_relation/intermediate[',$nodePos,']')}">
  
                    <!--                    <button title="Delete Intermediate" type="button" class="close" id="{concat('delete***',//path/@xpath,'/source_relation/intermediate[',$nodePos,']')}">
                        <span aria-hidden="true">x</span>
                        <span class="sr-only">Close</span>
                    </button>-->
                    <button title="Delete Intermediate" type="button"  class="close btn btn-sm"  id="{concat('delete***',//path/@xpath,'/source_relation/intermediate[',$nodePos,']')}">
                        <span class="fa fa-times smallerIcon" ></span>
                        <span class="sr-only">Close</span>
                    </button>
                    
               
                    <xsl:apply-templates select=".">
                        <xsl:with-param name="nodePos" select="$nodePos"/>
                    </xsl:apply-templates>
                    <xsl:for-each select="following-sibling::relation[1]">
                        <xsl:call-template name="relation">
                            <xsl:with-param name="pos" select="$nodePos+1"/>

                        </xsl:call-template>
                    </xsl:for-each>
                 
                </div>
            </xsl:for-each>
        </div>
        <div class="col-xs-11">
            <button data-loading-text="Adding..." style="padding-left: 22px;" data-xpath="{concat(//path/@xpath,'/source_relation/intermediate')}" id="{concat('add***',//path/@xpath,'/source_relation/intermediate')}" title="Add Intermediate" type="button" class="btn btn-link btn-sm  add">
                Add intermediate</button>
        </div>
        <div class="col-xs-11">
            <button data-xpath="" id="" title="This feature allows to map the source domain to
 2 different target nodes, which are associated via the relation specified in the target." type="button" class="btn noRelationUpdate btn-link btn-sm">
                Set blank source relation</button>
        </div>
        
        

    </xsl:template>

</xsl:stylesheet>
