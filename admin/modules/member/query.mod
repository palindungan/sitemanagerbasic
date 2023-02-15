<?php
require_once "../admin/modules/baseModule.mod";

global $SM_siteManager;
$SM_siteManager->includeModule('baseModule');

class query extends baseModule
{
    function getData($param = [])
    {
        $getBySearch = "";
        if (isset($param['search']) && !empty($param['search'])) {
            $getBySearch =
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
                " " . "LIMIT " . $param['limit'] . " ";
        }

        $offset = "";
        if (isset($param['offset']) && !empty($param['offset'])) {
            $offset =
                " " . "OFFSET " . $param['offset'] . " ";
        }

        $select = " " . "members.*, members.idxNum AS action" . " ";
        if (isset($param['select']) && !empty($param['select'])) {
            $select =
                " " . $param['select'] . " ";
        }

        // start of custom
        $getByIdxNum = "";
        if (isset($param["getByIdxNum"]) && !empty($param["getByIdxNum"])) {
            $getByIdxNum = " " . "AND members.idxNum = " . $param["getByIdxNum"] . " ";
        }

        $groupBy = "";
        if (isset($param["groupBy"]) && !empty($param["groupBy"])) {
            $groupBy = " " . "GROUP BY " . $param["groupBy"] . " ";
        }

        $orderBy = "";
        if (isset($param["orderBy"]) && !empty($param["orderBy"])) {
            $orderBy = " " . "ORDER BY " . $param["orderBy"] . " ";
        }
        // end of custom

        $SQL = "
            SELECT
                " . $select . "
            FROM members
            WHERE
                members.idxNum > 0
                " . $getByIdxNum . "
                " . $getBySearch . "
                " . $groupBy . "
                " . $orderBy . "
                " . $limit . "
                " . $offset . "
        ";

        $query = $this->dbH->query($SQL);
        SM_dbErrorCheck($query, $SQL);

        return $query;
    }

    function store($param = [])
    {
        $myForm = $param["myForm"];

        $data = [];
        $data["idxNum"] = $myForm->getVar("idxNum");
        $data["uID"] = $myForm->getVar("uID");
        $data["userName"] = $myForm->getVar("userName");
        $data["passWord"] = $myForm->getVar("passWord");
        $data["emailAddress"] = $myForm->getVar("emailAddress");
        $data["firstName"] = $myForm->getVar("firstName");
        $data["lastName"] = $myForm->getVar("lastName");
        $data["dateCreated"] = $myForm->getVar("dateCreated");

        $SQL = "
            INSERT INTO members
            (idxNum, uID, userName, passWord, emailAddress, firstName, lastName, dateCreated)
            VALUES (
                " . $data['idxNum'] . ",
                '" . $data['uID'] . "',
                '" . $data['userName'] . "',
                '" . $data['passWord'] . "',
                '" . $data['emailAddress'] . "',
                '" . $data['firstName'] . "',
                '" . $data['lastName'] . "',
                '" . $data['dateCreated'] . "'
            )
        ";
        $query = $this->dbH->query($SQL);
        SM_dbErrorCheck($query, $SQL);
    }

    function update($param = [])
    {
        $myForm = $param["myForm"];

        $data = [];
        $data["idxNum"] = $myForm->getVar("idxNum");
        $data["uID"] = $myForm->getVar("uID");
        $data["userName"] = $myForm->getVar("userName");
        $data["passWord"] = $myForm->getVar("passWord");
        $data["emailAddress"] = $myForm->getVar("emailAddress");
        $data["firstName"] = $myForm->getVar("firstName");
        $data["lastName"] = $myForm->getVar("lastName");
        $data["dateCreated"] = $myForm->getVar("dateCreated");

        $SQL = "
            UPDATE members
            SET 
                idxNum = " . $data['idxNum'] . ",
                uID = '" . $data['uID'] . "',
                userName = '" . $data['userName'] . "',
                passWord = '" . $data['passWord'] . "',
                emailAddress = '" . $data['emailAddress'] . "',
                firstName = '" . $data['firstName'] . "',
                lastName = '" . $data['lastName'] . "',
                dateCreated = '" . $data['dateCreated'] . "'
            WHERE idxNum = " . $param["id"] . "
        ";
        $query = $this->dbH->query($SQL);
        SM_dbErrorCheck($query, $SQL);
    }

    function destroy($param = [])
    {
        $SQL = "DELETE FROM members WHERE idxNum = '" . $param["id"] . "'";
        $rh = $this->dbH->query($SQL);
        SM_dbErrorCheck($rh, $SQL);
    }
}
