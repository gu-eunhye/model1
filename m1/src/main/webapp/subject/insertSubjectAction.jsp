<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="vo.*" %>
<%@ page import="dao.*" %>
<%@ page import="java.util.*" %>
<%@ page import = "java.net.*" %>
<%
	//post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");

	//요청값 유효성 검사
	if(request.getParameter("subjectName") == null 
			|| request.getParameter("subjectTime") == null 
			|| request.getParameter("subjectName").equals("")
			|| request.getParameter("subjectTime").equals("")) {
		response.sendRedirect(request.getContextPath()+"/subject/insertSubject.jsp");
		return;
	}
	//요청값 변수에 저장
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	
	SubjectDao sd = new SubjectDao();
	
	Subject subject = new Subject();
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);

	int row = sd.insertSubject(subject);
	String msg = null;
	if(row == 1){
		msg = URLEncoder.encode("과목이 등록되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp?msg="+msg);
		return;
	}
	
	response.sendRedirect(request.getContextPath()+"/subject/subjectList.jsp");
%>