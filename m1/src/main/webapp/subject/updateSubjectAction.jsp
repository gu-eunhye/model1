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
	//요청값 변수에 저장
	int subjectNo = Integer.parseInt(request.getParameter("subjectNo"));
	
	// 요청값 유효성 검사
	String msg = null;
	if(request.getParameter("subjectName") == null 
			|| request.getParameter("subjectTime") == null 
			|| request.getParameter("subjectName").equals("")
			|| request.getParameter("subjectTime").equals("")) {
		msg = URLEncoder.encode("정보를 입력해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/updateSubject.jsp?subjectNo="+subjectNo+"&msg="+msg);
		return;
	}
	//요청값 변수에 저장
	String subjectName = request.getParameter("subjectName");
	int subjectTime = Integer.parseInt(request.getParameter("subjectTime"));
	
	SubjectDao sd = new SubjectDao();

	Subject subject = new Subject();
	subject.setSubjectNo(subjectNo);
	subject.setSubjectName(subjectName);
	subject.setSubjectTime(subjectTime);

	int row = sd.updateSubject(subject);
	if(row == 1){
		msg = URLEncoder.encode("과목이 수정되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/subject/selectSubjectOne.jsp?subjectNo="+subjectNo+"&msg="+msg);
		return;
	}else{
		msg = URLEncoder.encode("과목 수정에 실패하였습니다","utf-8");
		response.sendRedirect(request.getContextPath() + "/subject/selectSubjectOne.jsp?subjectNo="+subjectNo+"&msg="+msg);	
	}
%>