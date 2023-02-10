<?php

/*

    Project: 
    using code from Roadsend PHP SiteManager (www.roadsend.com)
    
    description   :

    change history:
            
                xx/xx/xx - script created by xxxx
                    
*/

// include site configuration file, which includes siteManager libs
require('../admin/common.inc');

// create root template. notice, returns a reference!!
$layout1 = $SM_siteManager->rootTemplate("main.cpt");

// load requested module
$mod = $SM_siteManager->loadModule('item');

// add the module to the codePlate
$layout1->addModule($mod, 'main');

// finish display
$SM_siteManager->completePage();
