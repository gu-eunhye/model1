<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insertSubject.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
	<!-- 메인메뉴 페이지 include -->
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	
	<!-- 과목등록 폼  -->
	<div class="container">
	<div class="row">
		<div class="col-sm-8">
			<h1>과목 등록</h1>
			<form action="<%=request.getContextPath()%>/subject/insertSubjectAction.jsp" method="post">
				<table class="table">
					<tr>
						<th>이름</th>
						<td>
							<input type="text" name="subjectName"> 
						</td>
					</tr>
					<tr>
						<th>시수</th>
						<td>
							<input type="text" name="subjectTime" > 
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<button type="submit" class="btn btn-outline-dark">등록</button>
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