<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
	<title>禀议报告表单</title>
	<link rel="stylesheet" href="<s:url value='/css/form.css' includeParams='none' encode='false' />" type="text/css"/>
	<s:head template="jquery"/>
	<s:head template="messager"/>
	<script type="text/javascript" src="<s:url value='/common/jQuery/jquery.MultiFile.js' includeParams='none' encode='false'/>"></script>
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-禀议驳回修改</s:param>
	</s:include>
	<s:url id="downUrl" action="fileDown_download" includeParams="none" namespace="/"/>
		<s:url id="delFileUrl" action="fileDown_deleteFile" includeParams="none" namespace="/"/>
		<s:form action="ringi_reDraft" namespace="/" theme="simple" method="post" enctype="multipart/form-data">
		<table width="650px;" cellpadding="0" cellspacing="1" class="form">
			<thead>
				<tr>
					<td colspan="4">禀议驳回修改</td>
					<s:hidden name="ringiSho.id" value="%{ringiShoTask.ringiSho.id}"/>
					<s:hidden name="taskId" value="%{ringiShoTask.task.id}"/>
				</tr>
			</thead>
			<tbody>
				<tr>
					<td style="width:90px;">禀议标志</td>
					<td style="padding:0px;width:235px;">
						<table cellpadding="0" cellspacing="1">
							<tr>
								<td><s:select list="#{'1':'汉邦钢构','2':'港盛涂装','3':'建力设备','4':'港盛联合'}" name="ringiSho.title" theme="simple" cssClass="required" onchange="setIcon(this)" value="%{ringiShoTask.ringiSho.title}"/></td>
								<td><img id="img_title" src="<s:property value="imgRootUrl"/>hb.png" style="width:28px;height:28px;"></td>
							</tr>
						</table>
					</td>
					<td style="width:90px;">决裁类别</td>
					<td style="width:235px;"><s:select list="#{'0':'三级决裁','1':'五级决裁'}" name="ringiSho.leType" theme="simple" value="%{ringiShoTask.ringiSho.leType}"/></td>
				</tr>					
				<tr>
					<td style="width:90px;">联系电话</td><td style="width:235px;"><s:textfield name="ringiSho.tel" theme="simple" value="%{ringiShoTask.ringiSho.tel}" cssClass="phone"/></td>
					<td>需求日期</td>
					<td>
						<s:date id="needDate" format="yyyy-MM-dd" name="ringiShoTask.ringiSho.needDate"/>
						<s:textfield name="ringiSho.needDate" theme="simple" onfocus="WdatePicker({minDate:'%y-%M-{%d+1}'})" cssClass="required Wdate dateISO" value="%{needDate}"/>
					</td>
				</tr>				
				<tr>
					<td>禀议主题</td><td colspan="3"><s:textfield name="ringiSho.sub" theme="simple" cssStyle="width:550px;" cssClass="required" maxlength="25" value="%{ringiShoTask.ringiSho.sub}"/></td>
				</tr>
				<tr>
					<td>原因目的</td>
					<td colspan="3">
						<iframe id="causeEditor" src="<s:url value='/common/eWebEditor/ewebeditor.jsp?id=cause&style=mini' includeParams='none'/>" frameborder="0" scrolling="no" width="550" HEIGHT="150"></iframe>
						<s:hidden id="cause" name="ringiSho.cause" value="%{ringiShoTask.ringiSho.cause}"/>
					</td>
				</tr>
				<tr>
					<td>详细内容</td>
					<td colspan="3">
						<s:hidden id="synopsis" name="ringiSho.synopsis" value="%{ringiShoTask.ringiSho.synopsis}"/>
						<iframe id="synopsisEditor" src="<s:url value='/common/eWebEditor/ewebeditor.jsp?id=synopsis&style=coolblue' includeParams='none'/>" frameborder="0" scrolling="no" width="550" HEIGHT="300"></iframe>						
					</td>
				</tr>				
				<tr>
					<td>附　　件</td>
					<td colspan="3">
						<s:iterator value="uploadeds">
							<span id='span_<s:property value="id"/>'>
								<s:a href="%{downUrl}?key=%{id}"><s:property value="name"/></s:a><img style="cursor:pointer" src="<s:property value="imgRootUrl"/>empty.gif" width="16" height="14" onclick="deleteFile(<s:property value="id"/>,'<s:property value="name"/>')"/>
							</span>
						</s:iterator>				
						<s:file name="upload" cssStyle="width:450px;"/>									
					</td>
				</tr>
				<tr>
					<td style="vertical-align:top;padding-top:8px;">指示事项</td>
					<td colspan="3" style="padding:0px;">
						<table style="width:100%;" cellpadding="0" cellspacing="0">
							<s:iterator value="ringiShoTask.ringiSho.ringiShoDetails" status="stat">
								<tr><td><s:property value="#stat.count"/> 、<s:property value="content"/></td></tr>
							</s:iterator>
						</table>
					</td>
				</tr>				
				<tr>
					<td>一级审查</td>
					<td>
						<s:hidden name="ringiSho.flowMan1.id" value="%{ringiShoTask.ringiSho.flowMan1.id}"/>
						<s:textfield name="ringiSho.flowMan1.rName" value="%{ringiShoTask.ringiSho.flowMan1.rName}" theme="simple" cssClass="required UserSel" onclick="selUser('ringiSho.flowMan1.id','ringiSho.flowMan1.rName')"/>
					</td>
					<td>二级决裁</td>
					<td>
						<s:hidden name="ringiSho.flowMan2.id" value="%{ringiShoTask.ringiSho.flowMan2.id}"/>
						<s:textfield name="ringiSho.flowMan2.rName" value="%{ringiShoTask.ringiSho.flowMan2.rName}" theme="simple" cssClass="required UserSel" onclick="selUser('ringiSho.flowMan2.id','ringiSho.flowMan2.rName')"/>
					</td>
				</tr>				
				<tr id="tr_3" style="display:none">
					<td>采购决裁</td>
					<td>
						<s:hidden name="ringiSho.flowManStock.id" value="%{ringiShoTask.ringiSho.flowManStock.id}"/>
						<s:textfield name="ringiSho.flowManStock.rName" value="%{ringiShoTask.ringiSho.flowManStock.rName}" theme="simple" cssClass="required UserSel" onclick="selUser('ringiSho.flowManStock.id','ringiSho.flowManStock.rName')"/>
						<input type="radio" id="flowManStock" name="flowMan3" <s:if test="ringiShoTask.ringiSho.flowManStock.id != null">checked</s:if>>
					</td>
					<td>财务决裁</td>
					<td>
						<s:hidden name="ringiSho.flowManFinance.id" value="%{ringiShoTask.ringiSho.flowManFinance.id}"/>
						<s:textfield name="ringiSho.flowManFinance.rName" value="%{ringiShoTask.ringiSho.flowManFinance.rName}" theme="simple" cssClass="required UserSel" onclick="selUser('ringiSho.flowManFinance.id','ringiSho.flowManFinance.rName')"/>
						<input type="radio" id="flowManFinance" name="flowMan3" <s:if test="ringiShoTask.ringiSho.flowManFinance.id != null">checked</s:if>>
					</td>
				</tr>	
				<tr id="tr_4" style="display:none">
					<td>四级合议</td>
					<td colspan="3">
						<s:hidden name="ringiSho.flowMan4.id" value="%{ringiShoTask.ringiSho.flowMan4.id}"/>
						<s:textfield name="ringiSho.flowMan4.rName" value="%{ringiShoTask.ringiSho.flowMan4.rName}" theme="simple" cssClass="required UserSel" onclick="selUser('ringiSho.flowMan4.id','ringiSho.flowMan4.rName')"/>
					</td>
				</tr>															
			</tbody>
			<tfoot>
				<tr><td colspan="4"><input type="button" value="修改" id="modBtn">&nbsp;&nbsp;<s:reset value="重置" theme="simple"/></td></tr>
			</tfoot>
		</table>
		</s:form>
	<s:include value="/apps/pageFooter.jsp"/>
</body>
<script type="text/javascript">
$(function(){
	
	$("input[name='upload']").MultiFile({ 
		STRING: { 
			remove: '<img src="<s:property value="imgRootUrl"/>empty.gif" style="border:0px;" height="16" width="16" alt="x"/>',
			denied:'你不能选择以 $ext 扩展名结尾的文件.\n请重新选择！',
			duplicate:'这个文件已经存在:\n$file'
		},
		max: 5, 
		accept: 'doc|xls|gif|jpg|png'
	});
	
	$('input.UserSel').each(function(){
		$(this).css('background','#fff url(<s:property value="imgRootUrl"/>users.png) no-repeat right');   
		$(this).css('border','#999 1px solid');
		$(this).css('cursor','pointer');
		$(this).attr('readOnly',true);
	});
	
	$('#flowManStock').click(function(){
		if($(this).attr('checked')){
			$("input[name='ringiSho.flowManStock.id']").attr('disabled',!$(this).attr('checked'));
			$("input[name='ringiSho.flowManStock.rName']").attr('disabled',!$(this).attr('checked'));
			$("input[name='ringiSho.flowManFinance.id']").attr('disabled',$(this).attr('checked'));
			$("input[name='ringiSho.flowManFinance.rName']").attr('disabled',$(this).attr('checked'));			
		}
	});
	
	$('#flowManFinance').click(function(){
		if($(this).attr('checked')){
			$("input[name='ringiSho.flowManFinance.id']").attr('disabled',!$(this).attr('checked'));
			$("input[name='ringiSho.flowManFinance.rName']").attr('disabled',!$(this).attr('checked'));			
			$("input[name='ringiSho.flowManStock.id']").attr('disabled',$(this).attr('checked'));
			$("input[name='ringiSho.flowManStock.rName']").attr('disabled',$(this).attr('checked'));
		}
	});

	//修改禀议书
	$("#modBtn").click(function(){
		if($("#ringi_reDraft").valid()){
			$.messager.prompt('禀议码验证', '请输入禀议码!', function(val){
				if (val){
			 		$.post('<s:url action="ringi_checkCode" includeParams="none" namespace="/"/>', {"ringiShoCode":val} ,function(text){
			 			var obj = eval(text);
			 			if(obj.checked){
			 				$("#ringi_reDraft").submit();
			 			}else{
			 				$.messager.alert('提示信息','禀议码错误!','warning');
			 			}
			 		});						
				}
			});
		} 
	});
	
	$("select[name='ringiSho.leType']").change(function(){
		selLevel($(this).val()); 
	});
	
	//决裁级别选择
	function selLevel(le){
		if(le == 0){
			$('#tr_3').hide();
			$('#tr_4').hide();
			$("input[name='ringiSho.flowManStock.id']").attr('disabled',true);
			$("input[name='ringiSho.flowManStock.rName']").attr('disabled',true);
			$("input[name='ringiSho.flowManFinance.id']").attr('disabled',true);
			$("input[name='ringiSho.flowManFinance.rName']").attr('disabled',true);				
			$("input[name='ringiSho.flowMan4.id']").attr('disabled',true);
			$("input[name='ringiSho.flowMan4.rName']").attr('disabled',true);
			$("input[name='ringiSho.code']").attr('disabled',false);
		}else if(le == 1){
			$('#tr_3').show(); 
			$('#tr_4').show();
			$("input[name='ringiSho.flowManStock.id']").attr('disabled',!$('#flowManStock').attr('checked'));
			$("input[name='ringiSho.flowManStock.rName']").attr('disabled',!$('#flowManStock').attr('checked'));
			$("input[name='ringiSho.flowManFinance.id']").attr('disabled',!$('#flowManFinance').attr('checked'));
			$("input[name='ringiSho.flowManFinance.rName']").attr('disabled',!$('#flowManFinance').attr('checked'));					
			$("input[name='ringiSho.flowMan4.id']").attr('disabled',false);
			$("input[name='ringiSho.flowMan4.rName']").attr('disabled',false);
			$("input[name='ringiSho.code']").attr('disabled',true);	
			<s:if test="ringiShoTask.ringiSho.leType == 0">
				$('#flowManStock').attr('checked',true);
				$("input[name='ringiSho.flowManStock.id']").attr('disabled',false);
				$("input[name='ringiSho.flowManStock.rName']").attr('disabled',false);					
			</s:if>		
		}
	}
	
	selLevel(<s:property value="ringiShoTask.ringiSho.leType"/>);
});

//禀议标志选择
function setIcon(o){
	var img_obj = document.getElementById('img_title');
	var icon = '';
	switch(parseInt(o.value)){
		case 1: icon = 'hb.png';
			break;
		case 2: icon = 'gs.png';
			break;
		case 3: icon = 'jl.png';
			break;
		case 4: icon = 'lh.png';
			break;
	}
	img_obj.src = '<s:property value="imgRootUrl"/>' + icon;
}

//人员选择
function selUser(id,name){
	var idField = document.getElementsByName(id)[0];
	var nameField = document.getElementsByName(name)[0];
	var url = '<s:url action="userSel_depts" includeParams="none" namespace="/"/>';
	
	var rev = window.showModalDialog(url, null, "dialogHeight:320px;dialogWidth:480px;help:0;status:0;scroll:0;resizable:1");
	if (rev) {
		idField.value = rev[0];
		nameField.value = rev[1];
	}
}

function openIt(){
	var width = 480;
	var height = 320;
	var top = (screen.height-height)/2;
	var left = (screen.width-width)/2;
	var url = '<s:url action="userSel_depts" includeParams="none" namespace="/"/>';   
	window.open(url,'newwindow','height=' + height + ',width=' + width + ',top=' + top + ',left=' + left + ',toolbar=no,menubar=no,scrollbars=no,resizable=no,location=no, status=no');
}

function deleteFile(id,name){
	if(window.confirm("确定删除【" + name + "】吗?")){
 		$.post('<s:property value="%{delFileUrl}"/>', {"key":id} ,function(isDel){
 			$("#span_" + id).remove();
 		});	
	}
}
</script>
</html>