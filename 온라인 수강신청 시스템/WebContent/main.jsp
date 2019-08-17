<%@ page contentType="text/html; charset=UTF-8"%>
<html>
<head>
<meta charset="utf-8">
<title>숙명여자대학교 수강신청 시스템 메인화면</title>
</head>
<body class="main">
	<%@ include file="top.jsp"%>
	<div id="containerwrap">
		<div id="container">
			<div class="section_title">
				<h1><span>숙명여자대학교 수강신청 홈페이지</span></h1>
				<h2 align="center">
					<%
					String s;
					if(session_id == null) 
						s = "로그인한 후 사용하세요!";
					else
						s = "환영합니다!";
					%>
					<br> <span><%=s%></span>
				</h2>
			</div>
		</div>

	</div>
	<div align="center">
		<dl>
			<dd><img src="image/NoonSong.png" width="400" height="430" /></dd>
		</dl>
	</div>

</body>
</html>