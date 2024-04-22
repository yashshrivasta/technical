<%@page import="com.tech.blog.entities.Message"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-QWTKZyjpPEjISv5WaRU9OFeRpok6YctnYmDr5pNlyT2bRjXh0JMhjY6hW+ALEwIH"
	crossorigin="anonymous">
<link href="css/mystyles.css" rel="stylesheet" type="text/css">
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
</head>
<body>

	<%@include file="navbar.jsp"%>

	<main class="d-flex align-items-center primary-background"
		style="height: 75vh;">
		<div class="container">
			<div class="row">
				<div class="col-md-4 offset-md-4">
					<div class="card">

						<div
							class="card-header primary-background text-white text-center pt-3 pb-0">
							<span class="fa fa-user-circle-o fa-3x"></span>
							<p>Login here</p>

						</div>

						<%
                        Message msg=(Message)session.getAttribute("msg");
                        if(msg!=null){
                        	
                        %>
						<div class="alert text-center <%=msg.getCssClass() %>" role="alert">
							<%=msg.getContent() %>
						</div>
						<% 
						session.removeAttribute("msg");
                        } %>

						<div class="card-body">


							<form action="Login" method="POST">
								<div class="form-group">
									<label for="exampleInputEmail1">Email address</label> <input
										name="email" type="email" class="form-control" id="email"
										required aria-describedby="emailHelp">

								</div>
								<div class="form-group">
									<label for="exampleInputPassword1">Password</label> <input
										name="password" type="password" class="form-control"
										id="password" required>
								</div>
								<br>

								<div class="container text-center">
									<button type="submit" class="btn btn-primary">Submit</button>
								</div>
							</form>


						</div>

					</div>

				</div>

			</div>


		</div>
	</main>



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
		<script src="js/myjs.js" type="text/javascript"></script>

</body>
</html>