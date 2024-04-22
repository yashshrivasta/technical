package com.tech.blog.servlets;

import jakarta.servlet.ServletException;

import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

import com.tech.blog.dao.LikeDao;
import com.tech.blog.helper.ConnectionProvider;

public class LikeServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    
    public LikeServlet() {
        super();
        
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		PrintWriter out=response.getWriter();
		String operation=request.getParameter("operation");
		int uId=Integer.parseInt(request.getParameter("uId"));
		int pId=Integer.parseInt(request.getParameter("pId"));
		LikeDao ldao=new LikeDao(ConnectionProvider.getConnection());
		if(operation.equals("like")) {
			boolean f=ldao.insertLike(pId, uId);
			out.println(f);
		}
	}

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
