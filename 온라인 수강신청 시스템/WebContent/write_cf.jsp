<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.Date" %>
<% request.setCharacterEncoding("utf-8"); // 한글 처리 구문 %>
<%@ include file="dbconfig.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
<%
Statement stmt = null;
String name = request.getParameter("name"); //write.jsp에서 name에 입력한 데이터값
String password = request.getParameter("psw");//write.jsp에서 password에 입력한 데이터값
String title = request.getParameter("title"); //write.jsp에서 title에 입력한 데이터값
String content = request.getParameter("content"); //write.jsp에서 content에 입력한 데이터값
Date time = new Date();
int max = 0;
stmt = myConn.createStatement();
String sql = "SELECT MAX(n_no) FROM notice";
ResultSet rs = stmt.executeQuery(sql);
if (rs.next()) {
max = rs.getInt(1);
}
sql = "INSERT INTO notice(n_no,n_name,n_pw,n_title,n_cont) VALUES(n_no.NEXTVAL, ?,?,?,?)";
PreparedStatement pstmt = myConn.prepareStatement(sql);
pstmt.setString(1, name);
pstmt.setString(2, password);
pstmt.setString(3, title);
pstmt.setString(4, content);
pstmt.execute();
pstmt.close();
stmt.close();
myConn.close();
%>
<script language=javascript>
self.window.alert("입력한 글을 저장하였습니다.");
location.href = "list.jsp";
</script>
</head>
<body>
</body>
</html>