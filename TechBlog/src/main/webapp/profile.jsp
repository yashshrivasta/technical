<%@page import="com.tech.blog.entities.Categories"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.tech.blog.helper.ConnectionProvider"%>
<%@page import="com.tech.blog.dao.PostDao"%>
<%@page errorPage="error_page.jsp"%>
<%@page import="com.tech.blog.entities.User"%>
<%@page import="com.tech.blog.entities.Message"%>
<%
User user = (User) session.getAttribute("currentUser");
if (user == null) {
	response.sendRedirect("login.jsp");
}
%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="css/mystyles.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<title>Insert title here</title>

<body>

	<div class="navB">
		<nav class="navbar navbar-expand-lg navbar-dark primary-background">
			<div class="container-fluid">
				<a class="navbar-brand" href="index.jsp"><span
					class="fa fa-anchor"></span> Tech Blog</a>
				<button class="navbar-toggler" type="button"
					data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent"
					aria-controls="navbarSupportedContent" aria-expanded="false"
					aria-label="Toggle navigation">
					<span class="navbar-toggler-icon"></span>
				</button>
				<div class="collapse navbar-collapse" id="navbarSupportedContent">
					<ul class="navbar-nav me-auto mb-2 mb-lg-0">
						<li class="nav-item"><a class="nav-link active"
							aria-current="page" href="#"><span class="fa fa-keyboard-o"></span>
								Learn Programming</a></li>

						<li class="nav-item dropdown"><a
							class="nav-link dropdown-toggle active" href="#" role="button"
							data-bs-toggle="dropdown" aria-expanded="false"> <span
								class="fa fa-edit"></span> Categories
						</a>
							<ul class="dropdown-menu">
								<li><a class="dropdown-item" href="#">Core Java</a></li>
								<li><a class="dropdown-item" href="#">Data Structures
										and Algorithm</a></li>
								<li><hr class="dropdown-divider"></li>
								<li><a class="dropdown-item" href="#">Advanced Java</a></li>
								<li><a class="dropdown-item" href="#">Frameworks</a></li>
							</ul></li>

						<li class="nav-item"><a class="nav-link active" href="#"><span
								class="fa fa-phone-square"></span> Contact</a></li>
						<li class="nav-item"><a class="nav-link active" href="#"
							data-bs-toggle="modal" data-bs-target="#add-post-modal"><span
								class="fa fa-upload"></span> Add Post</a></li>
					</ul>

					<ul class="navbar-nav me-right">
						<li class="nav-item"><a class="nav-link active" href="#"
							data-bs-toggle="modal" data-bs-target="#profile-modal"><span
								class="fa fa-user-circle"></span> <%=user.getName()%></a></li>
						<li class="nav-item"><a class="nav-link active" href="Logout">
								<span class="fa fa-sign-out"></span> Logout
						</a></li>
					</ul>

				</div>
			</div>
		</nav>
	</div>


	<%
	Message msg = (Message) session.getAttribute("msg");
	if (msg != null) {
	%>
	<div class="alert text-center <%=msg.getCssClass()%>" role="alert">
		<%=msg.getContent()%>
	</div>
	<%
	session.removeAttribute("msg");
	}
	%>

	<main>
		<div class="container">
			<div class="row mt-3">
				<div class="col-md-4">
					<div class="list-group">
						<a href="#" onclick="getPost(0,this)" class="c-link list-group-item list-group-item-action active">
							All Posts </a>

						<%
						PostDao pd1 = new PostDao(ConnectionProvider.getConnection());
						ArrayList<Categories> list1 = pd1.getAllCategories();
						for (Categories cc : list1) {
						%>
						<a href="#" onclick="getPost(<%=cc.getcId() %>,this)" class="c-link list-group-item list-group-item-action"> <%=cc.getcName()%>
						</a>
						<%
						}
						%>
					</div>
				</div>
				<div class="col-md-8" id="post-container">
						<div class="container text-center" id="loader">
						<i class="fa fa-refresh fa-4x fa-spin"></i>
						<h3>Loading...</h3>
						</div>
				</div>	
			</div>
		</div>
	</main>

	<!--   profile modal -->


	<!-- Modal -->
	<div class="modal fade" id="profile-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header primary-background text-center text-white">
					<h1 class="modal-title fs-5" id="exampleModalLabel">Profile</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<div class="container text-center">
						<img src="pics/<%=user.getProfile()%>" class="img-fluid"
							style="max-width: 170px; border-radius: 10%">

						<div id="profile-details">
							<table class="table mt-4">

								<tbody>

									<tr>
										<th scope="row">Name :</th>
										<td><%=user.getName()%></td>
									</tr>
									<tr>
										<th scope="row">Email :</th>
										<td><%=user.getEmail()%></td>
									</tr>
									<tr>
										<th scope="row">Gender :</th>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>
								</tbody>
							</table>
						</div>


						<div id="profile-edit" style="display: none;">
							<h3 class="mt-2">Please Edit Carefully !</h3>
							<form action="EditServlet" method="POST"
								enctype="multipart/form-data">
								<table class="table">


									<tr>
										<td>Name :</td>
										<td><input type="text" class="form-control"
											name="user_name" value="<%=user.getName()%>"></td>
									</tr>

									<tr>
										<td>Email :</td>
										<td><input type="email" class="form-control"
											name="user_email" value="<%=user.getEmail()%>"></td>
									</tr>

									<tr>
										<td>Password :</td>
										<td><input type="password" class="form-control" autocomplete="on"
											name="user_password" value="<%=user.getPassword()%>"></td>
									</tr>

									<tr>
										<td>Gender :</td>
										<td><%=user.getGender().toUpperCase()%></td>
									</tr>

									<tr>
										<td>New Profile :</td>
										<td><input type="file" name="image" class="form-control"
											value="<%=user.getPassword()%>"></td>
									</tr>

								</table>
								<div class="container">
									<button type="submit"
										class="btn btn-outline primary-background text-white">Save</button>

								</div>

							</form>

						</div>

					</div>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary primary-background"
						data-bs-dismiss="modal">Close</button>
					<button id="edit-profile-btn" type="button"
						class="btn btn-primary primary-background">Edit</button>
				</div>
			</div>
		</div>
	</div>

	<!--   end of profile modal -->


	<!--   add post modal -->

	<!-- Modal -->
	<div class="modal fade" id="add-post-modal" tabindex="-1"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<h1 class="modal-title fs-5" id="exampleModalLabel">New Post</h1>
					<button type="button" class="btn-close" data-bs-dismiss="modal"
						aria-label="Close"></button>
				</div>
				<div class="modal-body">
					<form id="addpost-form" action="AddPostServlet" method="POST" enctype='multipart/form-data'>
						<div class="pb-2 form-group">
							<select class="dropdown form-control " name="cid">
								<option class="dropdown-item" selected disabled>Select
									Category</option>
								<%
								PostDao pd = new PostDao(ConnectionProvider.getConnection());
								ArrayList<Categories> list = pd.getAllCategories();
								for (Categories c : list) {
								%>

								<option class="dropdown-item" value="<%=c.getcId()%>"><%=c.getcName()%></option>
								<%
								}
								%>

							</select>
						</div>

						<div class="mb-3 form-group">
							<input name="pTitle" type="text" class="form-control"
								 placeholder="Enter Post Title">

						</div>

						<div class="mb-3 form-group">
							<textarea name="pContent" class="form-control"
								 placeholder="Enter your content"
								style="height: 150px"></textarea>
						</div>
						<div class="mb-3 form-group">
							<textarea name="pCode" class="form-control"
								
								placeholder="Enter your program(if any)" style="height: 90px"></textarea>
						</div>
						<div class="mb-3 form-group">
							<label>Select your pic : </label> <input name="pPic" type="file"
								class="form-control" >
						</div>

						<div class="container text-center">
							<button type="submit" class="btn btn-outline primary-background text-white">Post</button>
						</div>
					</form>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-secondary"
						data-bs-dismiss="modal">Close</button>
				</div>
			</div>
		</div>
	</div>
	<!--   end of add post modal -->

	<script src="https://code.jquery.com/jquery-3.7.1.min.js"
		integrity="sha256-/JqT3SQfawRcv/BIHPThkBvs0OEvtFFmqPF/lYI/Cxo="
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
		integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
		crossorigin="anonymous"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.min.js"
		integrity="sha384-0pUGZvbkm6XF6gxjEnlmuGrJXVbNuzT9qBBavbLwCsOGabYfZo0T0to5eqruptLy"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"
		integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="js/myjs.js" type="text/javascript"></script>
		<script type="text/javascript">
		$(document).ready(function(e) {
			console.log("loaded");
			$("#addpost-form").on('submit', function(event) {
				console.log("loaded");
				event.preventDefault();
				
				let form = new FormData(this);
				$.ajax({
					url : "AddPostServlet",
					type : 'POST',
					data : form,
					success : function(data, textStatus, jqXHR) {
						//console.log(data)
						if(data.trim()== "Done"){
							swal("Post Added", "Successfully !", "success")
							.then((value) => {
								  window.location="profile.jsp"
								});
						}
						else{
							swal("Something went Wrong", "Please try again!", "error");
						}

					},
					error : function(jqXHR, textStatus, errorThrown) {
						//console.log(jqXHR)
						swal("Something went Wrong", "Please try again!", "error");

					},
					processData : false,
					contentType : false
				});
			});
		});
	</script>
	
	<script>
		$(document).ready(function() {
			$('#edit-profile-btn').click(function() {

				$("#profile-details").hide()
				$("#edit-profile-btn").hide()
				$("#profile-edit").show();

			});
		});
	</script>
	<script >
		function getPost(cId,temp){
			$("#loader").show();
			$("#post-container").hide();
			$(".c-link").removeClass("active");
			$.ajax({
				url : "load_post.jsp",
				data : {cid : cId},
				success: function(data,textStatus,jqXHR){
					console.log("data");
					$("#loader").hide();
					$("#post-container").show();
					$("#post-container").html(data);
					$(temp).addClass("active");
				}
			});
		}
		$(document).ready(function(e){
			let allPostRef=$(".c-link")[0];
			getPost(0,allPostRef)
		});
	</script>

</body>
</html>