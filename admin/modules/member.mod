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
    /**
     * run by base class after base runs moduleConfig()
     */
    function T_moduleConfig()
    {
        // module config stuff here
        $this->addInVar('action', '');
        $this->addInVar('form', '');

        if ($this->getVar('form') == '' || $this->getVar('form') == 'index') {
            $this->testTitle = 'Data List Member';
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
        if ($this->getVar('action') == 'destroy') {
            $this->destroy();
        }

        if ($this->getVar('form') == '' || $this->getVar('form') == 'index') {
            $this->index();
        }

        if ($this->getVar('form') == 'edit') {
            $this->edit();
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
        $this->addInVar('id', 0);

        $SQL = "SELECT * FROM members WHERE idxNum = " . $this->getVar('id') . " LIMIT 1";
        $query = $this->dbH->query($SQL);
        SM_dbErrorCheck($query, $SQL);
        $item = $query->fetch();
        // $this->say("Nama : " . $item["userName"]);

        $myForm = $this->form($item);
        $myForm->directive['formAttributes'] = 'role="form" enctype="multipart/form-data"';
        $myForm->directive['postScript'] = 'member.php?form=edit&id=' . $this->getVar('id') . '&action=update';
        $myForm->runForm(); // apply the form

        // verify data, if good, do sql or email, or whatever you'd like with your data
        if ($myForm->dataVerified()) {
            $this->say("data was verified:<br><br>");

            $this->say($myForm->dumpFormVars());

            $this->say("<br>variables from form:<br><br>");
            $this->saybr(join("<br>", $myForm->getVarList()));

            if ($this->getVar('action') == 'update') {
                $this->update();
            }
        } else {
            // fall through, data wasn't verified, show form
            // output the form 
            $this->say($myForm->output('Submit', array('testHidden2' => 'testval')));
        }
    }

    function update()
    {
        $this->say("<br>DATA UPDATED<br><br>");
    }

    function destroy()
    {
    }

    function form($item = array())
    {
        if (empty($item)) {
            $item['idxNum'] = '';
            $item['firstName'] = '';
            $item['lastName'] = '';
            $item['emailAddress'] = '';
            $item['userName'] = '';
            $item['passWord'] = '';
            $item['dateCreated'] = '';
        }

        // create the form
        $myForm = $this->newSmartForm('myForm');
        $myForm->addDirective('badFormMessage', '
            <center>
                <b>
                    <br>
                    There is a problem with the form input. Please correct your input and try again.
                </b>
                <br><br>
            </center>
        ');
        $myForm->addDirective('cleanHiddens', true);
        $myForm->addDirective('dumpTemplate', true);

        $idxNum = $myForm->add('idxNum', 'ID', 'text', true, $item['idxNum']);
        $idxNum->addFilter('number', 'Bad ID');

        $myForm->add('firstName', 'First Name', 'text', false, $item['firstName']);
        $myForm->add('lastName', 'Last Name', 'text', false, $item['lastName']);

        $emailAddress = $myForm->add('emailAddress', 'Email Address', 'text', false, $item['emailAddress']);
        $emailAddress->addFilter('email', 'Bad Email Address');
        $emailAddress->addDirective('entityAttributeClassTag', 'sfNormal1');

        $myForm->add('userName', 'User Name', 'text', false, $item['userName']);
        $myForm->add('passWord', 'Password', 'text', false, $item['passWord']);

        $myForm->add('dateCreated', 'Date Create', 'text', false, $item['dateCreated']);

        return $myForm;
    }
}
