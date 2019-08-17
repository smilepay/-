<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<html>
<head>
<title>공지글 검색하기</title>
<style>
#containerwrap {
	margin-bottom: 10em;
}
</style>
</head>
<body>
	<%@ include file="top.jsp"%>
	<%@ include file="dbconfig.jsp"%>
	<div id="containerwrap">
		<div id="container">
			<div class="section_title">
				<h1>
					<span>검색 결과</span>
				</h1>
			</div>
			<div id="content" class="myPoint">
				<%
int affectedRows=0;
request.setCharacterEncoding("utf-8");
String searchT = request.getParameter("searchT");
String keyFlag = request.getParameter("keyFlag");
PreparedStatement pstmt = null;
ResultSet rs = null;
String key = "1";
String sql = null;
if (key.equals(keyFlag)) {
sql = "select * from notice where n_name =? order by n_no DESC";
pstmt = myConn.prepareStatement(sql);
pstmt.setString(1, searchT);
affectedRows=pstmt.executeUpdate(); //총 개수 
} else {
sql = "select * from NOTICE where n_title like ? order by n_no DESC";
pstmt = myConn.prepareStatement(sql);
pstmt.setString(1, "%"+searchT+"%");
affectedRows=pstmt.executeUpdate();
}
rs = pstmt.executeQuery();
String fid = null;
String fpw = null;
%>
				<%
if (rs.next()) {
%>

				<center>
					<div class="pointBox" style="margin-bottom: 100px">
						<table width="100%" cellpadding="0" cellspacing="0" border="0">
							<tr height="5">
								<td width="5"></td>
							</tr>

							<!-- 1행 -->
							<tr
								style="background: url('image/table_mid.gif') repeat-x; text-align: center;">
								<td width="0" align="left"><img src="image/table_left.gif"
									width="5" height="30" /></td>
								<td width="73">번호</td>
								<td width="379">제목</td>
								<td width="73">작성자</td>
								<td width="58">조회수</td>
								<td width="7"><img src="image/table_right.gif" width="5"
									height="30" /></td>
							</tr>
							<!-- col:3으로 고정 -->
							<!-- 2행 -->
							<%
   for(int j=0; j<affectedRows; j++){
   String idx = rs.getString("n_no");
   int index = Integer.parseInt(idx);
   String name =rs.getString("n_name");
   String title = rs.getString("n_title");
   //String hitt = rs.getString("n_look");
   int hit = rs.getInt("n_look");
   rs.next();
   %>
							<tr height="25" align="center">
								<td width="5" align="left">&nbsp;</td>
								<td align="center" width="73"><%=index%></td>
								<td align="center" width="379"><a
									href="view.jsp?index=<%=index%>"><%=title%> </a></td>
								<td align="center" width="73"><%=name%></td>
								<td align="center" width="7"><%=hit%></td>
								<td>&nbsp;</td>
							</tr>
							<%
}
%>
							<!-- 마지막행 -->
							<tr height="1" bgcolor="#D2D2D2">
								<td colspan="6"></td>
							</tr>
							<tr height="1" bgcolor="#82B5DF">
								<td colspan="6" width="752"></td>
							</tr>
						</table>
						<%}
else{%><!-- .pointBox -->
						<center>

							<div class="pointBox">
								<table class=table4_1>
									<tr align="center">
										<h1>검색결과 없음</h1>
									</tr>
								</table>
								<%
}//endif
pstmt.close();
myConn.close();
%>
							</div>
						</center>
					</div>
				</center>
			</div>