package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;



public class LikeDao {
	Connection conn;

	public LikeDao(Connection conn) {
		super();
		this.conn = conn;
	}
	public boolean insertLike(int pId,int uId) {
		boolean f=false;
		try {
			String query="insert into liked(postid,userid) values(?,?)";
			PreparedStatement pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, pId);
			pstmt.setInt(2, uId);
			pstmt.executeUpdate();
			f=true;
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public int countLikeOnPost(int pId) {
		int count=0;
		try {
			String query="select count(*) from liked where postid=?";
			PreparedStatement pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, pId);
			ResultSet rs= pstmt.executeQuery();
			if(rs.next()) {
				count=rs.getInt("count(*)");
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return count;
	}
	public boolean isLikedByUser(int postid,int userid) {
		boolean f=false;
		try {
			String query ="select * from liked where postid=? and userid=?"; 
			PreparedStatement pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, postid);
			pstmt.setInt(2, userid);
			ResultSet rs= pstmt.executeQuery();
			if(rs.next()) {
				f=true;
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public boolean deleteLike(int postid,int userid) {
		boolean f=false;
		try {
			String query ="delete from liked where postid=? and userid=?"; 
			PreparedStatement pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, postid);
			pstmt.setInt(2, userid);
			pstmt.executeUpdate();
			f=true;			
			
		}catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
}
