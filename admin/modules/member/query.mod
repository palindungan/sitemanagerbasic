<?php

class query extends SM_module
{
    function getData($param = array())
    {
        $get_by_search = "";
        if (isset($param['search']) && !empty($param['search'])) {
            $get_by_search =
                " " .
                "AND (
                    members.idxNum LIKE '%" . $param['search'] . "%' OR
                    members.uID LIKE '%" . $param['search'] . "%' OR
                    members.userName LIKE '%" . $param['search'] . "%' OR
                    members.passWord LIKE '%" . $param['search'] . "%' OR
                    members.emailAddress LIKE '%" . $param['search'] . "%' OR
                    members.firstName LIKE '%" . $param['search'] . "%' OR
                    members.lastName LIKE '%" . $param['search'] . "%' OR
                    members.dateCreated LIKE '%" . $param['search'] . "%'
                )" .
                " ";
        }

        $limit = "";
        if (isset($param['limit']) && !empty($param['limit'])) {
            $limit =
                " " . "AND LIMIT " . $param['limit'] . " ";
        }

        $offset = "";
        if (isset($param['offset']) && !empty($param['offset'])) {
            $offset =
                " " . "AND OFFSET " . $param['offset'] . " ";
        }

        $select = " " . "members.*, members.idxNum AS action" . " ";
        if (isset($param['select']) && !empty($param['select'])) {
            $select =
                " " . $param['select'] . " ";
        }

        $SQL = "
            SELECT
                " . $select . "
            FROM members
            WHERE
                members.idxNum > 0
                " . $get_by_search . "
                " . $limit . "
                " . $offset . "
        ";

        $query = $this->dbH->query($SQL);
        SM_dbErrorCheck($query, $SQL);

        return $query;
    }
}
