<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<head>
<title>공지사항</title>
</head>
<%@ include file="top.jsp"%>
<%@ include file="dbconfig.jsp"%>
<script language="javascript">
	// 자바 스크립트 시작
	function modifyTest() {
		var form = document.modifybox;
		if (!form.psw.value) {
			alert("비밀번호를 적어주세요");
			form.password.focus();
			return;
		}
		if (!form.title.value) {
			alert("제목을 적어주세요");
			form.title.focus();
			return;
		}
		if (!form.content.value) {
			alert("내용을 적어주세요");
			form.content.focus();
			return;
		}
		form.submit();
	}
</script>


<%
Statement stmt = null;
String name = "";
String password = "";
String title = "";
String content = "";
//String idx=request.getParameter("index");
//if (idx == null) {
//idx = "0";
//}
int index = Integer.parseInt(request.getParameter("index"));
stmt = myConn.createStatement();
String sql = "SELECT n_name, n_pw, n_title, n_cont FROM notice WHERE n_no=" + index;
ResultSet rs = stmt.executeQuery(sql);
if (rs.next()) {
name = rs.getString(1);
password = rs.getString(2);
title = rs.getString(3);
content = rs.getString(4);
}
rs.close();
stmt.close();
myConn.close();
%>
<div id="containerwrap">
	<div id="container">
		<!-- .section_title -->
		<div class="section_title">
			<h1>
				<span>공지사항 수정하기</span>
			</h1>
		</div>
		<!-- /.section_title -->
		<!-- #content -->
		<div id="content" class="myPoint">
			<!-- .pointBox -->
			<center>
				<div class="pointBox">
					<form name="modifybox" method="post"
						action="modify_cf.jsp?index=<%=index%>">
						<table>
							<tr>
								<td>&nbsp;</td>
								<td align="center">제목</td>
								<td><input type="text" name="title" size="150"
									maxlength="50" value="<%=title%>"></td>
								<td>&nbsp;</td>
							</tr>
							<tr height="1" bgcolor="#dddddd">
								<td colspan="4"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td align="center">이름</td>
								<td><%=name%><input type="hidden" name="name" size="150"
									maxlength="50" value="<%=name%>"></td>
								<td>&nbsp;</td>
							</tr>
							<tr height="1" bgcolor="#dddddd">
								<td colspan="4"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td align="center">비밀번호</td>
								<td><input type="password" name="psw" id="pass" size="150"
									maxlength="50"></td>
								<td>&nbsp;</td>
							</tr>
							<tr height="1" bgcolor="#dddddd">
								<td colspan="4"></td>
							</tr>
							<tr>
								<td>&nbsp;</td>
								<td align="center">내용</td>
								<td><textarea name="content" cols="150" rows="15"><%=content%></textarea></td>
								<td>&nbsp;</td>
							</tr>
							<tr height="1" bgcolor="#dddddd">
								<td colspan="4"></td>
							</tr>
							<tr height="1" bgcolor="#82B5DF">
								<td colspan="4"></td>
							</tr>
							<tr align="center">
								<td>&nbsp;</td>
								<td colspan="2"><input type="button" value="수정"
									OnClick="javascript:modifyTest();"> <input
									type="button" value="취소" OnClick="javascript:history.back(-1)">
								<td>&nbsp;</td>
							</tr>
						</table>
					</form>


				</div>
				<br /> <br /> <br />
			</center>
		</div>
	</div>
</div>
