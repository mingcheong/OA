<%@ page language="java" pageEncoding="GBK"%>
<html>
<head>
<script type="text/javascript">

var URLParams = new Object() ;
var aParams = document.location.search.substr(1).split('&') ;
for (i=0 ; i < aParams.length ; i++) {
	var aParam = aParams[i].split('=') ;
	URLParams[aParam[0]] = aParam[1] ;
}

var sLinkFieldName = URLParams["id"] ;
var sExtCSS = URLParams["extcss"] ;
var sFullScreen = URLParams["fullscreen"];

var config = new Object() ;
config.StyleName = (URLParams["style"]) ? URLParams["style"].toLowerCase() : "coolblue";
config.CusDir = URLParams["cusdir"];
config.ServerExt = "jsp";

document.write ("<script type='text/javascript' src='style/"+config.StyleName+".js'><\/script>");
document.write ("<script type='text/javascript' src='js/lang.js'><\/script>");
document.write ("<script type='text/javascript' src='js/main.js'><\/script>");

</script>