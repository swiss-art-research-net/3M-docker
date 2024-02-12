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

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
    <xsl:include href="info.xsl"/>
    <xsl:include href="mappings.xsl"/>
    <xsl:include href="extra/configuration.xsl"/>

    <xsl:template match="/">
        <xsl:text disable-output-escaping='yes'>&lt;!DOCTYPE html></xsl:text>
        <html lang="en">
            <head>
                <meta charset="utf-8"/>
                <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
                <meta name="viewport" content="width=device-width, initial-scale=1"/>
                <title>
                    <xsl:value-of select="//x3ml/info/title"/>
                </title>
                <script>
                    var id = <xsl:value-of select="//output/id"/>; 
                    var mode = <xsl:value-of select="$action"/>;
                    var sourceAnalyzer = "<xsl:value-of select="$sourceAnalyzer"/>";
                    var sourceAnalyzerFiles = "<xsl:value-of select="$sourceAnalyzerFiles"/>";
                    var sourceAnalyzerPaths = "";
                    var targetType = "<xsl:value-of select="$targetType"/>";
                    var targetFiles = "<xsl:value-of select="$targetAnalyzerFiles"/>";
                    var targetXPaths = "";
                    var generatorsStatus = "<xsl:value-of select="$generatorsStatus"/>";
                    var instanceGeneratorsNames = "";
                    var schemaVersion = "<xsl:value-of select="//output/schemaVersion"/>";
                    var RDFVisualizerURL = "<xsl:value-of select="//output/RDFVisualizerURL"/>";
                    var systemURL = "<xsl:value-of select="//output/systemURL"/>";

                </script>
                <!-- Bootstrap -->
                <link href="css/bootstrap.min.css" rel="stylesheet" media="screen,print"/>

                <link href="js/select2-3.5.1/select2.css" rel="stylesheet" />
                <link href="js/select2-3.5.1/select2-bootstrap.css" rel="stylesheet" />
                <link href="css/style.css" rel="stylesheet" media="screen,print"/>
                <link rel="shortcut icon" href="images/fav3m.png"/>

                <link href="css/fineuploader.css" rel="stylesheet"/>
                <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
                <script src="js/jquery.min.js"></script>

                <script src="js/utils.js"></script>
               
                <link rel="stylesheet" href="css/font-awesome-4.5.0/css/font-awesome.min.css"/>
                
                <xsl:if test="$action!=1"> <!-- If edit or instance mode-->
                    <link rel="stylesheet" href="js/contextMenu/jquery.contextMenu.css" />
                </xsl:if>
                
                <!-- Temp code...just testing icons-->
                <!--<link rel="stylesheet" href="//maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css"/>-->

                <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
                <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
                <!--[if lt IE 9]>
                  <script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>
                  <script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
                <![endif]-->
            </head>

            <body>
                <div class="panel panel-success">
                    <div class="panel-heading">
                        <div>
                            <img src="images/headeredit3m.png"/>
                        </div>
                        
                        <h3>Mapping : <xsl:value-of select="//x3ml/info/title"/></h3>
                        
                    </div>
                    <div class="panel-body"> <!--style="background-color:#f5f5f5"-->
                        
                         
                          
                            
                        <!-- Tab panes -->
                       
                        <div class="col-md-12">
                            <div class="tab-content">
                                
                                <ul class="nav nav-tabs" role="tablist">
                                    <li>
                                        <xsl:if test="count(//mapping)=1 and count(//mapping/link)=0">
                                            <xsl:attribute name="class">active</xsl:attribute>
                                        </xsl:if>
                                        <a href="#info" role="tab" data-toggle="tab">Info</a>
                                    </li>
                                    <li>
                                        
                                        <xsl:if test="count(//mapping)>1 or count(//mapping/link)>0">
                                            <xsl:attribute name="class">active</xsl:attribute>
                                        </xsl:if>
                                        <a href="#matching_table" role="tab" data-toggle="tab">Matching Table</a>
                                    </li>
                                    <li >
                                        <a href="#generatorsTab" role="tab" data-toggle="tab">Generators</a>
                                    </li>
                                    <li >
                                        <a href="#graph" role="tab" data-toggle="tab">Analysis</a>
                                    </li>
                                    <xsl:if test="$action!=1">
                                        <li>
                                            <xsl:choose>
                                                <xsl:when test="not(//example_data_source_record/@xml_link)">
                                                    <xsl:attribute name="class">disabled</xsl:attribute>
                                                    <xsl:attribute name="title">Add a source record xml file to enable this tab!</xsl:attribute>
                                                    <a href="#" role="tab" data-toggle="tab">Transformation</a>

                                                </xsl:when>

                                                <xsl:otherwise>
                                                    <a href="#x3mlEngine" role="tab" data-toggle="tab">Transformation</a>

                                                </xsl:otherwise>
                                            </xsl:choose>
                                                
                                        </li>
                                    </xsl:if>
                                   
                                    <li >
                                        <a href="#configuration" role="tab" data-toggle="tab">Configuration</a>
                                    </li>
                                    <li >
                                        <a href="#about" role="tab" data-toggle="tab">About</a>
                                    </li>
                                </ul>     
                               

                                <div id="info">   
                                    <xsl:attribute name="class">
                                        <xsl:choose>
                                            <xsl:when test="count(//mapping)=1 and count(//mapping/link)=0">
                                                tab-pane  fade active in
                                            </xsl:when> 
                                            <xsl:otherwise>
                                                tab-pane  fade
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:attribute>
                                    <xsl:if test="$action=0">  
                                        <div class="fixed">
                                            <div class="btn-group  btn-sm actionsToolbar" >
                                            
                                                <button id="info_edit-btn" type="button" class="btn btn-default btn-sm pull-left" data-loading-text="Loading...">
                                                    <span class="glyphicon glyphicon-pencil"></span> EDIT
                                                </button>  
                                                <button id="info_view-btn" type="button" class="btn btn-default btn-sm pull-left" data-loading-text="Loading..." style="display:none;border-left:1px solid #ddd;">
                                                    <span class="glyphicon glyphicon-eye-open"></span> VIEW MODE
                                                </button>   
                                                <button title="" id="info_rawXML-btn" type="button" class="btn btn-default btn-sm pull-left" data-loading-text="Loading...">
                                                    <span class="fa fa-lg fa-code pull-left"></span>
                                                    <span class="pull-left" style="margin-left:3px;">XML</span> 
                                                </button>          
                                            </div>            
                                        </div>                          
                                        
                                    </xsl:if>
                                    
                                    <div>
                                        <xsl:apply-templates select="//x3ml/info"/>
                                    </div>
                                </div>
                               
                          
                                <div id="matching_table">
                                    <xsl:attribute name="class">
                                        <xsl:choose>
                                            <xsl:when test="count(//mapping)>1 or count(//mapping/link)>0">
                                                tab-pane  fade active in
                                            </xsl:when> 
                                            <xsl:otherwise>
                                                tab-pane  fade
                                            </xsl:otherwise>
                                        </xsl:choose>
                                    </xsl:attribute>
                                    <xsl:if test="$action=0">
                                        <div class="fixed">
                                            <div class="btn-group  btn-sm actionsToolbar" >
                                                <button title="Click to scroll to top" id="scrollTop-btn" type="button" class="btn btn-default btn-sm" data-loading-text="Loading...">
                                                    <span class="fa fa-caret-up  fa-lg pull-left"></span> 
                                                    <span class="pull-left" style="margin-left:3px;">TOP</span>
                                                </button>
                                           
                                                <button title="Click to scroll to bottom" id="scrollBottom-btn" type="button" class="btn btn-default btn-sm" data-loading-text="Loading...">
                                                    <span class="fa fa-caret-down  fa-lg pull-left"></span> 
                                                    <span class="pull-left" style="margin-left:3px;">BOTTOM</span>
                                                </button>
                                                <button title="Click to view" id="table_view-btn" type="button" class="btn btn-default btn-sm " data-loading-text="Loading...">
                                                    <span class="glyphicon glyphicon-eye-open pull-left"></span>
                                                    <span class="pull-left" style="margin-left:5px;">VIEW MODE</span>
                                                </button>
                                                <button title="" id="rawXML-btn" type="button" class="btn btn-default btn-sm" data-loading-text="Loading...">
                                                    <span class="fa fa-lg  fa-code pull-left"></span>
                                                    <span class="pull-left" style="margin-left:3px;">XML</span> 
                                                </button>
                                           
                                            </div>
                                    
                                            <div class="btn-group  btn-sm actionsToolbar" >
                                                <button title="Click to collapse column" id="allSources-btn" type="button" class="btn btn-default btn-sm col-sm-2 columnHide" data-loading-text="Loading...">
                                                    <span class="pull-left" style="margin-left:3px;">(ALL) SOURCES</span> 
                                                    <img class="pull-left" src="images/collapse-column.png" />
                                                </button>
                                                <button title="Click to collapse column" id="allTargetPaths-btn" type="button" class="btn btn-default btn-sm col-sm-2 columnHide" data-loading-text="Loading...">
                                                    <span  style="margin-left:3px;">(ALL) TARGET PATHS</span> 
                                                    <img   src="images/collapse-column.png" />

                                                </button>
                                                <button title="Click to collapse column" id="allTargets-btn" type="button" class="btn btn-default btn-sm col-sm-2 columnHide" data-loading-text="Loading...">
                                                    <span  style="margin-left:3px;">(ALL) TARGETS</span> 
                                                    <img   src="images/collapse-column.png" />

                                                </button>
                                                <button title="Click to collapse column" id="allRules-btn" type="button" class="btn btn-default btn-sm col-sm-2 columnHide" data-loading-text="Loading...">
                                                    <img class="pull-right"  src="images/collapse-column.png" />
                                                    <span class="pull-right" style="margin-left:3px;">(ALL) IF RULES</span> 

                                                </button>
                                                <button title="Click to collapse column" id="allComments-btn" type="button" class="btn btn-default btn-sm col-sm-2 columnHide" data-loading-text="Loading...">
                                                    <img class="pull-right"  src="images/collapse-column.png" />
                                                    <span class="pull-right" style="margin-left:3px;">(ALL) COMMENTS</span> 

                                                </button>
                                                <button title="Click to collapse/expand all maps" id="collapseExpandAll-btn" type="button" class="btn btn-default btn-sm col-sm-2" data-loading-text="Loading...">
                                                    <img class="pull-right"  src="images/collapse-map.png" />
                                                    <span class="pull-right" style="margin-left:3px;">(ALL) MAPS</span>
                                                </button>

                                            </div>
                                        </div>
                                    
                                    </xsl:if>
                                    <!--<div class="mappings">-->  
                                    <xsl:apply-templates select="//mappings"/>
                                    <!--</div>-->
                                
                                </div>
                                <div class="tab-pane fade " id="configuration">
                                    
                                    <div>  
                                        <xsl:call-template name="configuration"/>
                                    </div>
                                
                                </div>
                                <div class="tab-pane fade " id="generatorsTab">
                                </div>
                                <div class="tab-pane fade " id="graph">
                                </div>
                                <div class="tab-pane fade " id="x3mlEngine">                                                                   
                                </div>
                                <div class="tab-pane fade " id="about">
                                </div>
                                
                            </div>
                        </div>
                        

                        
                    </div>
                </div>
               
                <span  class="pull-right smallerIcon">
                    User:<xsl:value-of select="//admin/locked"/>
                </span>
                <div class="row">
                    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12" id="footer">
                        <div class="row" style="background-color:#5B5B5B;">
                            <div class="col-md-12 text-center" style="margin-top:5px;margin-bottom:5px;">
                                <a href="http://www.ics.forth.gr/" target="_blank">
                                    <img id="forthImg" src="images/forth_en.png"/>
                                </a>
                                <a href="http://www.ics.forth.gr/isl" target="_blank">
                                    <img src="images/isl_en.png"/>
                                </a>
                                <a href="https://www.ics.forth.gr/isl/index_main.php?c=252" target="_blank">
                                    <img src="images/cci_en.png"/>
                                </a>
                            </div>
                        </div>
                        <div class="row" style="height:40px;    background-color: black;">
                            <div class="col-md-12 text-center" style="margin-top:13px;font-size:12px;color:white;">
                                <a style="color:white!important;text-decoration:none;" target="_blank" href="{//output/systemURL}/Privacy?action=conditions&amp;lang=en">Terms of Use</a>
                                |
                                <a target="_blank" style="padding-left:0px!important;color:white!important;text-decoration:none;" href="{//output/systemURL}/Privacy?action=privacy&amp;lang=en">Privacy Policy</a>
                                | © 
                     
                                2012-<span id="year">2019</span> 
                                <script>$("#year").html((new Date()).getFullYear());</script>
                                <a target="_blank" style="font-size:12px;padding-left:0px!important;color:white!important;text-decoration:none;" href="http://www.ics.forth.gr/isl"> FORTH-ICS</a>
                                |
                                Licensed under the EUPL
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal -->
                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
                    <div class="modal-dialog modal-lg">
                        <div class="modal-content">
                            <div class="modal-header">
                                <button type="button" class="closeLike" data-dismiss="modal" aria-hidden="true">
                                    <span class="fa fa-times smallerIcon" ></span>
                                </button>
                                <h4 class="modal-title">Raw XML for path: <span class="xpath"></span></h4>

                            </div>
                            <div class="modal-body">
                                
                                <textarea style="width:100%;" placeholder="Fill in value" class="form-control input-sm" rows="20">

                                </textarea>

                            </div>
                                  
                            <div class="modal-footer">
                              
                                <!--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>-->
                                <button type="button" style="display:inline;" class="btn btn-primary saveXML-btn">Update</button>
                                <span class="pull-left"  style="width:90%;font-weight:bold;text-align:left;display:inline">WARNING! Clicking 'Update' is a powerful feature and should be used only if what you are trying
                                    to do cannot be achieved by normal edit mode. If update is complete, you cannot undo what you have done.</span>
                            </div>
                           
                        </div>
                        <!-- /.modal-content -->
                    </div>
                    <!-- /.modal-dialog -->
                </div>
                <!-- /.modal -->
              
                <script src="js/bootstrap.min.js"></script>
                <script src="js/commonEvents.js"></script>
                <xsl:if test="$action!=1"> <!-- If edit or instance mode-->
                    <script src="js/contextMenu/jquery.contextMenu.min.js"></script>
                    <script src="js/contextMenus.js"></script>
                    <script src="js/linkify.min.js"></script>
                    <script src="js/linkify-jquery.min.js"></script>


                    <script src="js/combos.js"></script>
                    <script src="js/editUtils.js"></script>
                    <script src="js/editEvents.js"></script>
                    
                </xsl:if>

                <script src="js/select2-3.5.1/select2.min.js"/>
                <script src="js/jquery.fineuploader-3.0.js"/>
                <input id="comboAPI" type="hidden" value="{//output/mode}"/>
                <input id="generator" type="hidden" value="{//output/generator}"/>
                <input id="tps" type="hidden" value="{//output/components/tps}"/>

            </body>
        </html>
    </xsl:template>
    <xsl:template match="admin|output/*[name()!='xml']"/>
</xsl:stylesheet>
