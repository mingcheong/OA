<%@ page language="java" pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<%@taglib prefix="ec" uri="/WEB-INF/ecside.tld"%>
<html>
<head>
	<title>禀议报告表单</title>
	<s:head template="ecside"/>
	<link rel="stylesheet" href="<s:url value='/css/list.css' includeParams='none' encode='false' />" type="text/css"/>
</head>
<body>
	<s:include value="/apps/pageHeader.jsp">
		<s:param name="fb_title">系统管理-禀议资料库列表</s:param>
	</s:include>
	<s:url id="detailsUrl" action="ringi_details" includeParams="none" namespace="/"/>
		<ec:table items="page.result" var="ringi" doPreload="false" action="./ringiMe_list.action" sortable="true" width="100%" listWidth="100%" resizeColWidth="true">
			<ec:row>
				<ec:column property="code" title="编号" width="12%" style="text-align:center"/>
				<ec:column property="title" width="10%" title="归属" style="text-align:center">
					<s:if test="%{#attr.ringi.title == 1}">汉邦钢构</s:if>
					<s:elseif test="%{#attr.ringi.title == 2}">港盛涂装</s:elseif>					
					<s:elseif test="%{#attr.ringi.title == 3}">建力设备</s:elseif>					
					<s:elseif test="%{#attr.ringi.title == 4}">港盛联合</s:elseif>					
				</ec:column>
				<ec:column property="sub" title="禀议主题" ellipsis="true"/>
				<ec:column property="user.RName" width="15%" title="作成者" style="text-align:center" sortable="false"/> 
				<ec:column property="date" width="15%" title="作成日期" cell="date" style="text-align:center"/> 
				<ec:column property="needDate" width="15%" title="需求日期" cell="date" style="text-align:center"/>
				<ec:column property="id" title="操作" width="10%" style="text-align:center">
					<img src="<s:property value="imgRootUrl"/>clipboard_text.png" width="16" height="16" />&nbsp;<s:a href="javascript:showDetail(%{#attr.ringi.id})">详细</s:a>
				</ec:column>				
			</ec:row>
		</ec:table>

	<s:include value="/apps/pageFooter.jsp"/>
</body>
<script type="text/javascript">
function showDetail(key){
	var width = 800;
	var height = 600;
	var top = (screen.height-height)/2;
	var left = (screen.width-width)/2;
	var url = '<s:property value="detailsUrl"/>?key=' + key;   
	window.open(url,'ringiDetail','height=' + height + ',width=' + width + ',top=' + top + ',left=' + left + ',toolbar=no,menubar=no,scrollbars=yes,resizable=yes,location=no,status=yes');
}
</script>
</html>