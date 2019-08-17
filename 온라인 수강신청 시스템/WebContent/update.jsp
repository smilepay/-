<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="dbconfig.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 사용자 정보 수정</title>
</head>
<body>
<%@ include file="top.jsp" %>
<pre><% out.println(); %></pre>
<%	
	String mySQL = null;
	Statement stmt = null;
	ResultSet myResultSet = null;
	String userAddr = "";
	String userPassword= "";
	if (session_id == null) {
%>		<script>
			alert("로그인이 필요합니다.");
			location.href="login.jsp";
		</script>
<%	}
	else {
		try {
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
			if (stu_mode)
				mySQL = "select * from students where s_id='" + session_id +"'";
			else
				mySQL = "select * from professor where p_id='" + session_id + "'";
			myResultSet = stmt.executeQuery(mySQL);
		}catch(SQLException e){
			out.println(e);
			e.printStackTrace();
		}finally{
			if (myResultSet.next()) {
				if (stu_mode){
					userPassword = myResultSet.getString("s_pw");
					userAddr = myResultSet.getString("s_email");
				}
				else {
					userPassword = myResultSet.getString("p_pw");
					userAddr = myResultSet.getString("p_email");
				}
			}
			else {
%>
				<script>
					alert("세션이 종료되었습니다.");
					location.href("main.jsp");
				</script>
<%				
			}
		}
	}
%>
	<form method="post" action="update_verify.jsp?mode=<%=stu_mode%>&id=<%=session_id%>"> <br><br><br>
	<table width="20%" align="center" bgcolor="FFFFFF" border>
	<tr>
	<td><div align="center">아이디</div></td>
	<td><%=session_id%></td>
	</tr>
	<tr>
	<td><div align="center">새 비밀번호</div></td>
	<td><div align="center">
	<input type="password" name="updatePW">
	</div></td>
	</tr>
	<tr>
	<td><div align="center">비밀번호 확인</div></td>
	<td><div align="center">
	<input type="password" name="updatePW_conf">
	</div></td>
	</tr>
	<tr>
	<td><div align="center">E-mail</div></td>
	<td><div align="center">
	<input type="text" name="updateAddr" value=<%=userAddr%>>
	</div></td>
	</tr>
	<tr>
	<td colspan=2><div align="center">
	<br><br>
	<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="확인">
	<INPUT TYPE="RESET" VALUE="취소">
	</div></td></tr>
	</table>
	</form>
</body>
</html>