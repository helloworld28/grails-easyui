<div class="easyui-dialog" id="win-traceTable" title="明细信息" width="700px" style="width:900px;height:500px;padding:5px"
     closed="true"
     maximizable="true" minimizable="true" collapsible="false" modal="true"
     data-options="">
    <div id="traceTableGrid"></div>

</div>
<script>
    $(document).ready(function () {
        $('#traceTableGrid').datagrid({
            columns: [[
                {field: 'spare_number', title: '易损件型号', width: 180},
                {field: 'company_name', title: '公司', width: 220},
                {field: 'contractNo', title: '合同号', width: 110},
                {field: 'spare_category', title: '品类', width: 50},
                {field: 'spare_zljxh', title: '制粒机型号', width: 100},
                {field: 'spare_material', title: '材质', width: 80},
                {field: 'spare_radius', title: '孔径', width: 50},
                {field: 'spareNumber', title: '生产编号', width: 100},
                {field: 'orderDate', title: '下单时间', width: 100},
                {field: 'orderAmount', title: '订单数量', width: 100, align: 'right'},
                {field: 'orderPrice', title: '报价', width: 100, align: 'right'},
                {field: 'deliveryedAmount', title: '已发数量', width: 100, align: 'right'}
            ]],
            pagination: true,
            autoRowHeight: true,
            fitColumns: true,
            fit: true
        });
    });
    function showDetails(companyName) {
        var url = '<g:createLink controller="traceTable" action="list.json"/>' + '?field=company&value=' + companyName;
//        var startTime = $('input[name=startTime]').val();
//        var endTime = $('input[name=endTime]').val();
//        if (startTime) {
//            url = url + '&startTime=' + startTime;
//        }
//        if (endTime) {
//            url = url + '&endTime=' + endTime;
//        }
        openDetailDialog(url)
    }
    function showDetailsByCompanyIdAndSpareNumber(companyId, spareNumber) {
        var url = '<g:createLink controller="traceTable" action="list.json"/>' + '?field=spare&value=' + spareNumber + '&companyId=' + companyId;
        openDetailDialog(url)
    }
    function showDetailsByCompanyIdAndSpareId(companyId, spareId) {
        var url = '<g:createLink controller="traceTable" action="list.json"/>' + '?spareId=' + spareId + '&companyId=' + companyId;
        openDetailDialog(url);
    }

    function openDetailDialog(url) {
        var startTime = $('input[name=startTime]').val();
        var endTime = $('input[name=endTime]').val();
        if (startTime) {
            url = url + '&startTime=' + startTime;
        }
        if (endTime) {
            url = url + '&endTime=' + endTime;
        }
        $('#traceTableGrid').datagrid({url: url});
        $('#win-traceTable').dialog('open');
    }
</script>