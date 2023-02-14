<?php

class query extends SM_module
{
    function getData($param = [])
    {
        $get_by_search = "";
        if (isset($param['search']) && !is_null($param['search'])) {
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
        if (isset($param['limit']) && !is_null($param['limit'])) {
            $limit =
                " " . "AND LIMIT " . $param['limit'] . " ";
        }

        $offset = "";
        if (isset($param['offset']) && !is_null($param['offset'])) {
            $offset =
                " " . "AND OFFSET " . $param['offset'] . " ";
        }

        $select = " " . "members.*, members.idxNum AS action" . " ";
        if (isset($param['select']) && !is_null($param['select'])) {
            $select =
                " " . $param['select'] . " ";
        }

        // start of custom
        $get_by_idxNum = "";
        if (isset($param["get_by_idxNum"]) && !is_null($param["get_by_idxNum"])) {
            $get_by_idxNum = " " . "AND members.idxNum = " . $param["get_by_idxNum"] . " ";
        }
        // end of custom

        $SQL = "
            SELECT
                " . $select . "
            FROM members
            WHERE
                members.idxNum > 0
                " . $get_by_search . "
                " . $limit . "
                " . $offset . "
                " . $get_by_idxNum . "
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
