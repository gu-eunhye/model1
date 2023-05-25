package dao;

import java.sql.*;
import java.util.*;
import util.DBUtil;
import vo.*;

public class SubjectDao {
	//1) 과목 목록
	public ArrayList<Subject> selectSubjectListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Subject> list = new ArrayList<>();
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT subject_no subjectNo, subject_name subjectName, subject_time subjectTime, updatedate, createdate FROM subject LIMIT ?,?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, beginRow);
		stmt.setInt(2, rowPerPage);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			Subject s = new Subject();
			s.setSubjectNo(rs.getInt("subjectNo"));
			s.setSubjectName(rs.getString("subjectName"));
			s.setSubjectTime(rs.getInt("subjectTime"));
			s.setCreatedate(rs.getString("createdate"));
			s.setUpdatedate(rs.getString("updatedate"));
			list.add(s);
		}
		return list;	
	}
	
	//2) 과목 추가
	public int insertSubject(Subject subject) throws Exception {
		int row = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "INSERT INTO subject (subject_no, subject_name, subject_time, updatedate, createdate) VALUES(?,?,?,now(),now())";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, subject.getSubjectNo());
		stmt.setString(2, subject.getSubjectName());
		stmt.setInt(3, subject.getSubjectTime());
		row = stmt.executeUpdate();
		//subject.get...
		
		return row;
	}
	
	//3) 과목 삭제
	public int deleteSubject(int subjectNo) throws Exception {
		int row = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "DELETE FROM subject WHERE subject_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, subjectNo);
		row = stmt.executeUpdate();
		
		return row;
	}
	
	//4) 과목 수정
	public int updateSubject(Subject subject) throws Exception {
		int row = 0;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "UPDATE subject SET subject_name = ?, subject_time = ?, updatedate = now() WHERE subject_no = ?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setString(1, subject.getSubjectName());
		stmt.setInt(2, subject.getSubjectTime());
		stmt.setInt(3, subject.getSubjectNo());
		row = stmt.executeUpdate();
		
		return row;
	}
	
	//5) 과목 하나 상세
	public Subject selectSubjectOne(int subjectNo) throws Exception {
		Subject subject = null;
		
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT subject_no subjectNo, subject_name subjectName, subject_time subjectTime, updatedate, createdate FROM subject WHERE subject_no=?";
		PreparedStatement stmt = conn.prepareStatement(sql);
		stmt.setInt(1, subjectNo);
		ResultSet rs = stmt.executeQuery();
		while(rs.next()) {
			subject = new Subject();
			subject.setSubjectNo(rs.getInt("subjectNo"));
			subject.setSubjectName(rs.getString("subjectName"));
			subject.setSubjectTime(rs.getInt("subjectTime"));
			subject.setCreatedate(rs.getString("createdate"));
			subject.setUpdatedate(rs.getString("updatedate"));
		}
		return subject;
	}
	
	//6) 과목 전체 row 수
	public int selectSubjectCnt() throws Exception {
		int row = 0; //반환타입을 젤위에 선언
		DBUtil dbutil = new DBUtil();
		Connection conn = dbutil.getConnection();
		String sql = "SELECT COUNT(*) FROM subject";
		PreparedStatement stmt = conn.prepareStatement(sql);
		ResultSet rs = stmt.executeQuery();
		if(rs.next()) {
			row = rs.getInt(1);
		}
		return row;
	}
}
