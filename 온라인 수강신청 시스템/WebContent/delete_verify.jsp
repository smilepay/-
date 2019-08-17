<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="dbconfig.jsp"%>
 
<%
	String c_id = request.getParameter("c_id");
	String myId = request.getParameter("id");
	String e_year = request.getParameter("e_year");
	String e_sem = request.getParameter("e_sem");
	String myMode = request.getParameter("mode");
	String mySQL = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	ResultSet myResultSet = null;
	int change = 0;

	try {
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
	}catch(SQLException ex){
		ex.printStackTrace();
	}
	if (myMode.equals("true")) {
		try {
			mySQL = "delete from enroll where c_id=? and e_year=? and e_sem=? and s_id=?";
			pstmt = myConn.prepareStatement(mySQL);
			pstmt.setString(1, c_id);
			pstmt.setString(2, e_year);
			pstmt.setString(3, e_sem);
			pstmt.setString(4, myId);
			change = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			if (change == 0) {
				%>
				<script>
					alert("삭제에 실패하였습니다.");
					location.href="delete.jsp";
				</script>
				<%
			}
			else {
				%>
				<script>
					alert("삭제되었습니다.");
					location.href="delete.jsp";
				</script>
				<%
			}	
		}
	}
	else {
		String c_no = request.getParameter("c_no");
		String t_year = request.getParameter("t_year");
		String t_sem = request.getParameter("t_sem");
		try {
			mySQL = "delete from course where c_id=? and c_no=?";
			pstmt = myConn.prepareStatement(mySQL);
			pstmt.setString(1, c_id);
			pstmt.setString(2, c_no);
			change = pstmt.executeUpdate();
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			if (change == 0) {
				%>
				<script>
					alert("삭제에 실패하였습니다.");
					location.href="delete.jsp";
				</script>
				<%
			}
			else {
				%>
				<script>
					alert("삭제되었습니다.");
					location.href="delete.jsp";
				</script>
				<%
			}	
		}
	}
	%>