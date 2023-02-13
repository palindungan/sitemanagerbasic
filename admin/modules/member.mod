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
    var $testTitle = 'Anggota';
    var $testDesc  = 'Deskripsi.';

    /**
     * run by base class after base runs moduleConfig()
     */
    function T_moduleConfig()
    {
        // module config stuff here
        $this->addInVar('action', '');
        $this->addInVar('form', '');

        if ($this->getVar('form') == '' || $this->getVar('form') == 'index') {
            $this->testTitle = 'Daftar Anggota';
            $this->testDesc  = 'Deskripsi.';
        }

        if ($this->getVar('form') == 'edit') {
            $this->testTitle = 'Edit Data';
            $this->testDesc  = 'Deskripsi.';
        }
    }

    /**
     * this function contains the core functionality entry point for the module.
     */
    function moduleThink()
    {
        if ($this->getVar('action') != '') {
            if ($this->getVar('action') == 'update') {
                $this->update();
            }

            if ($this->getVar('action') == 'destroy') {
                $this->destroy();
            }
        } else {
            if ($this->getVar('form') == '' || $this->getVar('form') == 'index') {
                $this->index();
            }

            if ($this->getVar('form') == 'edit') {
                $this->edit();
            }
        }
    }

    function index()
    {
        $SQL = "SELECT * FROM members";
        $query = $this->dbH->query($SQL);
        SM_dbErrorCheck($query, $SQL);

        $htmlTableRow = "";
        while ($item = $query->fetch()) {
            $htmlTableRow .= '
                <tr>
                    <td>' . $item['userName'] . '</td>
                    <td>' . $item['emailAddress'] . '</td>
                    <td>' . $item['firstName'] . '</td>
                    <td>' . $item['lastName'] . '</td>
                    <td>' . $item['dateCreated'] . '</td>
                    <td>
                        <a href="member.php?form=edit&id=' . $item['idxNum'] . '">Ubah</a>
                    </td>
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
                        <td align="center"><b>action</b></td>
                    </tr>
                    ' . $htmlTableRow . '
                </tbody>
            </table>
        ';

        $this->say($htmlTable);
    }

    function edit()
    {
    }

    function update()
    {
    }

    function destroy()
    {
    }
}
