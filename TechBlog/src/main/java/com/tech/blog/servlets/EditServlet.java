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
//import java.io.PrintWriter;


import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;
import com.tech.blog.helper.Helper;

@MultipartConfig
public class EditServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public EditServlet() {
        super();
        
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		//PrintWriter out=response.getWriter();
		String username=request.getParameter("user_name");
		String email=request.getParameter("user_email");
		String password=request.getParameter("user_password");
		Part part=request.getPart("image");
		String imageName=part.getSubmittedFileName();
		
		HttpSession s=request.getSession();
		User user=(User)s.getAttribute("currentUser");
		user.setEmail(email);
		user.setPassword(password);
		user.setName(username);
		String oldProfile=user.getProfile();
		if(imageName!="") {
			user.setProfile(imageName);
		}
		UserDao dao=new UserDao(ConnectionProvider.getConnection());
		if(dao.updateUser(user)) {
			
			ServletContext sc=getServletContext();

			String path=sc.getRealPath("/")+"pics"+File.separator+user.getProfile();
			String pathOldFile=sc.getRealPath("/")+"pics"+File.separator+oldProfile;
			if(imageName!="") {
				if(!oldProfile.equals("default.png")) {
					Helper.deleteFile(pathOldFile) ;
				}
				Helper.saveFile(part.getInputStream(), path);
			}	
			Message msg=new Message("Profile updated successfully", "success", "alert-success");
			s.setAttribute("msg", msg);
		}		
		else {
			
			Message msg=new Message("Something went wrong", "error", "alert-error");
			s.setAttribute("msg", msg);
			
		}
		response.sendRedirect("profile.jsp");
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
