<%@page import="com.tech.blog.dao.LikeDao"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Post"%>
<%@page import="java.util.List"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<div class="row">
<%
User user=(User)session.getAttribute("currentUser");
PostDao pd=new PostDao(ConnectionProvider.getConnection());
int cId=Integer.parseInt(request.getParameter("cid"));
List<Post> list=null;
if(cId==0){
	 list=pd.getAllPosts();
}
else{
	list=pd.getPostByCatId(cId);
}
for(Post p:list){
%>
<div class="col-md-6 mt-2">
	<div class="card">
		 <img class="card-img-top" src="blogpics/<%=p.getpPic() %>" alt="Card image cap">
		<div class="card-body">
			<b><%=p.getpTitle() %></b>
			<p><%=p.getpContent() %></p>
		</div>
		<div class="card-footer">
		<%LikeDao ld=new LikeDao(ConnectionProvider.getConnection()); 
						%>
			<a href="showblog.jsp?post-id=<%=p.getpId() %>" class="btn btn-outline-primary btn-sm" >Read more</a>
			<a href="#" onclick="doLike(<%=p.getpId() %>,<%=user.getId() %>)" class="btn btn-outline-primary btn-sm" >
					<i class="fa fa-thumbs-up"><span class="like-count"><%=ld.countLikeOnPost(p.getpId()) %></span></i></a>
			<a href="#" class="btn btn-outline-primary btn-sm" ><i class="fa fa-comment"><span></span></i></a>
		</div>
	</div>
</div>

<%
}
%>

</div>
