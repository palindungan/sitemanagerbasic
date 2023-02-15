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
 * base module for test modules
 *
 * this provides common testing support methods
 *
 */
class baseModule extends SM_module
{
    function moduleConfig()
    {
        // run child class T_moduleConfig, if it exists
        if (method_exists($this, 'T_moduleConfig')) {
            $this->T_moduleConfig();
        }
    }
}
