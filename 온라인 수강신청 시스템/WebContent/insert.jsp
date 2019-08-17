<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청</title>
<%	String courseID = null;
	String courseNo = null;
	String courseName = null;
	String courseCredit = null;
	String p_id= null;
	String profName = null;
	String t_year = null;
	String t_sem = null;
	String t_day = null;
	String t_hour = null;
	String t_shour = null;
	String t_ehour = null;
	String t_room = null;
	String t_max = null;
	String mySQL = null;
	Statement stmt = null;
	PreparedStatement pstmt = null;
	CallableStatement cstmt = null, cstmt2 = null;
	ResultSet myResultSet = null;
%>
</head>
<body>
<%@include file="top.jsp" %>
<%@include file="dbconfig.jsp" %>
<% if (stu_mode) { %>
	<table class="insert" width="50%" align="center">
	<form method="post" action="search.jsp">
	<tr><br>
	<td><div align="center">
	<select name="searchMenu" style="width:80px">
	<option value=1>강좌 이름</option>
	<option value=2>교수님</option>
	<option value=3>과목 id</option>
	<option value=4>학기</option>
	</select>
	</div></td>
	<td><div align="center"><input style="width:300px" type="text" name="searchText"></div></td>
	<td><div align="center"><input type="submit" name="submit" value="검색"></div></td>
	</tr>
	</form>
	</table>
	
	<br><br><table id = "courseTable" width="100%" align="center" border>
	<form method="post">
	<tr>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:25px;">과목 id</h2><hr></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:25px;">학점</h2><hr></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:25px;">학기</h2><hr></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:25px;">과목 이름</h2><hr></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:25px;">요일 및 시간</h2><hr></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:25px;">담당 교수</h2><hr></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:25px;">강의실</h2><hr></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:25px;">정원</h2><hr></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:25px;">현재 인원</h2><hr></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:25px;">신청</h2><hr></div></td>
	</tr>
<%	if (session_id != null){
		int currentNumber = 0;
		ResultSet pResultSet = null;
		try {
			stmt = myConn.createStatement();
			mySQL = "select * from teach t, professor p, course c where p.p_id=t.p_id and t.c_id=c.c_id and t.c_no=c.c_no";
			myResultSet = stmt.executeQuery(mySQL);
			cstmt = myConn.prepareCall("{? = call getStrDay(?)}");
			cstmt2 = myConn.prepareCall("{? = call getStrHour(?,?)}");
			pstmt = myConn.prepareStatement("select count(*) from enroll where c_id=? and c_no=? and e_year=? and e_sem=?");
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			while(myResultSet.next()) {
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
				try {
					cstmt.setInt(2, Integer.parseInt(t_day));
					cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
					cstmt.execute();
					cstmt2.setInt(2, Integer.parseInt(t_shour));
					cstmt2.setInt(3, Integer.parseInt(t_ehour));
					cstmt2.registerOutParameter(1, java.sql.Types.VARCHAR);
					cstmt2.execute();
					t_day = cstmt.getString(1); 
					t_hour = cstmt2.getString(1);
					pstmt.setString(1, courseID);
					pstmt.setString(2, courseNo);
					pstmt.setString(3, t_year);
					pstmt.setString(4, t_sem);
					pResultSet = pstmt.executeQuery();
				}catch(SQLException e2) {
					e2.printStackTrace();
				}
				out.println("<tr>");
				out.println("<td style=\"font-size: 17px;\"><div align=\"center\">" + courseID + "</div></td>");
				out.println("<td style=\"font-size: 17px;\"><div align=\"center\">" + courseCredit + "</div></td>");
				out.println("<td style=\"font-size: 17px;\"><div align=\"center\">" + t_year + "-" + t_sem + "</div></td>");
				out.println("<td style=\"font-size: 17px;\"><div align=\"center\">" + courseName + " 0" + courseNo +"</div></td>");				
				out.println("<td style=\"font-size: 17px;\"><div align=\"center\">" + t_day + " " + t_hour + "</div></td>");
				out.println("<td style=\"font-size: 17px;\"><div align=\"center\">" + profName + "</div></td>");
				out.println("<td style=\"font-size: 17px;\"><div align=\"center\">" + t_room + "</div></td>");
				out.println("<td style=\"font-size: 17px;\"><div align=\"center\">" + t_max + "</div></td>");
				if (pResultSet.next()) {
					currentNumber = pResultSet.getInt(1);
					out.println("<td style=\"font-size: 17px;\"><div align=\"center\">" + currentNumber + "</div></td>");
				}
%>				<td><div align="center"><a style="background-color: #8EE088; font-size:17px; color:white;" href="insert_verify.jsp?mode=<%=stu_mode%>&id=<%=session_id%>&c_id=<%=courseID%>&c_no=<%=courseNo%>&e_year=<%=t_year%>&e_sem=<%=t_sem%>">신청</a></div></td>
				</tr>
<%
			}	
			stmt.close();
			cstmt.close();
			pstmt.close();
			myConn.close();
		}
	}
	else {
		%>
		<script>
			alert("로그인 후 이용해주세요.");
			location.href="login.jsp";
		</script>
		<% 
	}
%>
</form>
</table><%
}else { /*professor mode*/
	if (session_id != null) {
		ResultSet pResultSet = null;
		String add_Name = null;
		%>
		<div class='table-wrapper'>
		<table id = "courseTable" width="100%" align="center" border>
		<form method="post">
		<thead><br>
		<h2 style="font-size:25px; text-align : center;">분 반 개 설</h2><br>
		<tr>
		<td><div align="center"><h2 style="background-color: #CEF279; font-size:20px;">과목 id</h2></div></td>
		<td><div align="center"><h2 style="background-color: #CEF279; font-size:20px;">학점</h2></div></td>
		<td><div align="center"><h2 style="background-color: #CEF279; font-size:20px;">학기</h2></div></td>
		<td><div align="center"><h2 style="background-color: #CEF279; font-size:20px;">과목 이름</h2></div></td>
		<td><div align="center"><h2 style="background-color: #CEF279; font-size:20px;">요일 및 시간</h2></div></td>
		<td><div align="center"><h2 style="background-color: #CEF279; font-size:20px;">담당 교수</h2></div></td>
		<td><div align="center"><h2 style="background-color: #CEF279; font-size:20px;">강의실</h2></div></td>
		<td><div align="center"><h2 style="background-color: #CEF279; font-size:20px;">정원</h2></div></td>
		<td><div align="center"><h2 style="background-color: #CEF279; font-size:20px;">분반 추가</h2></div></td>
		</tr>
		</thead>
		<tbody>
		<%
		try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
			mySQL = "select * from teach t, professor p, course c where p.p_id=t.p_id and t.c_id=c.c_id and t.c_no=c.c_no";
			myResultSet = stmt.executeQuery(mySQL);
			cstmt = myConn.prepareCall("{? = call getStrDay(?)}");
			cstmt2 = myConn.prepareCall("{? = call getStrHour(?,?)}");
		}catch (SQLException e) {
			e.printStackTrace();
		}finally {
			while(myResultSet.next()) {
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
				try {
					cstmt.setInt(2, Integer.parseInt(t_day));
					cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
					cstmt.execute();
					cstmt2.setInt(2, Integer.parseInt(t_shour));
					cstmt2.setInt(3, Integer.parseInt(t_ehour));
					cstmt2.registerOutParameter(1, java.sql.Types.VARCHAR);
					cstmt2.execute();
					t_day = cstmt.getString(1); 
					t_hour = cstmt2.getString(1);
				}catch(SQLException e2) {
					e2.printStackTrace();
				}
				out.println("<tr>");
				out.println("<td><div align=\"center\">" + courseID + "</div></td>");
				out.println("<td><div align=\"center\">" + courseCredit + "</div></td>");
				out.println("<td><div align=\"center\">" + t_year + "-" + t_sem + "</div></td>");
				out.println("<td><div align=\"center\">" + courseName + " 0" + courseNo +"</div></td>");				
				out.println("<td><div align=\"center\">" + t_day + " " + t_hour + "</div></td>");
				out.println("<td><div align=\"center\">" + profName + "</div></td>");
				out.println("<td><div align=\"center\">" + t_room + "</div></td>");
				out.println("<td><div align=\"center\">" + t_max + "</div></td>");
%>		
				<td><div align="center"><a style="background-color: #1D8B15; font-size:17px; color:white;" href="pop_up.jsp?id=<%=session_id%>&c_id=<%=courseID%>">추가</a></div>
				</tr>
<%
			}	
			stmt.close();
			cstmt.close();
			myConn.close();
		}
	%>	
	</tbody>
	</form>
	</table>
	<table id=newCourseTable align="center" width="1200px" bgcolor="#FFFFFF" border>
	<form method="post" action="insert_verify.jsp?mode=<%=stu_mode%>&id=<%=session_id%>&add=false">
	<tr><br><h2 style="font-size:25px; text-align : center;">수 업 개 설</h2><br>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:20px;">과목 이름</h2></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:20px;">분반</h2></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:20px;">요일</h2></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:20px;">시간</h2></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:20px;">장소</h2></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:20px;">인원</h2></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:20px;">학점</h2></div></td>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:20px;">추가</h2></div></td>
	<td><div align="center">   </div></td>
	</tr>
	<tr>
	<td><br><div align="center"><input type="text" name="courseName"></div></td>
	<td><br><div align="center"><input type="text" style="width:20px" name="courseNo"></div></td>
	<td><br><div align="center">
<script>
function count_ck(obj){
	var chkbox = document.getElementsByName("courseDay");
	var chkCnt = 0;

	for(var i=0;i<chkbox.length; i++){
		if(chkbox[i].checked){
			chkCnt++;
		}
	}
	
	if(chkCnt>2){
		alert("2일 이하로만 신청하실 수 있습니다.");
		obj.checked = false;
		return false;
	}
}
</script>
	<input type="checkbox" name="courseDay" onClick="count_ck(this);" value="mon">월
	<input type="checkbox" name="courseDay" onClick="count_ck(this);" value="tue">화
	<input type="checkbox" name="courseDay" onClick="count_ck(this);" value="wed">수
	<input type="checkbox" name="courseDay" onClick="count_ck(this);" value="thu">목
	<input type="checkbox" name="courseDay" onClick="count_ck(this);" value="fri">금
	</div></td>
	<td><br><div align="center">
	<select name = "startHour" style="width:50px">
	<%
		for (int i = 9; i <= 18; i++) {
			out.println("<option value=" + i +">" + i + "</option>");
		}
	%>
	</select> 시
	<input type="text" style="width:30px" name="startMinute"> 분~
<!-- <input type="text" style="width:20px" name="endHour"> :  -->
	<select name = "endHour" style="width:50px">
	<%
		for (int i = 9; i <= 18; i++) {
			out.println("<option value=" + i +">" + i + "</option>");
		}
	%>
	</select> 시
	<input type="text" style="width:30px" name="endMinute">분</div></td>
	<td><br><div align="center">
	<select name="courseRoom" style="width:80px">
	<option value="명신관">명신관</option>
	<option value="순헌관">순헌관</option>
	<option value="진리관">진리관</option>
	<option value="새힘관">새힘관</option>
	<option value="과학관">과학관</option>
	<option value="수련교수회관">수련교수회관</option>
	</select>
	<input type="text" style="width:40px" name="courseRoomNo">호</div></td>
	<td><br><div align="center"><input type="text" style="width:40px" name="courseMax"></div></td>
	<td><br><div align="center">
	<select name="courseUnit">
	<option value=3>3</option>
	<option value=2>2</option>
	<option value=1>1</option>
	</select>
	</div></td>
	<td><br><div align="center"><input type="submit" name="submit" value="추가"></div></td>
	</tr>
	</table>
	<%
	}
	else {
		%>
		<script>
			alert("로그인 후 이용해주세요.");
			location.href="login.jsp";
		</script>
		<% 
	}
} 
%>
</body>
</html>
