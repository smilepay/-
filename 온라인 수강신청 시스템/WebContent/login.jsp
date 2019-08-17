<%@ page language="java" contentType="text/html; charset=UTF-8"
   pageEncoding="UTF-8"%>
<head>
<link rel="stylesheet" href="css/style.css" />
<link rel="stylesheet" href="css/layout.css" />
</head>
<%@ include file="top.jsp"%>

<div id="containerwrap">
   <div id="container">
      <br> <br> <br>
         <div id="content" class="login" align="center">
            <div class="login_box">
               <form method="post" action="login_verify.jsp">
                     <br />
                     
                        <div align="center">
                           <table class="inputTable">
                              <tbody>
                              
                              <tr align ="center">
                              <input type="radio" name="mode" id="stu_mode" value="student" checked="checked">Student
							  <input type="radio" name="mode" id="pf_mode" value="professor">Professor
							  </tr>
							  
                              <tr>
							  <td><div align="center">아이디
							  <input type="text" name="userID">
							  </div></td>
							  </tr>
							  
                             <tr>
							 <td><div align="center">패스워드
						     <input type="password" name="userPassword">
							 </div></td>
							 </tr>

                             <br>
                                 
							<tr>
							<td colspan=2><div align="center">
							<INPUT TYPE="SUBMIT" NAME="Submit" VALUE="로그인"> <INPUT TYPE="RESET" VALUE="취소">
							</div></td>
							</tr>
							
                              </tbody>
                           </table>

                        </div>
               </form>
            </div>
         </div>
   </div>
</div>
</div>