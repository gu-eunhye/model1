<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>

<%
	//요청값 유효성 검사
	if(request.getParameter("subjectNo") == null 
			|| request.getParameter("subjectNo").equals("")){
	response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");
	return;
	}

	//요청값 변수에 저장
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	System.out.println(subjectNo+" <-- subjectNo updateSubject");
	
	SubjectDao sd = new SubjectDao();
	Subject	s = sd.selectSubjectOne(subjectNo);
	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>updateSubject.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- 메인메뉴 페이지 include -->
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col-sm-8">
				<h1>과목 수정</h1>
				
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
				
				<!-- 수정 폼 -->
				<form action="<%=request.getContextPath()%>/subject/updateSubjectAction.jsp" method="post">
					<table class="table">
						<tr>
							<th>번호</th>
							<td>
								<input type="text" name="subjectNo" value="<%=s.getSubjectNo()%>" readonly="readonly" style="border:none"> 
							</td>
						</tr>
						<tr>
							<th>이름</th>
							<td>
								<input type="text" name="subjectName" value="<%=s.getSubjectName()%>"> 
							</td>
						</tr>
						<tr>
							<th>시수</th>
							<td>
								<input type="text" name="subjectTime" value="<%=s.getSubjectTime()%>"> 
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<button type="submit" class="btn btn-outline-dark">수정</button>
							</td>
							<!-- <td></td> -->
						</tr>
					</table>
				</form>
			</div>
		</div>
	</div>
</body>
</html>