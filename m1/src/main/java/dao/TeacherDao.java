package dao;

import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.*;

public class TeacherDao {
	//1) 강사 목록
	/*
		SELECT t.teacher_no teacherNo, t.teacher_id teacherId, t.teacher_name teacherName, 
			nvl(GROUP_CONCAT(CAST(ts.subject_no AS CHAR) SEPARATOR' , '),' ') subjectNo,
			nvl(GROUP_CONCAT(s.subject_name SEPARATOR' , '), ' ') subjectName 
		FROM teacher t LEFT OUTER JOIN teacher_subject ts 
							ON t.teacher_no = ts.teacher_no 
								LEFT OUTER JOIN subject s 
								ON ts.subject_no = s.subject_no
		GROUP BY t.teacher_no, t.teacher_id, t.teacher_name 
		LIMIT ?, ?
	 */
	
	public ArrayList<HashMap<String, Object>> selectTeacherListByPage(int beginRow, int rowPerPage) throws Exception{
		ArrayList<HashMap<String, Object>> list = new ArrayList<>();
		//교과목이 연결되지 않은 강사도 나와야 함 leftjoin
		//teacherList.jsp + 화면캡쳐 + teacher샘플데이터 추가
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT t.teacher_no teacherNo, t.teacher_id teacherId, t.teacher_name teacherName, nvl(GROUP_CONCAT(CAST(ts.subject_no AS CHAR) SEPARATOR' , '),' ') subjectNo, nvl(GROUP_CONCAT(s.subject_name SEPARATOR' , '), ' ') subjectName FROM teacher t LEFT OUTER JOIN teacher_subject ts ON t.teacher_no = ts.teacher_no LEFT OUTER JOIN subject s ON ts.subject_no = s.subject_no GROUP BY t.teacher_no, t.teacher_id, t.teacher_name LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			HashMap<String, Object> m = new HashMap<>(); 
			m.put("teacherNo", rs.getInt("teacherNo"));
			m.put("teacherId", rs.getString("teacherId"));
			m.put("teacherName", rs.getString("teacherName"));
			m.put("subjectNo", rs.getString("subjectNo"));
			m.put("subjectName", rs.getString("subjectName"));
			list.add(m);
		}
		return list;
	}
	
	//2) 강사 전체 row 수
	public int selectTeacherCnt() throws Exception {
		int row = 0; //반환타입을 젤위에 선언
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT COUNT(*) FROM teacher";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		return row;
	}
	
	//3) 강사 1명 상세보기, 수정폼
	public Teacher selectTeacherOne(int teacherNo) throws Exception {
		Teacher teacher = null;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT teacher_no teacherNo, teacher_id teacherId, teacher_name teacherName, teacher_history teacherHistory, updatedate, createdate FROM teacher WHERE teacher_no =?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, teacherNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			teacher = new Teacher();
			teacher.setTeacherNo(rs.getInt("teacherNo"));
			teacher.setTeacherId(rs.getString("teacherId"));
			teacher.setTeacherName(rs.getString("teacherName"));
			teacher.setTeacherHistory(rs.getString("teacherHistory"));
			teacher.setCreatedate(rs.getString("createdate"));
			teacher.setUpdatedate(rs.getString("updatedate"));
		}
		return teacher;
	}
	//4) 수정액션
	public int updateTeacher(Teacher teacher) throws Exception {
		int row = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "UPDATE teacher SET teacher_id = ?, teacher_name = ?,teacher_history=?, updatedate = now() WHERE teacher_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, teacher.getTeacherId());
		stmt.setString(2, teacher.getTeacherName() );
		stmt.setString(3, teacher.getTeacherHistory());
		stmt.setInt(4, teacher.getTeacherNo());
		row = stmt.executeUpdate();
		
		return row;
	}
			
	//5) 삭제액션
	public int deleteTeacher(int teacherNo) throws Exception {
		int row = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "DELETE FROM teacher WHERE teacher_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, teacherNo);
		row = stmt.executeUpdate();
			
		return row;
	}
	

}
