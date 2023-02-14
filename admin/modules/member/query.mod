<?php

class query extends SM_module
{
    function getData($param = array())
    {
        $SQL = "SELECT * FROM members";
        $query = $this->dbH->query($SQL);
        SM_dbErrorCheck($query, $SQL);

        return $query;
    }
}
