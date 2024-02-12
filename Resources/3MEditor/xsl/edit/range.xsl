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

    <!-- TODO customize transformation rules 
         syntax recommendation http://www.w3.org/TR/xslt 
    -->
    <xsl:template match="range">
      
        <tr data-xpath="{//range/@xpath}" >
            <xsl:attribute name="class">
                <xsl:choose>
                    <xsl:when test="//range/@noRelation">
                        <xsl:text>edit noRelation</xsl:text>
                    </xsl:when>
                    <xsl:otherwise>  
                        <xsl:text>edit</xsl:text>              
                    </xsl:otherwise>
                </xsl:choose>    
            </xsl:attribute>
             <td style="display:none;"><!--Dummy cell added to be uniform with path row-->
                
            </td>
            <td title="{//range/@xpath}">R</td>
            <td style="padding:0 0 0 0;" class="sourceCol">
                <div class="row "  style="margin-left:0px;">
                    <div class="col-xs-1 icon">
                        <label class="control-label" for="">&#160;</label>
                        <xsl:choose>
                            <xsl:when test="//range/@noRelation">
                               
                                <img src="images/domain.png" style="margin-top:13px;"/>
                            </xsl:when>
                            <xsl:otherwise>
                                <img src="images/range.png"/>
                            </xsl:otherwise>
                        </xsl:choose>
                    </div>
            
                    <div class="col-xs-9">
                        <div class="form-group">

                            <label class="control-label topPadded" for="pathSourceNode"  style="min-width:80px;">Source Node</label>
                            
                            <xsl:choose>
                                <xsl:when test="//range/@noRelation">
                                    <p class="form-control-static">
                                        <xsl:call-template name="stripPath">
                                            <xsl:with-param name="path" select="source_node" />
                                        </xsl:call-template>                                    
                                    </p>
                                </xsl:when>
                                <xsl:otherwise>                
                                    <xsl:choose>
                                        <xsl:when test="//*/@sourceAnalyzer='off'">                                 
                                            <input title="Source Node"  id="pathSourceNode" type="text" class="form-control input-sm" placeholder="Fill in value" data-xpath="{concat(//range/@xpath,'/source_node')}">
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="source_node"/>                    
                                                </xsl:attribute>
                                            </input>
                                        </xsl:when>
                                        <xsl:otherwise>
                                            <input style="width:100%" title="Source Node" type="hidden" class="select2 input-sm" data-id="{source_node}" id="pathSourceNode" data-xpath="{concat(//range/@xpath,'/source_node')}">
                                                <xsl:attribute name="value">
                                                    <xsl:value-of select="source_node"></xsl:value-of>
                                                </xsl:attribute>
                                                <img class="loader" src="js/select2-3.5.1/select2-spinner.gif"></img>
                                            </input>
                                        </xsl:otherwise>
                                    </xsl:choose>
                                </xsl:otherwise>
                            </xsl:choose>    
                          

                        </div>
                    </div>
                </div>
                
                
                
              
                
            </td>
             <td style="padding:0 0 0 0;min-width:50px;" class="templateCol">
            </td>
            <td style="padding:0 0 0 0;" class="targetCol">
                <xsl:for-each select="target_node/entity">
                    <xsl:variable name="entPos" select="position()"/>

                    <div class="row  bottom-bordered" >
                        <div class="col-xs-1 icon">
                            <label class="control-label" for="">&#160;</label>
                            <img src="images/range.png"/>
                        </div>
                        <div class="col-xs-11 rels">
               
                            <xsl:call-template name="entity">
                                <xsl:with-param name="entPos" select="$entPos"/>

                            </xsl:call-template>
                        </div>
                    </div>
                    
                    
                
                </xsl:for-each>
            </td>
            <td class="ifCol">           
                <!--<label class="control-label" for="">Rules</label>--> 
                <xsl:for-each select="target_node">
                    <div class="rules" data-xpath="{concat(//range/@xpath,'/target_node/if')}">
                        <xsl:call-template name="if-ruleBlock"></xsl:call-template> 
                        <xsl:call-template name="addRuleButton"></xsl:call-template>  
                    </div>  

                </xsl:for-each>            
            </td>
            <td class="commentsHead">         
                <div class="comments" id="{concat(//range/@xpath,'/comments')}" data-xpath="{concat(//range/@xpath,'/comments')}">                       
                    <xsl:apply-templates select="comments"/>                         
                </div>
                <xsl:call-template name="addCommentButton"></xsl:call-template>   
                
                      
            </td>

            <td class="actions" style="display:none;"></td>

        </tr>      
                      
    </xsl:template>

</xsl:stylesheet>
