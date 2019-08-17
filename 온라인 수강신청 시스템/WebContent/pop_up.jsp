<%@ page language="java" contentType="text/html; charset=UTF-8"
 pageEncoding="UTF-8" import="java.sql.*" import="java.net.URLEncoder" %>
<%@ include file="dbconfig.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>분반 추가</title>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/layout.css" />
<%
	/* 분반 자동 생성  시 나머지 사항(장소, 요일, 시간) 입력 받아서 insert_verify.jsp로 넘기는 기능 */
	String p_id = request.getParameter("id");
	String c_id = request.getParameter("c_id");
	String c_no = null;
	String c_name = null;
	String c_credit = null;
	String t_room = null;
	String t_max = null;
	String t_day = null;
	String sSQL = null;
	Statement stmt = null;
	CallableStatement cstmt = null;
	ResultSet myResultSet = null;
%>
</head>
<body>
<%	int next_no = 0;
	try {
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
		stmt = myConn.createStatement();
		sSQL = "select c_name, c_credit from course where c_id='" + c_id + "'";
		cstmt = myConn.prepareCall("{? = call getNextCno(?)}");
		cstmt.setString(2, c_id);
		cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
		cstmt.execute();
		next_no = cstmt.getInt(1);
		myResultSet = stmt.executeQuery(sSQL);
	}catch(SQLException e){
		e.printStackTrace();
		System.out.print("section 1");
	}finally {
		if(myResultSet.next()) {
			c_name = myResultSet.getString("c_name");
			c_credit = myResultSet.getString("c_credit");
		}
		stmt.close();
		cstmt.close();
		myConn.close();
	}
	boolean myMode = false;
	
%>	

	<table width="75%" align="center" border>
	<form method="post" action="insert_verify.jsp?mode=<%=myMode%>&id=<%=p_id%>&courseName=<%=URLEncoder.encode(c_name,"UTF-8")%>&courseNo=<%=next_no%>&courseUnit=<%=c_credit%>&add=true">
	<tr><br>
	<td colspan=2><div align="center"><h2 style="background-color: #E0FFDB; font-size:25px;"><%=c_name%>분반 추가</h2><hr></div></td>
	</tr>
	<tr>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:20px;">요일</h2></div></td>
	<td><div align="center">
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
	<input type="checkbox" name="courseDay" onClick="count_ck(this);" value="fri">금<br><br>
	</div></td>
	</tr>
	<tr>
   	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:20px;">시간</h2></div></td>
   	<td><br><div align="center">
	<select name = "startHour" style="width:50px">
	<%
		for (int i = 9; i <= 18; i++) {
			out.println("<option value=" + i +">" + i + "</option>");
		}
	%>
	</select> 시
	<input type="text" style="width:30px" name="startMinute"> 분~
	<select name = "endHour" style="width:50px">
	<%
		for (int i = 9; i <= 18; i++) {
			out.println("<option value=" + i +">" + i + "</option>");
		}
	%>
	</select> 시
	<input type="text" style="width:30px" name="endMinute">분</div></td>
   	</tr>
	<tr>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:20px;">장소</h2></div></td>
	<td><div align="center">
	<select name="courseRoom" style="width:80px">
	<option value="명신관">명신관</option>
	<option value="순헌관">순헌관</option>
	<option value="진리관">진리관</option>
	<option value="새힘관">새힘관</option>
	<option value="과학관">과학관</option>
	<option value="수련교수회관">수련교수회관</option>
	</select>
	<input type="text" style="width:40px" name="courseRoomNo">호<br><br></div></td>
	</tr>
	<tr>
	<td><div align="center"><h2 style="background-color: #FFFFC6; font-size:20px;">인원</h2></div></td>
	<td><div align="center"><input type="text" style="width:40px" name="courseMax"><br><br></div></td>
	</tr>
	<tr>
	<td colspan=2><div align="center"><input type="submit" value="추가">  <input type="reset" value="취소"></div></td>
	</tr>
	</form>
	</table>
</body>
</html>
