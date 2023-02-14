<?php
require_once "dataTable.mod";
require_once "query.mod";

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

/**
 * extend testBase for testing sitemanager functionality
 */
class module extends SM_module
{
    public $query;

    function __construct()
    {
        $this->query = new query();
    }

    /**
     * run by base class after base runs moduleConfig()
     */
    function T_moduleConfig()
    {
    }

    /**
     * this function contains the core functionality entry point for the module.
     */
    function moduleThink()
    {
        $layout = $_GET['layout'];
        $action = $_GET['action'];
        $id = $_GET['id'];

        if ($action == 'destroy') {
            $this->destroy($id);
        }

        if ($layout == '' || $layout == 'index') {
            $this->index();
        }

        if ($layout == 'create') {
            $this->create();
        }

        if ($layout == 'edit') {
            $this->edit();
        }
    }

    function index()
    {
        $action = $_GET['action'];

        // get data datatable
        if ($action == 'dataTable') {
            $dataTableClass = new dataTable();
            header('Content-Type: application/json');
            die(json_encode($dataTableClass->init()));
        }

        // page content
        $pageContent = $this->loadTemplate('../admin/templates/member/index');

        // add table layout
        $dataTableTemplate = $this->loadTemplate('../admin/templates/member/table');
        $pageContent->addTemplate($dataTableTemplate, 'dataTable');

        $this->say($pageContent->run());
    }

    function create()
    {
        $action = $_GET['action'];

        $myForm = $this->form();
        $myForm->directive['formAttributes'] = 'role="form" enctype="multipart/form-data"';
        $myForm->directive['postScript'] = 'index.php?menu=member&layout=create&action=store';
        $myForm->runForm(); // apply the form

        // verify data, if good, do sql or email, or whatever you'd like with your data
        if ($myForm->dataVerified()) {
            if ($action == 'store') {
                $this->store($myForm);
            }
        } else {
            // show form
            $pageContent = $this->loadTemplate('../admin/templates/member/create');
            $pageContent->addText($myForm->output('Submit'), "myForm");
            $this->say($pageContent->run());
        }
    }

    function store($myForm)
    {
        $this->query->store(["myForm" => $myForm]);
        header("Location: index.php?menu=member");
    }

    function edit()
    {
        $action = $_GET['action'];
        $id = $_GET['id'];

        $query = $this->query->getData(["get_by_idxNum" => $id,]);
        $item = $query->fetch();

        $myForm = $this->form($item);
        $myForm->directive['formAttributes'] = 'role="form" enctype="multipart/form-data"';
        $myForm->directive['postScript'] = 'index.php?menu=member&layout=edit&id=' . $id . '&action=update';
        $myForm->runForm(); // apply the form

        // verify data, if good, do sql or email, or whatever you'd like with your data
        if ($myForm->dataVerified()) {
            if ($action == 'update') {
                $this->update($id, $myForm);
            }
        } else {
            // show form
            $pageContent = $this->loadTemplate('../admin/templates/member/edit');
            $pageContent->addText($myForm->output('Submit'), "myForm");
            $this->say($pageContent->run());
        }
    }

    function update($id, $myForm)
    {
        $this->query->update([
            "id" => $id,
            "myForm" => $myForm
        ]);
        header("Location: index.php?menu=member");
    }

    function destroy($id)
    {
        $this->query->destroy(["id" => $id,]);
        header("Location: index.php?menu=member");
    }

    function form($item = [])
    {
        if (empty($item)) {
            $item['idxNum'] = '';
            $item['uID'] = '';
            $item['userName'] = '';
            $item['passWord'] = '';
            $item['emailAddress'] = '';
            $item['firstName'] = '';
            $item['lastName'] = '';
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

        $idxNum = $myForm->add('idxNum', 'IDXNUM', 'text', true, $item['idxNum']);
        $idxNum->addFilter('number', 'Bad IDXNUM');

        $myForm->add('uID', 'UID', 'text', true, $item['uID']);
        $myForm->add('userName', 'User Name', 'text', true, $item['userName']);
        $myForm->add('passWord', 'Password', 'text', true, $item['passWord']);

        $emailAddress = $myForm->add('emailAddress', 'Email Address', 'text', true, $item['emailAddress']);
        $emailAddress->addFilter('email', 'Bad Email Address');
        $emailAddress->addDirective('entityAttributeClassTag', 'sfNormal1');

        $myForm->add('firstName', 'First Name', 'text', false, $item['firstName']);
        $myForm->add('lastName', 'Last Name', 'text', false, $item['lastName']);
        $myForm->add('dateCreated', 'Date Create', 'text', false, $item['dateCreated']);

        return $myForm;
    }
}
