<?php
require_once "query.mod";

class dataTable extends SM_module
{
    function init()
    {
        $query = $this->data();

        $row = "";
        while ($item = $query->fetch()) {
            $row .= '
                <tr>
                    <td>' . $item['idxNum'] . '</td>
                    <td>' . $item['userName'] . '</td>
                    <td>
                        <a href="">Delete</a>
                    </td>
                </tr>
            ';
        }

        return $row;
    }

    function data($param = array())
    {
        $query = new query();
        return $query->getData();
    }
}
