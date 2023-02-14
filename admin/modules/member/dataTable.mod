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
                    <td>' . $item['uID'] . '</td>
                    <td>' . $item['userName'] . '</td>
                    <td>' . $item['passWord'] . '</td>
                    <td>' . $item['emailAddress'] . '</td>
                    <td>' . $item['firstName'] . '</td>
                    <td>' . $item['lastName'] . '</td>
                    <td>' . $item['dateCreated'] . '</td>
                    <td>
                        <a href="index.php?menu=member&layout=edit&id=' . $item['idxNum'] . '">Edit</a>
                        <a href="index.php?menu=member&action=destroy&id=' . $item['idxNum'] . '">Delete</a>
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
