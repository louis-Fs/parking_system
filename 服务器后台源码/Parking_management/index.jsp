<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta charset="UTF-8">
    <title>停好你的车-管理平台</title>
    <link rel="stylesheet" type="text/css" href="easyui/themes/default/easyui.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/icon.css">
    <link rel="stylesheet" type="text/css" href="easyui/themes/color.css">
	<link rel="stylesheet" type="text/css" href="easyui/themes/xyy.css">
    <script type="text/javascript" src="easyui/jquery.min.js"></script>
    <script type="text/javascript" src="easyui/easyloader.js"></script>
    <script type="text/javascript" src="easyui/jquery.easyui.min.js"></script>
        <script type="text/javascript" src="easyui/locale/easyui-lang-zh_CN.js"></script>
		<script type="text/javascript">
		var url;
		function newUser(){
			$('#dlg').dialog('open').dialog('setTitle','新增用户');
			$('#fm').form('clear');
			url = 'save_user.php';
		}
		function editUser(){
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$('#dlg').dialog('open').dialog('setTitle','编辑用户');
				$('#fm').form('load',row);
				url = 'update_user.php?id='+row.id;
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
					if (result.success){
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
			var row = $('#dg').datagrid('getSelected');
			if (row){
				$.messager.confirm('Confirm','Are you sure you want to remove this user?',function(r){
					if (r){
						$.post('remove_user.php',{id:row.id},function(result){
							if (result.success){
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
			}
		}
	</script>
</head>
<body class="easyui-layout" style="margin:0 1px;background-color:#f5f5f5 !important;">  
    <div data-options="region:'north',split:true" style="height:80px;" id="xyy_header">
	    <div class="easyui-layout" data-options="fit:true">   
            <div style="float:left;width:40%;padding:18px 0 0 15px;">
			    <img src="img/logo.png">
				<a href="#" style="font-size:16px;color:#fff;text-decoration:none;">管理平台</a>
			</div>
            <div style="float:right;width:56%;">
				<div class="xyy_tool">	
					<ul style="float:right;position: relative;right:0;margin:0;">			
						<li><a href="login.jsp"><i class="xyy-tuichu" style="position: absolute;display:block;width: 16px;height: 16px;top: 50%;margin: -8px 12px;"></i>退出登录</a></li>
					</ul>
				</div>				
			</div>			
        </div>
	</div>  
    <div data-options="region:'south',split:true" style="height:40px;text-align:center;line-height:30px;background:red;color:#f5f5f5;">xxxx提供技术服务 新ICP 99999999</div>   
    <div data-options="region:'west',title:'平台管理主菜单',split:true" style="width:200px;">
	    <div id="menu" class="easyui-accordion" fit="true" border="false">
            <div title="系统设置" data-options="iconCls:'icon-shezhi',selected:true" style="overflow:auto;padding:10px;">
                <ul id="tt" class="easyui-tree" data-options="animate:true,lines:true">  
                    <li>  
                        <span>管理员管理</span>  
                        <ul>                             
                            <li>  
								<span><a href="#" onclick="addTab('用户列表','admin/tolist.action')">用户列表</a></span>  
                            </li>  
                            <li>  
								<span><a href="#" onclick="addTab('停车用户','owner/tolist.action')">停车用户</a></span>  
                            </li>  
                             <li>  
                                <span><a href="#" onclick="addTab('车位管理','manage/tolist.action')">车位管理</a></span>  
                            </li>  
                             <li>  
                                <span><a href="#" onclick="addTab('停车缴费','payment/tolist.action')">停车缴费</a></span>  
                            </li> 
                            <li>  
								<span><a href="#" onclick="addTab('停车记录查询','record/tolist.action')">停车记录查询</a></span>  
                            </li>                                                            
                        </ul>  
                    </li>  
                </ul>
            </div>
        </div>
	
	</div>  
    <div data-options="region:'center'" style="background:#fff;border:0;">
	    <div id="tb" class="easyui-tabs" data-options="tools:'#tab-tools',fit:true">
			<div title="我的主页" iconCls="icon-home" style="padding:15px;">
		        <div class="easyui-layout" data-options="fit:true">
					<div data-options="region:'north',border:false" style="height:130px;border-bottom:1px #a7b1c2 dashed;padding:5px;">
						<div class="easyui-layout" data-options="fit:true">
							<div data-options="region:'west',border:false" style="width:350px;height:150px;border-right:1px #a7b1c2 dashed;padding:5px;color:#2f4050;">
								<h1 style="margin:0 0 10px 0;">欢迎使用停好你的车！</h1>
								<ul style="list-style-type:none;padding:0;">
									<li style="margin-bottom:10px;">
										<a href="#" style="text-decoration:none;font-size:16px;color:#2f4050;"><i class="xyy-hello" style="display:block;width: 16px;height:16px;float:left;margin:2px 3px;"></i>您好,<span id="name" class="tag" style="color:red;">${user.username}</span>!</a>
									</li>	
									<li style="margin-bottom:10px;"><a href="#" style="text-decoration:none;font-size:16px;color:#2f4050;"><i class="xyy-time" style="display:block;width: 16px;height:16px;float:left;margin:2px 3px;"></i>现在是：<span id="timer" style="color:red;font:16px tahoma;height:17px;"><script>setInterval("timeStr=new Date().toLocaleString();timer.innerText=timeStr;",1000)</script></span></a>
                                    </li>	
								</ul>																
							</div>
								
						</div>
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
//关闭所有的tab  
    function closeAll(){  
        var tiles = new Array();  
          var tabs = $('#tb').tabs('tabs');      
          var len =  tabs.length;           
          if(len>0){  
            for(var j=0;j<len;j++){  
                var a = tabs[j].panel('options').title;               
                tiles.push(a);  
            }  
            for(var i=1;i<tiles.length;i++){               
                $('#tb').tabs('close', tiles[i]);  
            }  
          }  
    } 
//关闭当前的tab 
	function removePanel(){
		var tab = $('#tb').tabs('getSelected');
		    if (tab){
			var index = $('#tb').tabs('getTabIndex', tab);
			$('#tb').tabs('close', index);
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
