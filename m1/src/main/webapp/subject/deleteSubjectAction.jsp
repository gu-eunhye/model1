<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%
	//post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");

	//요청값 유효성 검사
	if(request.getParameter("subjectNo") == null  
			|| request.getParameter("subjectNo").equals("")) {
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");
		return;
	}
	// 요청값 변수에 저장
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	
	SubjectDao sDao = new SubjectDao();
	
	int row = sDao.deleteSubject(subjectNo);
	String msg = null;
	if(row == 1){
		msg = URLEncoder.encode("과목이 삭제되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
		return;
	}
	response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");
%>