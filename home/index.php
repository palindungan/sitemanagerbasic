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

$intro  = '<b>SiteManager Test Suite</b>';

// add intro
$layout1->addText($intro, 'main');

// finish display
$SM_siteManager->completePage();
