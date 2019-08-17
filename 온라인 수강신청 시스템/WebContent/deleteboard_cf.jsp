<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ include file="top.jsp"%>
<%@ include file="dbconfig.jsp"%>
<%
int index = Integer.parseInt(request.getParameter("index"));
String password = request.getParameter("psw");
Statement stmt = null;
String mySQL = null;
stmt = myConn.createStatement();
mySQL = "delete from notice where n_no=" + index + " and n_pw='" + password + "'";
int res = stmt.executeUpdate(mySQL);
if (res != 0) {
%>
<script>
	alert("삭제되었습니다.");
	location.href = "list.jsp";
</script>
<% } else { %>
<script>
	alert("오류");
	location.href = "javascript:history.back()";
</script>
<%
}
stmt.close();
myConn.close();
%>