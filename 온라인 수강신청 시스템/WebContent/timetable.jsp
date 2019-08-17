<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" %>
<%@ page import="java.util.Random"%>
<%@ include file="dbconfig.jsp"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>수강신청 조회</title>
<%
	String mySQL = null;
	Statement stmt = null;
	CallableStatement cstmt = null, cstmt2 = null;
%>	
</head>

<body>
<%@include file="top.jsp" %>
<pre><%out.println();%></pre>
<%	ResultSet myResultSet = null;
	PreparedStatement pstmt = null;
	if(session_id == null) {
		%>
		<script>
			alert("로그인 후 이용해주세요.");
			location.href="login.jsp";
		</script>
		<%
	}
	else {
		String courseID = null;
		String courseNo = null;
		String courseName = null;
		String p_id= null;
		String profName = null;
		String t_year = null;
		String t_sem = null;
		String t_day = null;
		String t_hour = null;
		String t_shour = null, t_ehour = null;
		String t_room = null;
		try {
			Class.forName(dbdriver);
			myConn = DriverManager.getConnection(dburl, user, passwd);
			stmt = myConn.createStatement();
		}catch(SQLException e1) {
			System.out.println("section 1 error");
			e1.printStackTrace();
		}
		if (stu_mode) { /*student mode*/
			%>			
			<%
			try {
				mySQL = "select * from teach t, professor p, course c where p.p_id=t.p_id and t.c_id=c.c_id and t.c_no=c.c_no and (t.c_id, t.c_no, t.t_year, t.t_sem) in (select c_id, c_no, e_year, e_sem from enroll where s_id ="+session_id+")";
				myResultSet = stmt.executeQuery(mySQL);
				cstmt = myConn.prepareCall("{? = call getStrDay(?)}");
				cstmt2 = myConn.prepareCall("{? = call getStrHour(?,?)}");
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				while(myResultSet.next()) {
					courseID = myResultSet.getString("c_id");
					courseNo = myResultSet.getString("c_no");
					courseName = myResultSet.getString("c_name");
					profName = myResultSet.getString("p_name");
					t_year = myResultSet.getString("t_year");
					t_sem = myResultSet.getString("t_sem");
					p_id = myResultSet.getString("p_id");
					t_day = myResultSet.getString("t_day");
					t_shour = myResultSet.getString("t_shour");
					t_ehour = myResultSet.getString("t_ehour");
					t_room = myResultSet.getString("t_room");
					try {
						cstmt.setInt(2, Integer.parseInt(t_day));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
						cstmt.execute();
						t_day = cstmt.getString(1);
						cstmt2.setInt(2, Integer.parseInt(t_shour));
						cstmt2.setInt(3, Integer.parseInt(t_ehour));
						cstmt2.registerOutParameter(1, java.sql.Types.VARCHAR);
						cstmt2.execute();
						t_hour = cstmt2.getString(1);
					}catch(SQLException e2) {
						e2.printStackTrace();
					}
				}	
				%>
				<%//시간표 생성 %>
				<table width="800px" height="100%" align="center" style="margin-top:20px">
				<colgroup width="50px"></colgroup>
				<colgroup width="100px"></colgroup>
				<colgroup width="100px"></colgroup>
				<colgroup width="100px"></colgroup>
				<colgroup width="100px"></colgroup>
				<colgroup width="100px"></colgroup>
				<tr>
				<th style="background-color: #D9D6FF; font-size:20px;">시간</th>
				<th style="background-color: #D9D6FF; font-size:20px;">월</th>
				<th style="background-color: #D9D6FF; font-size:20px;">화</th>
				<th style="background-color: #D9D6FF; font-size:20px;">수</th>
				<th style="background-color: #D9D6FF; font-size:20px;">목</th>
				<th style="background-color: #D9D6FF; font-size:20px;">금</th>
				</tr>
				<%
				int table_day = 0;
				int s_time = 0, e_time = 0;
				int s_min = 0, e_min = 0;
				int rowspan = 0;
				String table_time = null;
				String table_cname = null;
				String table_room = null;
				String str = null;
				String[][] table_data= new String[40][5];
				int [] time = new int[11];
				boolean[][] isRowSpanned = new boolean[40][6];
				for (int i = 0; i < 11; i++){
					time[i] = 9+i;
				}
				try {
					mySQL = "select c.c_name, t.t_shour, t.t_ehour, t.t_day, t.t_room from course c, teach t where c.c_id=t.c_id and c.c_no=t.c_no and (t.c_id, t.c_no, t.t_year, t.t_sem) in (select c_id, c_no, e_year, e_sem from enroll where s_id='" + session_id +"') ";
					myResultSet = stmt.executeQuery(mySQL);
				}catch(SQLException e3){
					e3.printStackTrace();
				}
				finally {
					int row = 0, erow = 0, column = 0;
					while(myResultSet.next()) {						
						table_day = Integer.parseInt(myResultSet.getString("t_day"));
						s_time = Integer.parseInt(myResultSet.getString("t_shour"));
						e_time = Integer.parseInt(myResultSet.getString("t_ehour"));
						table_cname = myResultSet.getString("c_name");
						table_room = myResultSet.getString("t_room");
						str = table_cname + "<br>" + table_room;
						s_min = s_time%100; e_min = e_time%100;
						s_time = s_time / 100; e_time = e_time / 100;
						row = 4*(s_time - 9); 
						erow = 4*(e_time - 9)-1;
						
						if ((8 <= s_min) && (s_min < 23)){
							row += 1;
						}
						else if ((23 <= s_min) && (s_min < 38)){
							row += 2;
						}
						else if ((38 <= s_min) && (s_min < 53)){
							row += 3;
						}
						else if (s_min >= 53){
							row += 4;
						}
						if ((8 <= e_min) && (e_min < 23)){
							erow += 1;
						}
						else if ((23 <= e_min) && (e_min < 38)){
							erow += 2;
						}
						else if ((38 <= e_min) && (e_min < 53)){
							erow += 3;
						}
						else if (e_min >= 53){
							erow += 4;
						}
						
						switch(table_day) {
						case 1 : 
							column = 0;
							table_data[row][0] = str;
							break;
						case 2:
							column = 1;
							table_data[row][1] = str; break;
						case 3:
							column = 2;
							table_data[row][2] = str; break;
						case 4:
							column = 3;
							table_data[row][3] =str; break;
						case 5:
							column = 4;
							table_data[row][4] = str; break;
						case 12:
							column = 0;
							table_data[row][0] = str;
							table_data[row][1] = str;
							break;
						case 13:
							column = 0;
							table_data[row][0] = str;
							table_data[row][2] = str;
							break;
						case 14:
							column = 0;
							table_data[row][0] = str;
							table_data[row][3] = str; 
							break;
						case 15:
							column = 0;
							table_data[row][0] = str;
							table_data[row][4] = str; 
							break;
						case 23:
							column = 1;
							table_data[row][1] = str;
							table_data[row][2] = str; 
							break;
						case 24:
							column = 1;
							table_data[row][1] = str;
							table_data[row][3] = str; 
							break;
						case 25:
							column = 1;
							table_data[row][1] = str;
							table_data[row][4] = str; 
							break;
						case 34:
							column = 2;
							table_data[row][2] = str;
							table_data[row][3] = str; 
							break;
						case 35:
							column = 2;
							table_data[row][2] = str;
							table_data[row][4] = str; 
							break;
						case 45:
							column = 3;
							table_data[row][3] = str;
							table_data[row][4] = str; 
							break;
						}
						
						for (int r = row+1; r < erow+1; r++) {
							isRowSpanned[r][column] = true;
							if (table_day >= 10) {
								isRowSpanned[r][table_day%10-1] = true;
							}
						}
					}
				}	
				
				rowspan = 1;
				String bgcolor="#FFFFFF";
				int pass = 0;
				out.println("<tr height=\"20px\">");
				out.println("<td rowspan=\" " + 2 + "\" style=\"background-color: #FFEAEA; font-size:17px;\"><div align=\"center\">" + time[0] + "시" + "</div></td>");
				out.println("</tr>");	
				for (int i = 0; i < 40; i++) {
					out.println("<tr height=\"20px\">");
					if (i%4 == 3)
						out.println("<td rowspan=\" " + 2 + "\" style=\"background-color: #FFEAEA; font-size:17px;\"><div align=\"center\">" + time[(i/4)+1] + "시" +"</div></td>");
					else if ((i%4 == 1) || (i%4 == 2) )
						out.println("<td style=\"background-color: #FFEAEA;\"><div align=\"center\"></div></td>");
					for (int j = 0; j < 5; j++) {
						if (table_data[i][j] != null) {
							if (j == 0)
								bgcolor = "#FFDDDD"; 
							else if (j == 1)
								bgcolor = "#FFE5C2";
							else if (j == 2)
								bgcolor = "#FFFFE4";
							else if (j == 3)
								bgcolor = "#CEFBC9";
							else
								bgcolor = "#D4F4FA";
							for (int k = i+1; k < 40; k++){
								if (isRowSpanned[k][j])
									rowspan++;
								else
									break;
							}
						}
						else {
							table_data[i][j] = "";
						}
						if (!isRowSpanned[i][j]) {
							if (i%4 == 0)
								out.print("<td bgcolor=\" " +bgcolor+ " \" rowspan=\" " + rowspan + "\" style=\"border-top:1px solid Seashell;\"><div align=\"center\">");
							else
								out.print("<td bgcolor=\" " +bgcolor+ " \" rowspan=\" " + rowspan + "\" ><div align=\"center\">");
							out.print(table_data[i][j] + "</div></td>");
						}
						bgcolor = "#FFFFFF";
						rowspan = 1;						
					}
					out.println("</tr>");					
				}
				%>
				</table>
				<%
				cstmt.close();
				cstmt2.close();
				stmt.close();
				myConn.close();
			}
		}
		else { /*professor mode*/
			%>			
			<%
			try {
				mySQL = "select * from teach t, professor p, course c where p.p_id=t.p_id and t.c_id=c.c_id and t.c_no=c.c_no and (t.c_id, t.c_no, t.t_year, t.t_sem) in (select c_id, c_no, e_year, e_sem from enroll where s_id ="+session_id+")";
				myResultSet = stmt.executeQuery(mySQL);
				cstmt = myConn.prepareCall("{? = call getStrDay(?)}");
				cstmt2 = myConn.prepareCall("{? = call getStrHour(?,?)}");
			}catch(SQLException e) {
				e.printStackTrace();
			}finally {
				while(myResultSet.next()) {
					courseID = myResultSet.getString("c_id");
					courseNo = myResultSet.getString("c_no");
					courseName = myResultSet.getString("c_name");
					profName = myResultSet.getString("p_name");
					t_year = myResultSet.getString("t_year");
					t_sem = myResultSet.getString("t_sem");
					p_id = myResultSet.getString("p_id");
					t_day = myResultSet.getString("t_day");
					t_shour = myResultSet.getString("t_shour");
					t_ehour = myResultSet.getString("t_ehour");
					t_room = myResultSet.getString("t_room");
					try {
						cstmt.setInt(2, Integer.parseInt(t_day));
						cstmt.registerOutParameter(1, java.sql.Types.VARCHAR);
						cstmt.execute();
						t_day = cstmt.getString(1);
						cstmt2.setInt(2, Integer.parseInt(t_shour));
						cstmt2.setInt(3, Integer.parseInt(t_ehour));
						cstmt2.registerOutParameter(1, java.sql.Types.VARCHAR);
						cstmt2.execute();
						t_hour = cstmt2.getString(1);
					}catch(SQLException e2) {
						e2.printStackTrace();
					}
				}	
				%>
				<%//시간표 생성 %>
				<table width="700px" height="100%" align="center" style="margin-top:10px">
				<colgroup width="40px"></colgroup>
				<colgroup width="100px"></colgroup>
				<colgroup width="100px"></colgroup>
				<colgroup width="100px"></colgroup>
				<colgroup width="100px"></colgroup>
				<colgroup width="100px"></colgroup>
				<tr>
				<th style="background-color: #D9D6FF; font-size:20px;">시간</th>
				<th style="background-color: #D9D6FF; font-size:20px;">월</th>
				<th style="background-color: #D9D6FF; font-size:20px;">화</th>
				<th style="background-color: #D9D6FF; font-size:20px;">수</th>
				<th style="background-color: #D9D6FF; font-size:20px;">목</th>
				<th style="background-color: #D9D6FF; font-size:20px;">금</th>
				</tr>
				<%
				int table_day = 0;
				int s_time = 0, e_time = 0;
				int s_min = 0, e_min = 0;
				int rowspan = 0;
				String table_time = null;
				String table_cname = null;
				String table_room = null;
				String str = null;
				String[][] table_data= new String[40][5];
				int [] time = new int[11];
				boolean[][] isRowSpanned = new boolean[40][6];
				for (int i = 0; i < 11; i++){
					time[i] = 9+i;
				}
				try {
					mySQL = "select * from teach t, professor p, course c where p.p_id = '" + session_id +"' and p.p_id=t.p_id and t.c_id=c.c_id and t.c_no=c.c_no";
					myResultSet = stmt.executeQuery(mySQL);
				}catch(SQLException e3){
					e3.printStackTrace();
				}
				finally {
					int row = 0, erow = 0, column = 0;
					while(myResultSet.next()) {						
						table_day = Integer.parseInt(myResultSet.getString("t_day"));
						s_time = Integer.parseInt(myResultSet.getString("t_shour"));
						e_time = Integer.parseInt(myResultSet.getString("t_ehour"));
						table_cname = myResultSet.getString("c_name");
						table_room = myResultSet.getString("t_room");
						str = table_cname + "<br>" + table_room;
						s_min = s_time%100; e_min = e_time%100;
						s_time = s_time / 100; e_time = e_time / 100;
						row = 4*(s_time - 9); 
						erow = 4*(e_time - 9)-1;
						
						if ((8 <= s_min) && (s_min < 23)){
							row += 1;
						}
						else if ((23 <= s_min) && (s_min < 38)){
							row += 2;
						}
						else if ((38 <= s_min) && (s_min < 53)){
							row += 3;
						}
						else if (s_min >= 53){
							row += 4;
						}
						if ((8 <= e_min) && (e_min < 23)){
							erow += 1;
						}
						else if ((23 <= e_min) && (e_min < 38)){
							erow += 2;
						}
						else if ((38 <= e_min) && (e_min < 53)){
							erow += 3;
						}
						else if (e_min >= 53){
							erow += 4;
						}
						
						switch(table_day) {
						case 1 : 
							column = 0;
							table_data[row][0] = str;
							break;
						case 2:
							column = 1;
							table_data[row][1] = str; break;
						case 3:
							column = 2;
							table_data[row][2] = str; break;
						case 4:
							column = 3;
							table_data[row][3] =str; break;
						case 5:
							column = 4;
							table_data[row][4] = str; break;
						case 12:
							column = 0;
							table_data[row][0] = str;
							table_data[row][1] = str;
							break;
						case 13:
							column = 0;
							table_data[row][0] = str;
							table_data[row][2] = str;
							break;
						case 14:
							column = 0;
							table_data[row][0] = str;
							table_data[row][3] = str; 
							break;
						case 15:
							column = 0;
							table_data[row][0] = str;
							table_data[row][4] = str; 
							break;
						case 23:
							column = 1;
							table_data[row][1] = str;
							table_data[row][2] = str; 
							break;
						case 24:
							column = 1;
							table_data[row][1] = str;
							table_data[row][3] = str; 
							break;
						case 25:
							column = 1;
							table_data[row][1] = str;
							table_data[row][4] = str; 
							break;
						case 34:
							column = 2;
							table_data[row][2] = str;
							table_data[row][3] = str; 
							break;
						case 35:
							column = 2;
							table_data[row][2] = str;
							table_data[row][4] = str; 
							break;
						case 45:
							column = 3;
							table_data[row][3] = str;
							table_data[row][4] = str; 
							break;
						}
						
						for (int r = row+1; r < erow+1; r++) {
							isRowSpanned[r][column] = true;
							if (table_day >= 10) {
								isRowSpanned[r][table_day%10-1] = true;
							}
						}
					}
				}	
				
				rowspan = 1;
				String bgcolor="#FFFFFF";
				int pass = 0;
				out.println("<tr height=\"20px\">");
				out.println("<td rowspan=\" " + 2 + "\" style=\"background-color: #FFEAEA; font-size:17px;\"><div align=\"center\">" + time[0] + "시" + "</div></td>");
				out.println("</tr>");	
				for (int i = 0; i < 40; i++) {
					out.println("<tr height=\"20px\">");
					if (i%4 == 3)
						out.println("<td rowspan=\" " + 2 + "\" style=\"background-color: #FFEAEA; font-size:17px;\"><div align=\"center\">" + time[(i/4)+1] + "시" +"</div></td>");
					else if ((i%4 == 1) || (i%4 == 2) )
						out.println("<td style=\"background-color: #FFEAEA;\"><div align=\"center\"></div></td>");
					for (int j = 0; j < 5; j++) {
						if (table_data[i][j] != null) {
							if (j == 0)
								bgcolor = "#FFDDDD"; 
							else if (j == 1)
								bgcolor = "#FFE5C2";
							else if (j == 2)
								bgcolor = "#FFFFE4";
							else if (j == 3)
								bgcolor = "#CEFBC9";
							else
								bgcolor = "#D4F4FA";
							for (int k = i+1; k < 40; k++){
								if (isRowSpanned[k][j])
									rowspan++;
								else
									break;
							}
						}
						else {
							table_data[i][j] = "";
						}
						if (!isRowSpanned[i][j]) {
							if (i%4 == 0)
								out.print("<td bgcolor=\" " +bgcolor+ " \" rowspan=\" " + rowspan + "\" style=\"border-top:1px solid Seashell;\"><div align=\"center\">");
							else
								out.print("<td bgcolor=\" " +bgcolor+ " \" rowspan=\" " + rowspan + "\" ><div align=\"center\">");
							out.print(table_data[i][j] + "</div></td>");
						}
						bgcolor = "#FFFFFF";
						rowspan = 1;						
					}
					out.println("</tr>");					
				}
				%>
				</table>
				<%
				cstmt.close();
				cstmt2.close();
				stmt.close();
				myConn.close();
			}
		}
	}
%>
</table>
</body>
</html>
