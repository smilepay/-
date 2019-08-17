<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="dbconfig.jsp"%>
<%@page import="java.sql.*"%>
<%
String sSQL = null;
String pSQL = null;
Statement stmt = null;
ResultSet myResultSet = null;
String userID=request.getParameter("userID");
String userPassword=request.getParameter("userPassword");
String mode=request.getParameter("mode");
try{
Class.forName(dbdriver);
myConn=DriverManager.getConnection(dburl, user, passwd);
stmt = myConn.createStatement();
sSQL="select s_id from students where s_id ='" + userID + "' and s_pw='" + userPassword + "'";
pSQL="select p_id from professor where p_id ='" + userID + "' and p_pw='" + userPassword + "'";
if (mode.equals("student"))
	myResultSet = stmt.executeQuery(sSQL);
else
	myResultSet = stmt.executeQuery(pSQL);
}catch (ClassNotFoundException e){
	System.out.println("jdbc 로딩 실패");
}catch (SQLException e) {
	System.out.println("오라클 연결 실패");
}finally {
if (myResultSet.next()) {
	session.setAttribute("user", userID);
	if (mode.equals("student"))
		session.setAttribute("mode", "학생");
	%>
	<script>location.href="main.jsp"</script>
	<%
}
else {
	%>
	<script>
		alert("잘못된 아이디/패스워드 입니다.");
		location.href="login.jsp";
	</script>
	<%
}
stmt.close();
myConn.close();
}
%>