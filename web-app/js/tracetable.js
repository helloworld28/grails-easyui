/**
 * Created by Administrator on 2017-02-06.
 */

function append(){
    //打开添加发货单的窗口
    $('#winDelivery').window('open');
}
function removeit(){
    if(window.confirm("确认要删除该发货单？")){
        var row = $('#dg-delivery').datagrid('getSelected');
        if(row == ''){
            $.messager.alert('提示', "请先选择一行记录");
        }else{
            var deliveryId = row['id'];
            var url = '<g:createLink controller="delivery" action="delete"/>/'+deliveryId;
            $.post(url,{}, function (result) {
                $('#dg-delivery').datagrid('reload');
            })
        }
    }
}

function addDeliveryAmount(deliveryAmount) {

    var currentAmount = $('#deliveryedAmount', '#frm-edit').numberbox('getValue');
    $('#deliveryedAmount', '#frm-edit').numberbox('setValue',currentAmount + deliveryAmount);
    currentAmount = $('#notDevliveryedAmout', '#frm-edit').numberbox('getValue');
    $('#notDevliveryedAmout', '#frm-edit').numberbox('setValue',currentAmount - deliveryAmount);
}


$('#btn-save-delivery').click(
    function(){
        var rows  = $('#grid').datagrid('getChecked');


        if(rows != '' && rows.length == 1){

            var traceTableId = rows[0].id;
            var deliveryAmount = $('#deliverAmount').val();
            $('#traceTableId').val(traceTableId);
            $.ajax({
                url:'<g:createLink controller="delivery" action="createDevlivery"/>',
                data:$('#frmDelivery').serialize(),
                dataType:'JSON',
                type:'POST',
                success:function (data) {

                    if(data == '1'){
                        //$('#frmDelivery').form.reset()
                        $.messager.alert('提示','保存成功');
                        $('#grid').datagrid('reload');
                        $('#winDelivery').window('close');
                        $('#dg-delivery').datagrid('reload');
                        addDeliveryAmount(deliveryAmount);

                    }else{
                        alert('保存失败');
                    }
                }
            });
        }
    }

);