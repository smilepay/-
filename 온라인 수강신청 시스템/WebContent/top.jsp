<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>

<% String session_id = (String) session.getAttribute("user");
   boolean stu_mode = true;
String log;
String menu = "수강신청";
String session_mode = (String) session.getAttribute("mode");
if (session_id == null)
	log = "<a href=login.jsp>로그인</a>";
else 
	log = "<a href=logout.jsp>로그아웃</a>"; 
if (session_mode == null)
	stu_mode = false;
if (stu_mode) {
	menu = "수강신청";
}
else {
	menu = "수업과목";
}
%>

<!doctype html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta name="viewport"
	content="initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, width=device-width, user-scalable=no" />
<meta name="newat-detection"
	content="telephone=no, address=no, email=no" />
<meta name="newat-detection" content="no" />
<link rel="stylesheet" href="css/style.css">

<style>
#headwrap {
	background-color: #7ED2FF;
}
</style>
</head>
<body class="member">
	<div id="wrapper">
		<div id="headwrap">
			<header id="header">
				<div class="util">
					<ul class="menu">					
						<%
							if (session_id == null) {
						%>
												
						<li style="float: right"><a href="login.jsp"style="color: white;">로그인</a></li>
						<li style="float: right"><a href="list.jsp"style="color: white;">공지사항</a></li>
						<li style="float: right"><a href="main.jsp" style="color: white;">홈</a><li>
						<%
							} else {
						%>				
										
						<li style="float: right"><a href="logout.jsp"style="color: white;">로그아웃</a></li>
						<li style="float: right"><a href="list.jsp"style="color: white;">공지사항</a></li>
						<li style="float: right"><a href="main.jsp" style="color: white;">홈</a><li>	
						<%
							}
						%>
					</ul>
				</div>
				<div class="header_top"></div>
				<nav id="gnb">
					<ul class="depth1menu">					
						<li class="gnb01 "><a href="update.jsp" style="color: white;">사용자 정보 수정</a></li>
						<li class="gnb02 "><a href="insert.jsp" style="color: white;"><%=menu%> 입력</a></li>
						<li class="gnb03 "><a href="delete.jsp" style="color: white;"><%=menu%> 삭제</a></li>
						<li class="gnb04 "><a href="select.jsp" style="color: white;"><%=menu%> 조회</a></li>
						<li class="gnb05 "><a href="timetable.jsp" style="color: white;">강의 시간표</a></li>
					</ul>
				</nav>
			</header>
		</div>
	</div>