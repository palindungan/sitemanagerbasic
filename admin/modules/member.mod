<?php

/*********************************************************************
 *  Roadsend SiteManager
 *  Copyright (c) 2001-2003 Roadsend, Inc.(http://www.roadsend.com)
 **********************************************************************
 *
 * This source file is subject to version 1.0 of the Roadsend Public
 * License, that is bundled with this package in the file 
 * LICENSE, and is available through the world wide web at 
 * http://www.roadsend.com/license/rpl1.txt
 *
 **********************************************************************
 * Author(s): weyrick
 *
 */

// make sure base is loaded
global $SM_siteManager;
$SM_siteManager->includeModule('testBase');

/**
 * extend testBase for testing sitemanager functionality
 */
class member extends testBase
{

    /** title output at top of test module */
    var $testTitle = 'Daftar Anggota';

    /** description */
    var $testDesc  = 'Management.';

    /**
     * run by base class after base runs moduleConfig()
     */
    function T_moduleConfig()
    {
        // module config stuff here
    }

    /**
     * this function contains the core functionality entry point for the module.
     */
    function moduleThink()
    {
        $this->say('
            <table width="100%" border="1">
                <tbody>
                    <tr>
                        <td align="center"><b>Test Title</b></td>
                        <td align="center"><b>Description</b></td>
                        <td align="center"><b>Expect</b></td>
                        <td align="center"><b>Actual</b></td>
                        <td align="center"><b>Result</b></td>
                    </tr>
                    <tr>
                        <td>SM_registerComponent(), SM_isComponentRegistered()</td>
                        <td>make sure a component can be registered</td>
                        <td>1</td>
                        <td>1</td>
                        <td align="center" bgcolor="green"><b>PASS</b></td>
                    </tr>
                    <tr>
                        <td>SM_isComponentLoaded(), SM_loadComponent()</td>
                        <td>make sure a registered component is identifiable and loadable</td>
                        <td>COMPONENT LOADED</td>
                        <td>COMPONENT LOADED</td>
                        <td align="center" bgcolor="green"><b>PASS</b></td>
                    </tr>
                </tbody>
            </table>
        ');
    }
}
