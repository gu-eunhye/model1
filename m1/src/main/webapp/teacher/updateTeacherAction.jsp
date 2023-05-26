<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="dao.*" %>
<%@ page import="vo.*" %>
<%
	//post방식 요청값 인코딩하기
	request.setCharacterEncoding("utf-8");

	//요청값 유효성 검사
	if(request.getParameter("teacherNo") == null 
			|| request.getParameter("teacherNo").equals("")){
		response.sendRedirect(request.getContextPath()+"/teacher/teacherList.jsp");
		return;
	}

	//요청값 변수에 저장
	int teacherNo = Integer.parseInt(request.getParameter("teacherNo"));
	System.out.println(teacherNo);
	
	// 요청값 유효성 검사
	String msg = null;
	if(request.getParameter("teacherId") == null 
			|| request.getParameter("teacherName") == null
			|| request.getParameter("teacherHistory") == null
			|| request.getParameter("teacherId").equals("")
			|| request.getParameter("teacherName").equals("")
			|| request.getParameter("teacherHistory").equals("")) {
		msg = URLEncoder.encode("정보를 입력해주세요","utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/updateTeacher.jsp?teacherNo="+teacherNo+"&msg="+msg);
		return;
	}
	//요청값 변수에 저장
	String teacherId = request.getParameter("teacherId");
	String teacherName = request.getParameter("teacherName");
	String teacherHistory = request.getParameter("teacherHistory");
	System.out.println(teacherId + " <-- teacherId updateTeacherAction");
	System.out.println(teacherName +" <-- teacherName updateTeacherAction");
	System.out.println(teacherHistory +" <-- teacherHistory updateTeacherAction");
	
	TeacherDao td = new TeacherDao();

	Teacher teacher = new Teacher();
	teacher.setTeacherNo(teacherNo);
	teacher.setTeacherId(teacherId);
	teacher.setTeacherName(teacherName);
	teacher.setTeacherHistory(teacherHistory);
	
	int row = td.updateTeacher(teacher);
	System.out.println(row +" <-- row updateTeacherAction");
	if(row == 1){
		msg = URLEncoder.encode("강사정보가 수정되었습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/selectTeacherOne.jsp?teacherNo="+teacherNo+"&msg="+msg);
		return;
	}else{
		msg = URLEncoder.encode("강사정보 수정에 실패하였습니다","utf-8");
		response.sendRedirect(request.getContextPath()+"/teacher/selectTeacherOne.jsp?teacherNo="+teacherNo+"&msg="+msg);	
	}
%>
