<%@ page contentType="text/html; charset=UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.util.Date"%>
<html>
<head>
<title>게시판</title>
</head>
<body>
   <%@ include file="top.jsp"%>
   <%@ include file="dbconfig.jsp"%>
   <%
      if (session_id == null) {
   %>
   <script>
      alert("로그인이 필요합니다.");
      location.href = "login.jsp";
   </script>
   <%
      } else {
         Statement stmt = null;
         stmt = myConn.createStatement();
         String idx=request.getParameter("index");
         int index = Integer.parseInt(idx.trim());
         String sql = "SELECT n_name, n_title, n_cont, n_look FROM notice WHERE n_no="+index;
         ResultSet rs = stmt.executeQuery(sql);
         if (rs.next()) {
            String name = rs.getString(1);
            String title = rs.getString(2);
            String incontent = rs.getString(3);
            int look = rs.getInt(4);
            look++;
         
   %>
   <div id="containerwrap">
      <div id="container">
         <div class="section_title">
            <h1>
               <span>공지글보기</span>
            </h1>
         </div>
         <div id="content" class="myPoint">
            <center>
               <div class="pointBox">
                  <table>
                     <tr>
                        <td>
                           <table width="100%" cellpadding="0" cellspacing="0" border="0">
                              <tr
                                 style="background: url('image/table_mid.gif') repeat-x; text-align: center;">
                                 <td width="5"><img src="image/table_left.gif" width="5"
                                    height="30" /></td>
                                 <td>내 용</td>
                                 <td width="5"><img src="image/table_right.gif" width="5"
                                    height="30" /></td>
                              </tr>
                           </table>
                           <table width="1000">
                              <tr>
                                 <td width="0">&nbsp;</td>
                                 <td align="center" width="76">글번호</td>
                                 <td width="1000"><%=index%></td>
                                 <td width="0">&nbsp;</td>
                              </tr>
                              <tr height="1" bgcolor="#dddddd">
                                 <td colspan="4" width="407"></td>
                              </tr>
                              <tr>
                                 <td width="0">&nbsp;</td>
                                 <td align="center" width="76">조회수</td>
                                 <td width="1000"><%=look%></td>
                                 <td width="0">&nbsp;</td>
                              </tr>
                              <tr height="1" bgcolor="#dddddd">
                                 <td colspan="4" width="407"></td>
                              </tr>
                              <tr>
                                 <td width="0">&nbsp;</td>
                                 <td align="center" width="76">이름</td>
                                 <td width="1000"><%=name%></td>
                                 <td width="0">&nbsp;</td>
                              </tr>
                              <tr height="1" bgcolor="#dddddd">
                                 <td colspan="4" width="407"></td>
                              </tr>
                              <tr>
                                 <td width="0">&nbsp;</td>
                                 <td align="center" width="76">제목</td>
                                 <td width="1000"><%=title%></td>
                                 <td width="0">&nbsp;</td>
                              </tr>
                              <tr height="1" bgcolor="#dddddd">
                                 <td colspan="4" width="1500"></td>
                              </tr>
                              <tr>
                                 <td width="0"></td>
                                 <td width="1000" colspan="2" height="200"><%=incontent%>
                              </tr>
                              <%
                                 sql = "UPDATE notice SET n_look=" + look + " where n_no=" + index;
                                       stmt.executeUpdate(sql);
                                    }
                              %>
                              <tr height="1" bgcolor="#dddddd">
                                 <td colspan="4" width="407"></td>
                              </tr>
                              <tr height="1" bgcolor="#82B5DF">
                                 <td colspan="4" width="407"></td>
                              </tr>
                              <tr align="center">
                                 <td width="0">&nbsp;</td>
                                 <td colspan="2" width="1500">
                                 <input type=button value="글쓰기" OnClick="window.location='write.jsp'">
                                  <input type=button value="목록" OnClick="window.location='list.jsp'">
                                  <% 
                                 String name="";
                                 String mySQL = "select s_id from students where s_id=" + session_id;
                                 stmt = null;
                                 stmt = myConn.createStatement();
                                 int res = stmt.executeUpdate(mySQL);
                                 if (res != 0) {
                                 %>
                                 <% 
                                 }else{
                                    %>
                                    
                                    <input type=button value="수정" OnClick="window.location='modify.jsp?index=<%=index%>'">
                                    <input type=button value="삭제" OnClick="window.location='deleteboard.jsp?index=<%=index%>'">
                                    <% 
                                    }
                                    %>

                                 <td width="0">&nbsp;</td>
                              </tr>
                           </table>
                           <div>
                              <br /> <br />
                           </div>
                        </td>
                     </tr>
                  
                     <br />
                     <br />
            
                  </table>
               </div>
            </center>
         </div>
      </div>
   </div>
   <%
      rs.close();
         stmt.close();
         myConn.close();
      }
   %>
