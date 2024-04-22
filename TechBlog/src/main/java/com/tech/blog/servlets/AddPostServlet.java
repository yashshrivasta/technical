package com.tech.blog.servlets;

import jakarta.servlet.ServletContext;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
//import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.PostDao;
import com.tech.blog.entities.Post;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

@MultipartConfig
public class AddPostServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public AddPostServlet() {
        super();
    }

	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		int cId=Integer.parseInt(request.getParameter("cid"));
		String pTitle=request.getParameter("pTitle");
		String pContent=request.getParameter("pContent");
		String pCode=request.getParameter("pCode");
		Part part=request.getPart("pPic");
		String imageName=part.getSubmittedFileName();
		HttpSession session=request.getSession();
		User user=(User)session.getAttribute("currentUser");
		Post post=null;
		PostDao pd=new PostDao(ConnectionProvider.getConnection());
		if(imageName!="") {
			post=new Post(pTitle, pContent, pCode, imageName, null, cId,user.getId());
			if(pd.savePost(post)) {
				out.println("Done");
				ServletContext sc=getServletContext();
				String path=sc.getRealPath("/")+"blogpics"+File.separator+imageName;
				Helper.saveFile(part.getInputStream(), path);
			}
			else {
				out.println("error");
			}
		}
		else {
			post=new Post(pTitle, pContent, pCode,"defaultblog.png", null, cId, user.getId());
			if(pd.savePost(post)) {
				out.println("Done");
			}
			else {
				out.println("error");
			}
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
