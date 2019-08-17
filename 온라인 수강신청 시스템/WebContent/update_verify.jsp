<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"%>
<%@ include file="dbconfig.jsp"%>
<%
String mySQL = null;
Statement stmt = null;
ResultSet myResultSet = null;
String updateID=request.getParameter("id");
String myMode=request.getParameter("mode");
String updatePW=request.getParameter("updatePW");
String updatePW_conf=request.getParameter("updatePW_conf");
String updateAddr=request.getParameter("updateAddr");
String errorMessage=null;

if (updatePW.equals(updatePW_conf)) {
	try{
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
		if(myMode.equals("true")){
			mySQL = "update students set s_pw='" + updatePW + "' , s_email='" + updateAddr + "' where s_id='" + updateID +"'";
		}
		else {
			mySQL = "update professor set p_pw='" + updatePW + "' , p_email='" + updateAddr + "' where p_id='" + updateID + "'";
		}
		stmt.executeUpdate(mySQL);
	}catch(SQLException e){
		if (e.getErrorCode() == 20001)
			errorMessage = "이전과 같은 비밀번호를 설정할 수 없습니다.";
		else if (e.getErrorCode() == 20002)
			errorMessage = "비밀번호는 4자리 이상이어야 합니다.";
		else if (e.getErrorCode() == 20003)
			errorMessage = "비밀번호에 공란이 포함될 수 없습니다.";
		else {
			errorMessage = "update 에러 발생";
			e.printStackTrace();
		}
		%>
		<script>
			alert("<%=errorMessage%>");
			location.href="update.jsp";
		</script>
		<%
	}
	finally {
		if (errorMessage == null){
		%>
		<script>
			alert("update가 성공적으로 완료되었습니다!");
			location.href="main.jsp";
		</script>
		<%
		}
		stmt.close();
		myConn.close();
	}
}
else {
%>
	<script>
		alert("비밀번호를 다시 확인해주세요.");
		location.href="update.jsp";
	</script>
<%	
}
%>