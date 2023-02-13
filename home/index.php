<?php

/*

    Project: 
    using code from Roadsend PHP SiteManager (www.roadsend.com)
    
    description   : directive script

    change history:
            
                    
*/

// include site configuration file, which includes siteManager libs
require('../admin/common.inc');

// create root template. notice, returns a reference!!
$SM_siteManager->rootTemplate("main.cpt");

// finish display
$SM_siteManager->completePage();
