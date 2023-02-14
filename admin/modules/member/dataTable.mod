<?php
require_once "query.mod";

class dataTable extends SM_module
{
    function init()
    {
        $param['limit'] = $_POST['length'];
        $param['offset'] = $_POST['start'];

        $param['search'] = $_GET['search']['value'];
        $draw = $_GET['draw'];

        $query = new query();
        $data_query = $query->getData($param);
        $data_query_count = $query->getData($param + ["select" => "count(members.idxNum) AS count"]);
        if ($data_query && $data_query_count->fetch()['count'] > 0) {
            $data = $data_query->fetchAll();
        } else {
            $data = false;
        }

        if ($data) {
            $param2['search'] = $param['search'];
            $param2['select'] = 'count(members.idxNum) AS count';

            $data_query2_count = $query->getData($param2);

            $totaldata = count($data);
            $datacount = $data_query2_count->fetch()['count'];
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
