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
 * menu
 *
 */
class nFunctionMenu extends SM_module
{
    /**
     * configure the module. run before moduleThink
     */
    function moduleConfig()
    {
        $this->ngMenu = $this->loadModule('ngMenu');
    }

    /**
     * this function contains the core functionality entry point for the module.
     */
    function moduleThink()
    {
        // get the menu module, using keyword set in moduleConfig()
        $menu = $this->ngMenu;

        // build menu

        $item = $menu->addItem('SITEMANAGER');
        $item->addLinkItem('Home', 'index.php');
        $item->addLinkItem('Member', 'index.php?menu=member');
        $item->addLinkItem('Member 2', 'member2.php');

        // output menu
        $this->say($menu->run());
    }
}
