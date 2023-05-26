<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	//요청값 유효성 검사
	if(request.getParameter("teacherNo") == null 
			|| request.getParameter("teacherNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");
		return;
	}

	//요청값 변수에 저장
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	
	TeacherDao td = new TeacherDao();
	Teacher t = td.selectTeacherOne(teacherNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>selectTeacherOne.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- 메인메뉴 페이지 include -->
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	
	<div class="container">
		<h1>강사 상세보기</h1>
		
		<!--  리다이렉션 메시지 -->
		<div class="bg-warning">
		<%
			if(request.getParameter("msg") != null){
		%>
				<%=request.getParameter("msg")%>
		<%
			}
		%>
		</div>
		
		<!-- 상세보기 -->
		<table class="table">
			<tr>
				<th>번호</th>
				<td>
					<%=t.getTeacherNo()%>
				</td>
			</tr>
			<tr>
				<th>Id</th>
				<td>
					<%=t.getTeacherId() %>
				</td>
			</tr>
			<tr>
				<th>이름</th>
				<td>
					<%=t.getTeacherName() %>
				</td>
			</tr>
			<tr>
				<th>경력</th>
				<td>
					<%=t.getTeacherHistory()%>
				</td>
			</tr>
			<tr>
				<th>작성일</th>
				<td>
					<%=t.getCreatedate()%>
				</td>
			</tr>
			<tr>
				<th>수정일</th>
				<td>
					<%=t.getUpdatedate()%>
				</td>
			</tr>
		</table>
		
		<div>
			<a href="./updateTeacher.jsp?teacherNo=<%=teacherNo%>" style="text-decoration : none;">
				<button type="button" class="btn btn-outline-dark">수정</button>
			</a>
			&nbsp;
			<a href="./deleteTeacherAction.jsp?teacherNo=<%=teacherNo%>" style="text-decoration : none;">
				<button type="button" class="btn btn-outline-dark">삭제</button>
			</a>
		</div>
	</div>
</body>
</html>