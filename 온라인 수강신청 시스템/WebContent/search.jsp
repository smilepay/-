<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%@ include file="dbconfig.jsp"%>
<!DOCTYPE html>
<html>
<head>
<%
	String searchMenu = request.getParameter("searchMenu");
	String searchData = new String(request.getParameter("searchText").getBytes("ISO-8859-1"),"UTF-8");
	Connection conn = null;
	PreparedStatement pstmt = null;
	CallableStatement cstmt = null;
	ResultSet myResultSet = null;
	String courseID = null;
	String courseNo = null;
	String courseName = null;
	String courseCredit = null;
	String profName = null;
	String t_day = null;
	String t_year = null;
	String t_sem = null;
	String p_id = null;
	String t_hour = null;
	String t_shour = null, t_ehour = null;
	String t_room = null;
	String t_max = null;
%>
<meta charset="UTF-8">
<title>강좌 검색</title>
<link href="https://fonts.googleapis.com/css?family=Jua&display=swap" rel="stylesheet">	
<style type="text/css">
	body{
		font-family: 'Jua', sans-serif;
	}
	.insert {
		border-radius: 10px;
		border: 1px solid #000000;
		bgcolor: #cdcdcd;	
	}
	table {
		border-collapse:collapse;
		margin-top: 10px;
	}
	td {
		border: 1px solid #cdcdcd;
	}
</style></head>
<body>
<%@include file="top.jsp"%>
<pre><%out.println();%></pre>
<table width="100%" align="center" border>
	<tr>
	<td><div align="center">과목 id</div></td>
	<td><div align="center">학점</div></td>
	<td><div align="center">학기</div></td>
	<td><div align="center">과목 이름</div></td>
	<td><div align="center">요일 및 시간</div></td>
	<td><div align="center">담당 교수</div></td>
	<td><div align="center">강의실</div></td>
	<td><div align="center">정원</div></td>
	<td><div align="center">현재 인원</div></td>
	<td><div align="center">신청</div></td>
	</tr>
	<tr>
<% 	
	int s_menu = Integer.parseInt(searchMenu);
	String[] s_sem;
	try{
		Class.forName(dbdriver);
		conn = DriverManager.getConnection(dburl, user, passwd);
		switch(s_menu) {
		case 1:
			pstmt = conn.prepareStatement("select * from course c, teach t, professor p where c.c_id=t.c_id and c.c_no=t.c_no and t.p_id=p.p_id and c_name=?");
			pstmt.setString(1, searchData);
			break;
		case 2:
			pstmt = conn.prepareStatement("select * from course c, teach t, professor p where c.c_id=t.c_id and c.c_no=t.c_no and t.p_id=p.p_id and p.p_name=?");			
			pstmt.setString(1, searchData);
			break;
		case 3:
			pstmt = conn.prepareStatement("select * from course c, teach t, professor p where c.c_id=t.c_id and c.c_no=t.c_no and t.p_id=p.p_id and c.c_id=?");
			pstmt.setString(1, searchData);
			break;
		case 4:
			pstmt = conn.prepareStatement("select * from course c, teach t, professor p where c.c_id=t.c_id and c.c_no=t.c_no and t.p_id=p.p_id and t.t_year=? and t.t_sem=?");
			s_sem = searchData.split("-");
			for (int i = 0; i < s_sem.length; i++){
				System.out.println("## " + s_sem[i]);
			}
			pstmt.setString(1, s_sem[0]);
			pstmt.setString(2, s_sem[1]);
			break;	
		}
		myResultSet = pstmt.executeQuery();
	}catch(SQLException e){
		System.out.println("error 1");
		e.printStackTrace();
	}finally {
		PreparedStatement pstmt2 = null;
		pstmt2 = conn.prepareStatement("select count(*) from enroll where c_id=? and c_no=? and e_year=? and e_sem=?");
		while (myResultSet.next()) {
			int currentNumber = 0;
			courseID = myResultSet.getString("c_id");
			courseNo = myResultSet.getString("c_no");
			courseName = myResultSet.getString("c_name");
			courseCredit = myResultSet.getString("c_credit");
			profName = myResultSet.getString("p_name");
			t_day = myResultSet.getString("t_day");
			t_year = myResultSet.getString("t_year");
			t_sem = myResultSet.getString("t_sem");
			p_id = myResultSet.getString("p_id");
			t_shour = myResultSet.getString("t_shour");
			t_ehour = myResultSet.getString("t_ehour");
			t_room = myResultSet.getString("t_room");
			t_max = myResultSet.getString("t_max");
			ResultSet pResultSet = null;
			try{
				cstmt = conn.prepareCall("{? = call getStrDay(?)}");
				cstmt.setInt(2, Integer.parseInt(t_day));
				cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
				cstmt.execute();
				t_day = cstmt.getString(1);
				cstmt = conn.prepareCall("{? = call getStrHour(?,?)}");
				cstmt.setInt(2, Integer.parseInt(t_shour));
				cstmt.setInt(3, Integer.parseInt(t_ehour));
				cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
				cstmt.execute();
				t_hour = cstmt.getString(1);
				pstmt2.setString(1, courseID);
				pstmt2.setString(2, courseNo);
				pstmt2.setString(3, t_year);
				pstmt2.setString(4, t_sem);
				pResultSet = pstmt2.executeQuery();
				if (pResultSet == null)
					System.out.println("null");
			}catch(SQLException e2) {
				System.out.println("error 2");
				e2.printStackTrace();
			}finally {
				out.println("<tr>");
				out.println("<td><div align=\"center\">" + courseID + "</div></td>");
				out.println("<td><div align=\"center\">" + courseCredit + "</div></td>");
				out.println("<td><div align=\"center\">" + t_year + "-" + t_sem + "</div></td>");
				out.println("<td><div align=\"center\">" + courseName + " 0" + courseNo +"</div></td>");				
				out.println("<td><div align=\"center\">" + t_day + " " + t_hour + "</div></td>");
				out.println("<td><div align=\"center\">" + profName + "</div></td>");
				out.println("<td><div align=\"center\">" + t_room + "</div></td>");
				out.println("<td><div align=\"center\">" + t_max + "</div></td>");
				
				if (pResultSet.next()) {
					currentNumber = pResultSet.getInt(1);
					out.println("<td><div align=\"center\">" + currentNumber + "</div></td>");
				}
%>				<td><div align="center"><a href="insert_verify.jsp?mode=<%=stu_mode%>&id=<%=session_id%>&c_id=<%=courseID%>&c_no=<%=courseNo%>&e_year=<%=t_year%>&e_sem=<%=t_sem%>">신청</a></div></td>
				</tr>
			
<%			}
		}
		if(pstmt != null) pstmt.close();
		if(pstmt2 != null) pstmt2.close();
		if(cstmt != null) cstmt.close();
	}
%>
</tr>
</table>
</body>
</html>