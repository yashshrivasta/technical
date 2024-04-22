package com.tech.blog.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
//import java.io.PrintWriter;

import com.tech.blog.dao.UserDao;
import com.tech.blog.entities.Message;
import com.tech.blog.entities.User;
import com.tech.blog.helper.ConnectionProvider;


public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Login() {
        super();
    }
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//PrintWriter out= response.getWriter();
		String userEmail=request.getParameter("email");
		String userPassword=request.getParameter("password");
		
		UserDao dao =new UserDao(ConnectionProvider.getConnection());
		User user=dao.getUserByEmailAndPassword(userEmail, userPassword);
		if(user==null) {
			//out.println("invalid details ! Try Again...");
			Message msg=new Message("Invalid details ! Try Again", "error", "alert-danger");
			HttpSession session=request.getSession();
			session.setAttribute("msg", msg);
			response.sendRedirect("login.jsp");
		}
		else {
			HttpSession s=request.getSession();
			s.setAttribute("currentUser", user);
			response.sendRedirect("profile.jsp");
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
