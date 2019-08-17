<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*"  import="java.net.URLDecoder" %>
<%@ include file="dbconfig.jsp"%>
<meta charset="UTF-8">
<%
	String sSQL = null, pSQL = null;
	Statement stmt = null;
	CallableStatement cstmt = null;
	ResultSet myResultSet = null;
	String userID = request.getParameter("id");
	String userMode = request.getParameter("mode");
	boolean isSucceed = false;
	try {
		Class.forName(dbdriver);
		myConn = DriverManager.getConnection(dburl, user, passwd);
	}catch(SQLException e){
		e.printStackTrace();
		System.out.print("section 1");
	}
	if (userMode.equals("true")) {
		String s_id = request.getParameter("id");
		String c_id = request.getParameter("c_id");
		String c_no = request.getParameter("c_no");
		String result = " ";
		try {
			cstmt = myConn.prepareCall("{call InsertEnroll(?, ?, ?, ?)}");			
			PreparedStatement pstmt = myConn.prepareStatement("call InsertEnroll(?, ?, ?, ?)");
			cstmt.setString(1, s_id);
			cstmt.setString(2, c_id);
			cstmt.setInt(3, Integer.parseInt(c_no));
			cstmt.registerOutParameter(4, java.sql.Types.VARCHAR);
			isSucceed = cstmt.execute();
			result = cstmt.getString(4);
		}catch(SQLException e) {
			e.printStackTrace();
		}finally {
			if (isSucceed) {
				%>
				<script>
					alert("추가되었습니다.");
					location.href="insert.jsp";
				</script>		
				<%
			}
			else {
			%>
			<script>
				alert("<%=result%>");
				location.href="insert.jsp";
			</script>		
			<%
			}
		}
	}
	else { /*professor mode*/
//		request.setCharacterEncoding("UTF-8");
		String p_id = request.getParameter("id");
		String add = request.getParameter("add");
		String c_name = null;
		/* add : 분반 추가 페이지에서 보냈는지, insert 페이지에서 보냈는 지 구분 */
		if (add.equals("true")) {
			c_name = request.getParameter("courseName");
			c_name = URLDecoder.decode(c_name, "UTF-8");
		}
		else {
			c_name = new String(request.getParameter("courseName").getBytes("ISO-8859-1"),"UTF-8");
		}
		String[] c_day = request.getParameterValues("courseDay");
		String sHour = request.getParameter("startHour");
		String sMinute = request.getParameter("startMinute");
		String eHour = request.getParameter("endHour");
		String eMinute = request.getParameter("endMinute");
		String t_max = request.getParameter("courseMax");
		String c_room = new String(request.getParameter("courseRoom").getBytes("ISO-8859-1"),"UTF-8");		
		String c_room_no = request.getParameter("courseRoomNo");
		String c_credit = request.getParameter("courseUnit");
		String c_id = null;
		String c_no = request.getParameter("courseNo");
		String myDay = "";
		String myRoom = "";
		String t_hour;
		int t_year = 0;
		int t_sem = 0;
		
		if (c_name == null || c_name.equals("")) {
			%>
			<script>
				alert("과목 이름을 입력해주세요.");
				location.href="insert.jsp";
			</script>
			<% 
		}
		else if (c_no == null || c_no.equals("")) {
			%>
			<script>
				alert("분반을 입력해주세요.");
				location.href="insert.jsp";
			</script>
			<% 			
		}
		else if (c_day == null) {
			%>
			<script>
				alert("요일을 입력해주세요.");
				location.href="insert.jsp";
			</script>
			<% 
		}
		else if (sHour == null || sMinute == null || eHour == null || eMinute == null || sHour.equals("") || sMinute.equals("") || eHour.equals("") || eMinute.equals("")) {
			%>
			<script>
				alert("시간을 입력해주세요.");
				location.href="insert.jsp";
			</script>
			<% 
		}
		else if (Integer.parseInt(sHour+sMinute) >= Integer.parseInt(eHour+eMinute)){
	         %>
	         <script>
	            alert("시간 입력이 잘못되었습니다.");
	            location.href="insert.jsp";
	         </script>
	         <% 
	      }
	      else if ((Integer.parseInt(sMinute) >= 60) || ( Integer.parseInt(eMinute) >= 60)){
			%>
			<script>
				alert("시간 입력이 잘못되었습니다.");
				location.href="insert.jsp";
			</script>
			<% 
		}
		else if (c_room_no == null || c_room_no.equals("")) {
			%>
			<script>
				alert("장소을 입력해주세요.");
				location.href="insert.jsp";
			</script>
			<% 
		}
		else if (t_max == null || t_max.equals("")) {
			%>
			<script>
				alert("정원을 입력해주세요.");
				location.href="insert.jsp";
			</script>
			<% 
		}
		else {
			String result = "";
			myRoom += c_room + " " + c_room_no;
			for (int i = 0; i < c_day.length; i++) {
				switch(c_day[i]) {
				case "mon":
					myDay += '1';
					break;
				case "tue":
					myDay += '2';
					break;
				case "wed":
					myDay += '3';
					break;
				case "thu":
					myDay += '4';
					break;
				case "fri":
					myDay += '5';
					break;
				}
			}
			try {
				cstmt = myConn.prepareCall("{call InsertCourse(?,?,?,?,?,?,?,?,?,?,?,?)}");
				cstmt.setString(1, c_name);
				cstmt.setString(2, c_no);
				cstmt.setString(3, c_credit);
				cstmt.setString(4, p_id);
				cstmt.setInt(5, Integer.parseInt(sHour));
				cstmt.setInt(6, Integer.parseInt(sMinute));
				cstmt.setInt(7, Integer.parseInt(eHour));
				cstmt.setInt(8, Integer.parseInt(eMinute));
				cstmt.setString(9, myDay);
				cstmt.setString(10, t_max);
				cstmt.setString(11, myRoom);
				cstmt.registerOutParameter(12, java.sql.Types.VARCHAR);
				isSucceed = cstmt.execute();
				result = cstmt.getString(12);			
			}catch(SQLException e){
				e.printStackTrace();
			}finally {
				if (isSucceed) {
					%>
					<script>
						alert("추가되었습니다.");
						location.href="insert.jsp";
					</script>		
					<%
				}
				else {
					%>
				<script>
					alert("<%=result%>");
					location.href="insert.jsp";
				</script>		
				<%
				}
			}
		}
	}
%>
