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

/**
 * extend testBase for testing sitemanager functionality
 */
class home extends SM_module
{
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
        if ($this->getVar('form') == '' || $this->getVar('form') == 'index') {
            $this->index();
        }
    }

    function index()
    {
        $this->say("<b>Home</b>");
    }
}
