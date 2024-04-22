package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import com.tech.blog.entities.User;

public class UserDao {
	private Connection conn;

	public UserDao(Connection conn) {
		super();
		this.conn = conn;
	}

	public boolean saveData(User user) {
		boolean b=false;
		try {
			
			String query="insert into user(name,email,password,gender) values(?,?,?,?)";
			PreparedStatement pstmt=this.conn.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getGender());
			pstmt.executeUpdate();
			b=true;
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return b;
	}
	public User getUserByEmailAndPassword(String email,String password) {
		User user=null;
		try {
			String query="Select * from user where email=? and password=?";
			PreparedStatement pstmt=conn.prepareStatement(query);
			pstmt.setString(1, email);
			pstmt.setString(2, password);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				user=new User();
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setId(rs.getInt("id"));
				user.setGender(rs.getString("gender"));
				user.setPassword(rs.getString("password"));
				user.setProfile(rs.getString("profile"));
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return user;
	}
	public boolean updateUser(User user) {
		boolean f=false;
		try {
			String query="update user set name=?, email=?, password=?, profile=? where id=?";
			PreparedStatement pstmt=conn.prepareStatement(query);
			pstmt.setString(1, user.getName());
			pstmt.setString(2, user.getEmail());
			pstmt.setString(3, user.getPassword());
			pstmt.setString(4, user.getProfile());
			pstmt.setInt(5, user.getId());
			pstmt.executeUpdate();
			f=true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public User getUserByUserId(int uId) {
		User user=null;
		try {
			String query="Select * from user where id=?";
			PreparedStatement pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, uId);
			ResultSet rs=pstmt.executeQuery();
			if(rs.next()) {
				user=new User();
				user.setName(rs.getString("name"));
				user.setEmail(rs.getString("email"));
				user.setId(rs.getInt("id"));
				user.setGender(rs.getString("gender"));
				user.setPassword(rs.getString("password"));
				user.setProfile(rs.getString("profile"));
			}
		}
		catch (Exception e) {
			// TODO: handle exception
		}
		return user;
	}
}
