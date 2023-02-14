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

        $data_query = $this->query->getData($param);
        $data = $data_query->fetchAll();
        if (count($data) == 0) {
            $data = false;
        }

        if ($data) {
            $param2['search'] = $param['search'];
            $param2['select'] = 'COUNT(members.idxNum) AS countData';

            $data_query2_count = $this->query->getData($param2);

            $totaldata = count($data);
            $datacount = $data_query2_count->fetch()['countData'];
        } else {
            $totaldata = 0;
            $datacount = 0;
        }

        $result = array(
            'draw' => intval($draw),
            'recordsTotal' => $totaldata,
            'recordsFiltered' => $datacount,
            'data' => $data,
        );

        return $result;
    }
}
