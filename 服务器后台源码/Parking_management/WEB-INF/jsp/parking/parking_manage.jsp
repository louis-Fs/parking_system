<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>停好你的车-管理平台</title>
    <link rel="stylesheet" type="text/css" href="../easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="../easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="../easyui/themes/color.css">
	<link rel="stylesheet" type="text/css" href="../easyui/themes/xyy.css">
    <script type="text/javascript" src="../easyui/jquery.min.js"></script>
    <script type="text/javascript" src="../easyui/easyloader.js"></script>
    <script type="text/javascript" src="../easyui/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="../easyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript">
		var url;
		function newUser(){
			$('#dlg').dialog('open').dialog('setTitle','新增用户');
			$('#fm').form('clear');
			url = 'save.action';
		}
		
		function editUser(){
			var row = $('#dg').datagrid('getSelections');
			if (row.length==1){
				$('#dlg').dialog('open').dialog('setTitle','编辑用户');
				$('#fm').form('load',row[0]);
				url = 'edit.action';
			}else if(row.length>1){
				$.messager.alert('提示','每次只能编辑一条数据，请重新选择!');
			}else{
				$.messager.alert('提示','请选择要编辑的数据!');
			}
		}
		function saveUser(){
			$('#fm').form('submit',{
				url: url,
				onSubmit: function(){
					return $(this).form('validate');
				},
				success: function(result){
					var result = eval('('+result+')');
					if (result.status == 200){
						$.messager.alert('提示','保存成功!');
						$('#dlg').dialog('close');		// close the dialog
						$('#dg').datagrid('reload');	// reload the user data
					} else {
						$.messager.show({
							title: 'Error',
							msg: result.msg
						});
					}
				}
			});
		}
		function removeUser(){
			var row = $('#dg').datagrid('getSelections');
			console.log(row);
			if (row){
				$.messager.confirm('提示','确定要删除这条数据吗?',function(r){
					if (r){
						  
						var parmIds = "";
	                    $.each(row, function (i, rows) {
	                        parmIds += rows.id + ",";
	                    });
	                    parmIds = parmIds.substring(0, parmIds.length - 1);
						$.post('delete.action',{id:parmIds},function(result){
							if (result.status == 200){
								$.messager.alert('提示','删除成功!');
								$("#dg").datagrid("clearSelections");
								$('#dg').datagrid('reload');	// reload the user data
							} else {
								$.messager.show({	// show error message
									title: 'Error',
									msg: result.msg
								});
							}
						},'json');
					}
				});
			}else{
				$.messager.alert('提示','请选择要删除的数据!');
			}
		}
		
		 function doSearch(value){
			 $('#dg').datagrid('load',{
				 manageStaId: value,
				});
			    }
	</script>
</head>
<body class="easyui-layout" style="margin:0 1px;background-color:#f5f5f5 !important;">  
    <div data-options="region:'center'" style="background:#fff;border:0;">
	    <div id="tb" class="easyui-tabs" data-options="tools:'#tab-tools',fit:true">
			<div  >
		        <div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'center',border:false">
						<div data-options="region:'center',border:false" style="margin-top:20px;">
                            <table id="dg" title="用户列表" iconCls="icon-dingdan" class="easyui-datagrid" style="width:100%;height:400px;"
								data-options="idField:'id',rownumbers:false,fitColumns:true,pagination:true,singleSelect:true,collapsible:true,toolbar:'#toolbar',url:'list.action',method:'get',checkOnSelect:'true',selectOnCheck:'true'">
							<!---获取数据--->
							<thead>
								<tr>
									<th field="ck" checkbox="true"></th>
									<th data-options="field:'id',width:80">编号</th>
									<th data-options="field:'manageStaId',width:100">车位号</th>
									<th data-options="field:'manageArea',width:100">区域</th>
									<th data-options="field:'managePs',width:100">备注</th>
								</tr>
							</thead>
							<tbody>
							</tbody>
							</table>
							<div id="toolbar">
								<a href="#" class="easyui-linkbutton" iconCls="icon-add" plain="true" onclick="newUser()">新 增</a>
								<a href="#" class="easyui-linkbutton" iconCls="icon-edit" plain="true" onclick="editUser()">编 辑</a>
								<a href="#" class="easyui-linkbutton" iconCls="icon-remove" plain="true" onclick="removeUser()">移 除</a>
								<a href="#" class="easyui-linkbutton" plain="true">
								</a>
								<input id="ss" class="easyui-searchbox" style="width:300px"
							    data-options="searcher:doSearch,prompt:'请输入要搜索的车位'"></input>
							</div>
							<div id="dlg" class="easyui-dialog" style="width:400px;height:280px;padding:10px 20px" closed="true" buttons="#dlg-buttons">
								<div class="ftitle">用户信息</div>
								<form id="fm" method="post" novalidate>
								<div class="fitem">
										<label>编 &nbsp&nbsp号: 编号自动生成</label>
										<input name="id" type="hidden">
									</div>
									<div class="fitem">
										<label>车位号:</label>
										<input name="manageStaId" class="easyui-validatebox" required="true">
									</div>
									<div class="fitem">
										<label>区 &nbsp&nbsp域:</label>
										<input name="manageArea" class="easyui-validatebox"  required="true">
									</div>
									<div class="fitem">
										<label>备 &nbsp&nbsp注:</label>
										<input name="managePs" class="easyui-validatebox" required="true">
										
									</div>
									
								</form>
							</div>
							<div id="dlg-buttons">
								<a href="#" class="easyui-linkbutton" iconCls="icon-ok" onclick="saveUser()">保存</a>
								<a href="#" class="easyui-linkbutton" iconCls="icon-cancel" onclick="javascript:$('#dlg').dialog('close')">关闭</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	
	</div>  
<script type="text/javascript">
function addTab(title, url){
	if ($('#tb').tabs('exists', title)){
		$('#tb').tabs('select', title);
	} else {
		var content = '<iframe scrolling="auto" frameborder="0"  src="'+url+'" style="width:100%;height:100%;"></iframe>';
		$('#tb').tabs('add',{
			title:title,
			content:content,
			closable:true
		});
	}
}

//表格分页	
var pager = $('#dg').datagrid('getPager');    // get the pager of datagrid
	pager.pagination({
		showPageList:false,
		buttons:[{
			iconCls:'icon-search',
			handler:function(){
				alert('search');
			}
		},{
			iconCls:'icon-add',
			handler:function(){
				alert('add');
			}
		},{
			iconCls:'icon-edit',
			handler:function(){
				alert('edit');
			}
		}],
		onBeforeRefresh:function(){
			alert('before refresh');
			return true;
		}
	});		
</script>
</body>
</html>
