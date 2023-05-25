<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%@ page import="java.util.*" %>
<%
	int currentPage = 1; //시작 페이지
	if(request.getParameter("currentPage") != null) {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
	}
	int rowPerPage =10; //한페이지에 출력할 게시물 수
	int beginRow = (currentPage -1)*rowPerPage; //한페이지에 출력될 첫번째 행 번호
	
	SubjectDao sd = new SubjectDao();
	ArrayList<Subject> list = sd.selectSubjectListByPage(beginRow, rowPerPage);
	
	int totalRow = sd.selectSubjectCnt(); //전체 행 수
	int lastPage = totalRow / rowPerPage; //마지막페이지
	if(totalRow % rowPerPage != 0){
		lastPage = lastPage + 1;
	}
	if(totalRow < currentPage){
		currentPage = lastPage;
	}
	
	int pagePerPage = 5; //한번에 출력될 페이징 버튼 수
	int startPage = ((currentPage - 1) / pagePerPage) * pagePerPage + 1; //페이징 버튼 시작 값
	int endPage = startPage + pagePerPage - 1; //페이징 버튼 종료 값
	if(endPage > lastPage){
		endPage = lastPage;
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>subjectList.jsp</title>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/css/bootstrap.min.css">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.2/dist/js/bootstrap.bundle.min.js"></script>
<style>
.page_wrap {
	text-align:center;
	font-size:0;
 }
.page_nation {
	display:inline-block;
}
.page_nation .none {
	display:none;
}
.page_nation a {
	display:block;
	margin:0 3px;
	float:left;
	border:1px solid #e6e6e6;
	width:28px;
	height:28px;
	line-height:28px;
	text-align:center;
	background-color:#fff;
	font-size:13px;
	color:#999999;
	text-decoration:none;
}
.page_nation .arrow {
	border:1px solid #ccc;
}
.page_nation .prev {
	background:#f8f8f8 url('img/page_prev.png') no-repeat center center;
	margin-right:7px;
}
.page_nation .next {
	background:#f8f8f8 url('img/page_next.png') no-repeat center center;
	margin-left:7px;
}
.page_nation a.active {
	background-color:#42454c;
	color:#fff;
	border:1px solid #42454c;
}
</style>
</head>
<body>
	<!-- 메인메뉴 페이지 include -->
	<div>
		<jsp:include page="/inc/mainmenu.jsp"></jsp:include>
	</div>
	
	<div class="container">
		<div class="row">
			<div class="col-sm-6">
				<h1>과목 목록</h1>
			</div>
		
			<div class="text-right col-sm-6">
				<a href="<%=request.getContextPath()%>/subject/insertSubject.jsp" style="text-decoration : none;">
					<button type="button" class="btn btn-outline-dark">과목 등록</button>
				</a>
			</div>
		</div>
		
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
		
		<!-- subject list  -->
		<table class="table text-center">
			<tr>
				<th>번호</th>
				<th>이름</th>
				<th>시수</th>
				<th>작성일</th>
				<th>수정일</th>
			</tr>
			<%
					for(Subject s : list) {
				%>
						<tr>
							<td><%=s.getSubjectNo()%></td>
							<td>
								<a href="<%=request.getContextPath()%>/subject/selectSubjectOne.jsp?subjectNo=<%=s.getSubjectNo()%>">
									<%=s.getSubjectName() %>
								</a>
							</td>
							<td><%=s.getSubjectTime()%></td>
							<td><%=s.getCreatedate()%></td>
							<td><%=s.getUpdatedate()%></td>
						</tr>
				<%
					}
				%>
		</table>
		
		<!-- subject list 페이징 -->
		<div class="page_wrap">
   			<div class="page_nation">
			<%
				//이전 페이지 버튼
				if(startPage >1){
			%>
    				<a class="arrow prev" href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=startPage-pagePerPage %>">
    					이전 
    				</a>
	    	<%
				}
		        for(int i = startPage; i <= endPage; i++){
		        	if(i==currentPage){ //활성화된 현재 페이지버튼
		    %>
	        			<a class="active" href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=i %>">
	        				<%=i %>
	        			</a>
		    <%
		        	}else{ 
	    	%>
	        			<a href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=i %>">
	        				<%=i %>
	        			</a>
	        <%
	        		}
		        }
		    	//다음 페이지 버튼
		    	if(endPage != lastPage){
	        %>
					<a class="arrow next" href="<%=request.getContextPath()%>/subject/subjectList.jsp?currentPage=<%=startPage+pagePerPage %>">
						다음
					</a>
			<%
				}
			%>
			</div>
		</div>	
	</div>
</body>
</html>