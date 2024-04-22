<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Register</title>
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
	<main class="primary-background ">
		<div class="container pt-3 pb-3">
			<div class="row">
				<div class="col-md-4 offset-md-4">
					<div class="card">
						<div
							class="card-header primary-background text-white text-center pb-0 pt-3">
							<span class="fa fa-user-plus fa-3x"></span>
							<p>Register</p>

						</div>
						<div class="card-body">


							<form id="reg-form" action="Register" method="POST">

								<div class="form-group">
									<label for="user_name">Username</label> <input name="user_name"
										type="text" class="form-control" id="user_name">
								</div>
								<div class="form-group">
									<label for="exampleInputEmail1">Email address</label> <input
										name="user_email" type="email" class="form-control"
										id="exampleInputEmail1" aria-describedby="emailHelp">
								</div>
								<div class="form-group">
									<label for="password">Enter Password</label> <input
										name="user_password" type="password" class="form-control"
										id="password">
								</div>

								<!--<div class="form-group">
                                    <label for="password_2">Confirm Password</label>
                                    <input type="password" class="form-control" id="password_2">
                                </div>-->

								<div class="form-group mt-2 mb-1">
									<label for="gender">Gender</label><br> <input type="radio"
										id="gender" name="gender" value="male">Male <input
										type="radio" id="gender" name="gender" value="female">Female
									<input type="radio" id="gender" name="gender" value="others">Others
								</div>
								<div class="form-group form-check">
									<input name="check" type="checkbox" class="form-check-input"
										id="exampleCheck1"> <label class="form-check-label"
										for="exampleCheck1">Check me out</label>
								</div>
								<div class="mt-3">
									<div class="container text-center" id="loader"
										style="display: none;">
										<span class="fa fa-refresh fa-spin fa-4x"></span>
									</div>
									<div class="container text-center">
										<button id="submit-btn" type="submit" class="btn btn-primary ">Sign
											Up</button>
									</div>
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
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/sweetalert/2.1.2/sweetalert.min.js"
		integrity="sha512-AA1Bzp5Q0K1KanKKmvN/4d3IRKVlv9PYgwFPvm32nPO6QS8yH1HO7LbgB1pgiOxPtfeg5zEn2ba64MUcqJx6CA=="
		crossorigin="anonymous" referrerpolicy="no-referrer"></script>
	<script src="js/myjs.js" type="text/javascript"></script>
	<script>

	$(document).ready(function(){
		$("#reg-form").on('submit',function(event){
			event.preventDefault();
			let form=new FormData(this);
			
			$("#submit-btn").hide();
			$("#loader").show();
			
			$.ajax({
				url : "Register",
				type : 'POST',
				data : form,
				success : function(data,textStatus,jqXHR){
					console.log(data) 
					
					$("#submit-btn").show();
					$("#loader").hide();
					
					if(data.trim()== "Done"){
						swal("Registered Successfully!", "Redirecting to login page.....", "success")
						.then((value) => {
							  window.location="login.jsp"
							});
					}
					else{
						swal(data);
					}
					
				},
				error : function(jqXHR,textStatus,errorThrown){
					console.log(jqXHR)
					$("#submit-btn").show();
					$("#loader").hide();
					swal("Something went Wrong", "Please try again!", "error");
				},
				processData : false,
				contentType : false
			});
		});
	});

		</script>
</body>
</html>