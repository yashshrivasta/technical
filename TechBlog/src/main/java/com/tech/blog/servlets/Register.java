package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
//import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

//import org.apache.jasper.tagplugins.jstl.core.If;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;

@MultipartConfig
public class Register extends HttpServlet {
	private static final long serialVersionUID = 1L;
  
    public Register() {
        super();
        
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String check=request.getParameter("check");
		PrintWriter out=response.getWriter();
		if(check==null) {
			out.println("box not checked");
		}
		else {
			String name=request.getParameter("user_name");
			String email=request.getParameter("user_email");
			String password=request.getParameter("user_password");
			String gender=request.getParameter("gender");
			User user=new User(name,email,password,gender);
			
			UserDao dao=new UserDao(ConnectionProvider.getConnection());
			if(dao.saveData(user)) {
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
