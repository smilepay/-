<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<html>
<head>
<title>수정</title>
</head>
<body>
	<%@ include file="dbconfig.jsp"%>
	<%
String password = "";
Statement stmt = null;
int index = Integer.parseInt(request.getParameter("index"));
String title = request.getParameter("title");
String content = request.getParameter("content");
String psw = request.getParameter("psw");
stmt = myConn.createStatement();
String sql = "SELECT n_pw FROM notice WHERE n_no="+index+"";
ResultSet rs = stmt.executeQuery(sql);
if(rs.next()) {
password = rs.getString(1);
}
if(password.equals(psw)) {
   sql = "UPDATE notice SET n_title='" + title+ "' ,n_cont='"+ content +"' WHERE n_no=" + index;
stmt.executeUpdate(sql);
%>
	<script language=javascript>
		self.window.alert("글이 수정되었습니다.");
		location.href="view.jsp?index=<%=index%>";
		</script>
	<%
rs.close();
stmt.close();
myConn.close();
} else {
%>
	<script language=javascript>
		self.window.alert("비밀번호를 틀렸습니다.");
		location.href = "javascript:history.back()";
	</script>
	<%
}
%>