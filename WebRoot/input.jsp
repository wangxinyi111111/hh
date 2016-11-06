<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%
	String path = request.getContextPath();
	String basePath = request.getScheme() + "://"
			+ request.getServerName() + ":" + request.getServerPort()
			+ path + "/";
%>
<html>
<head>
<base href="<%=basePath%>">
<title>AJAX Demo</title>
<script type="text/javascript">
	window.onload = function() {
		document.getElementById("sendBut").addEventListener("click",sendEcho,false) ;
	}
	// 声明的时候根本什么意义都不能表述，因为不知道它的类型
	var xmlHttpRequest ;	// 定义一个AJAX的核心处理对象
	// 一般都会单独定义一个操作函数，这个函数的主要功能是进行xmlHttpRequest对象的实例化
	function createXmlHttpRequest() {
		if (window.XMLHttpRequest) {	// 表示此时的浏览器是非IE浏览器
			xmlHttpRequest = new XMLHttpRequest() ;	// 直接进行对象实例化
		} else {	// 如果现在是IE浏览器
			xmlHttpRequest = new ActiveXObject("Microsoft.XMLHttp") ;
		}
	}
	function sendEcho() {
		// 取出输入的数据内容
		var info = document.getElementById("info").value ;
		if (info != "") {	// 现在有输入数据
			createXmlHttpRequest() ;	// 调用创建xmlHttpRequest对象的函数
			// 设置要提交数据的路径以及定义数据的提交模式，而后使用地址重写的方式传递数据
			xmlHttpRequest.open("post","EchoServlet?msg=" + info) ;
			xmlHttpRequest.onreadystatechange = sendEchoCallback ;
			xmlHttpRequest.send(null) ;
		}
		// 当信息处理完成之后原本的数据应该清空
		document.getElementById("info").value = "" ;
		
	}
	
	function sendEchoCallback() {	// AJAX异步处理的回调函数
		if (xmlHttpRequest.status == 200) {	// 服务器端处理正常
			if (xmlHttpRequest.readyState == 2 || xmlHttpRequest.readyState == 3) {
				alert("请稍后，正在为您进行数据处理！") ;
			} 
			if (xmlHttpRequest.readyState == 4) {	// 现在数据已经处理完成了，可以进行页面处理了
				var data = xmlHttpRequest.responseText ;	// 接收数据
				// 所有的回应数据都应该保存在“echoDiv”元素之中
				var divElement = document.createElement("div") ;
				divElement.appendChild(document.createTextNode(data)) ;
				document.getElementById("echoDiv").appendChild(divElement) ;
			}
		}
	}
</script>
</head>
<body>
	<div id="inputDiv">
		<input type="text" name="info" id="info">
		<input type="button" id="sendBut" value="发送信息">
	</div>
	<div id="echoDiv"></div> 
</body>
</html>