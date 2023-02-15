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
    }

    function init()
    {
        $param['limit'] = $_GET['length'];
        $param['offset'] = $_GET['start'];
        $param['search'] = $_GET['search']['value'];

        $draw = $_GET['draw'];

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
