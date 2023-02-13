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
    var $testDesc  = 'Deskripsi.';

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
        $SQL = "SELECT * FROM members";
        $rh = $this->dbH->query($SQL);
        SM_dbErrorCheck($rh, $SQL);

        $htmlTableRow = "";
        while ($rr = $rh->fetch()) {
            $htmlTableRow .= '
                <tr>
                    <td>' . $rr['userName'] . '</td>
                    <td>' . $rr['emailAddress'] . '</td>
                    <td>' . $rr['firstName'] . '</td>
                    <td>' . $rr['lastName'] . '</td>
                    <td>' . $rr['dateCreated'] . '</td>
                </tr>
            ';
        }

        $htmlTable = '
            <table width="100%" border="1">
                <tbody>
                    <tr>
                        <td align="center"><b>userName</b></td>
                        <td align="center"><b>emailAddress</b></td>
                        <td align="center"><b>firstName</b></td>
                        <td align="center"><b>lastName</b></td>
                        <td align="center"><b>dateCreated</b></td>
                    </tr>
                    ' . $htmlTableRow . '
                </tbody>
            </table>
        ';

        $this->say($htmlTable);
    }
}
