<?php
require_once "query.mod";

class dataTable extends SM_module
{
    public $query;

    function __construct()
    {
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

            $totalData = $dataCount;
            $dataCount = $dataQuery2Count->fetch()['dataCount'];
        } else {
            $totalData = 0;
            $dataCount = 0;
        }

        $result = array(
            'draw' => intval($draw),
            'recordsTotal' => $totalData,
            'recordsFiltered' => $dataCount,
            'data' => $data,
        );

        return $result;
    }
}
