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
$layout1 = $SM_siteManager->rootTemplate("main.cpt");

$intro  = '<b>Home</b>';

if (defined('ROADSEND_PCC')) {
    $stats = re_memo_stats();
    $intro .= "<br><br>Roadsend AST Cache Stats:<br>Hits: {$stats['hits']}<br>Misses: {$stats['misses']}<br>Resets: {$stats['resets']}<br>";
}

// add intro
$layout1->addText($intro, 'main');

// finish display
$SM_siteManager->completePage();
