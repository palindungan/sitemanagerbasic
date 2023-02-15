<?php
require_once "../admin/modules/baseModule.mod";
require_once "query.mod";

global $SM_siteManager;
$SM_siteManager->includeModule('baseModule');

class dataTable extends baseModule
{
    public $query;

    function __construct()
    {
        parent::__construct();
        $this->query = new query();

        $this->addInVar('length', '');
        $this->addInVar('start', '');
        $this->addInVar('search', '');
        $this->addInVar('columns', '');
        $this->addInVar('order', '');
        $this->addInVar('draw', '');
    }

    function init()
    {
        // die(json_encode($this->getInVarValues()));

        $param['limit'] = $this->getVar('length');
        $param['offset'] = $this->getVar('start');
        $param['search'] = $this->getVar('search')['value'];
        $draw = $this->getVar('draw');

        $request_columns = $this->getVar('columns');
        $request_order = $this->getVar('order');
        /*
            [
                [
                   column: "0",
                   dir: "desc",
                ],
                [
                    column: "1",
                    dir: "asc",    
                ],
            ]
        */
        $order = [];
        foreach ($request_order as $key => $value) {
            $order[$key] = " " . $request_columns[$value['column']]['name'] . " " . $value['dir'] . " ";
        }
        $orderBy = " ORDER BY " . implode(",", $order) . " ";

        $dataQuery = $this->query->getData($param);
        $data = $dataQuery->fetchAll();
        $dataCount = count($data);
        if ($dataCount == 0) {
            $data = false;
        }

        if ($dataCount > 0) {
            $param2['search'] = $param['search'];
            $param2['select'] = 'COUNT(members.idxNum) AS dataCount';

            $dataQuery2Count = $this->query->getData($param2);

            $recordsTotal = $dataCount;
            $recordsFiltered = $dataQuery2Count->fetch()['dataCount'];
        } else {
            $recordsTotal = 0;
            $recordsFiltered = 0;
        }

        $result = array(
            'draw' => intval($draw),
            'recordsTotal' => intval($recordsTotal),
            'recordsFiltered' => intval($recordsFiltered),
            'data' => $data,
        );

        return $result;
    }
}
