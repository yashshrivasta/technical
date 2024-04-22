package com.tech.blog.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;

import com.tech.blog.entities.Categories;
import com.tech.blog.entities.Post;

public class PostDao {
	private Connection conn;

	public PostDao(Connection conn) {
		super();
		this.conn = conn;
	}
	public ArrayList<Categories> getAllCategories(){
		ArrayList<Categories> list=new ArrayList<>();
		try {
			String query="select * from categories";
			Statement st=this.conn.createStatement();
			ResultSet rs=st.executeQuery(query);
			while(rs.next()) {
				int cId=rs.getInt("cId");
				String cName=rs.getString("cName");
				String cDiscription=rs.getString("cDiscription");
				Categories cat=new Categories(cId, cName, cDiscription);
				list.add(cat);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public boolean savePost(Post post) {
		boolean f=false;
		try {
			String query="insert into posts(pTitle,pContent,pCode,pPic,cId,uId) values(?,?,?,?,?,?)";
			PreparedStatement pstmt=conn.prepareStatement(query);
			pstmt.setString(1, post.getpTitle());
			pstmt.setString(2, post.getpContent());
			pstmt.setString(3, post.getpCode());
			pstmt.setString(4, post.getpPic());
			pstmt.setInt(5, post.getcId());
			pstmt.setInt(6, post.getuId());
			pstmt.executeUpdate();
			f=true;
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return f;
	}
	public List<Post> getAllPosts(){
		List<Post> list=new ArrayList<>();
		try {
			String query="select * from posts order by pDate desc";
			PreparedStatement pstmt=conn.prepareStatement(query);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				int pId=rs.getInt("pId");
				String pTitle=rs.getString("pTitle");
				String pContent=rs.getString("pContent");
				String pCode=rs.getString("pCode");
				String pPic=rs.getString("pPic");
				Timestamp pDate=rs.getTimestamp("pDate");
				int cId=rs.getInt("cId");
				int uId=rs.getInt("uId");
				Post post=new Post(pId,pTitle, pContent, pCode, pPic, pDate, cId, uId);
				list.add(post);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	public List<Post> getPostByCatId(int cId){
		List<Post> list=new ArrayList<>();
		try {
			String query="select * from posts where cId=?";
			PreparedStatement pstmt=conn.prepareStatement(query);
			pstmt.setInt(1, cId);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				int pId=rs.getInt("pId");
				String pTitle=rs.getString("pTitle");
				String pContent=rs.getString("pContent");
				String pCode=rs.getString("pCode");
				String pPic=rs.getString("pPic");
				Timestamp pDate=rs.getTimestamp("pDate");
				int uId=rs.getInt("uId");
				Post post=new Post(pId,pTitle, pContent, pCode, pPic, pDate, cId, uId);
				list.add(post);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	public Post getPostByPostId(int postId) {
		Post post=null;
		try {
			String query="select * from posts where pId=?";
			PreparedStatement pstmt=conn.prepareStatement(query);
			pstmt.setInt(1,postId);
			ResultSet rs=pstmt.executeQuery();
			while(rs.next()) {
				int pId=rs.getInt("pId");
				String pTitle=rs.getString("pTitle");
				String pContent=rs.getString("pContent");
				String pCode=rs.getString("pCode");
				String pPic=rs.getString("pPic");
				Timestamp pDate=rs.getTimestamp("pDate");
				int cId=rs.getInt("cId");
				int uId=rs.getInt("uId");
				post=new Post(pId,pTitle, pContent, pCode, pPic, pDate, cId, uId);
				
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return post;
	}
}
