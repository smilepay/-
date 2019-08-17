<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<head>
<title>공지사항</title>
</head>
<%@ include file="top.jsp"%>
<%@ include file="dbconfig.jsp"%>
<div id="containerwrap">
	<div id="container">
		<div class="section_title">
			<h1>
				<span>공지사항</span>
			</h1>
		</div>
		<div id="content" class="myPoint">
			<div class="pointBox">
				<%
Statement stmt = null;
int sum = 0;
stmt = myConn.createStatement();
String countQuery = "SELECT COUNT(*) FROM notice";
ResultSet rs = stmt.executeQuery(countQuery);
if (rs.next()) {
sum = rs.getInt(1);
}
rs.close();
out.print("총 게시물 : " + sum + "개");
%>
				<br /> <br />
				<form action="search_list.jsp" method="post">
					<select name="keyFlag">
						<option value="1">교수님성함</option>
						<option value="2">제목</option>
					</select> <input type="text" name="searchT" /> <input type="submit" value="검색" />
				</form>
				<br /> <br />
				<%
String sqlList = "SELECT n_no, n_name, n_title, n_look from notice order by n_no DESC";
rs = stmt.executeQuery(sqlList);
%>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr height="5">
						<td width="5"></td>
					</tr>
					<tr
						style="background: url('image/table_mid.gif') repeat-x; text-align: center;">
						<td width="5" align="left"><img src="image/table_left.gif"
							width="5" height="30" /></td>
						<td width="73">NO.</td>
						<td width="379">제목</td>
						<td width="73">교수님</td>
						<td width="58">조회수</td>
					</tr>
					<%
if (sum == 0) {
%>
					<tr align="center" bgcolor="#FFFFFF" height="30">
						<td colspan="6">등록된 글이 없습니다.</td>
					</tr>
					<%
} else {
while (rs.next()) {
int index = rs.getInt(1);
String name = rs.getString(2);
String title = rs.getString(3);
int hit = rs.getInt(4);
%>
					<tr height="25" align="center">
						<td width="5">&nbsp;</td>
						<td><%=index%></td>
						<td align="left"><a href="view.jsp?index=<%=index%>"><%=title%></td>
						<td align="center"><%=name%></td>
						<td align="center"><%=hit%></td>
						<td>&nbsp;</td>
					</tr>
					<tr height="1" bgcolor="#D2D2D2">
						<td colspan="6"></td>
					</tr>
					<%
}
}
rs.close();
stmt.close();
myConn.close();
%>
					<tr height="1" bgcolor="#82B5DF">
						<td colspan="6" width="752"></td>
					</tr>
				</table>
				<table width="100%" cellpadding="0" cellspacing="0" border="0">
					<tr>
						<td colspan="4" height="5"></td>
					</tr>
					<tr align="center">
						<td><input type=button value="글쓰기"
							OnClick="window.location='write.jsp'"></td>
					</tr>
				</table>
			</div>
		</div>
	</div>
</div>
