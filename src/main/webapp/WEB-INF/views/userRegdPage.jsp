<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>USER REGD APP</title>
<link rel="stylesheet" href="css/bootstrap.min.css">
</head>
<body>
	<div class="container mt-3">
		<div class="card">
			<div class="card-header h2 text-primary">USER REGISTRATION FORM
			</div>
			<div class="card-body">
				<form action="./saveUser" method="post"
					enctype="multipart/form-data" onsubmit="return validate()">
					<input type="hidden" name="uId" id="usrId" value="${user.uId}">
					<div class="row">
						<div class="col-6">
							<label for="usrNameId" class="font-weight-bold">Enter
								User Name</label> <input type="text" class="form-control" name="name"
								id="nameId" value="${user.name}">
						</div>
						<div class="col-6">
							<label for="usrEmailId" class="font-weight-bold">Enter
								User Email</label> <input type="text" class="form-control" name="email"
								id="emailId" value="${user.email}">
						</div>
						<div class="col-6">
							<label for="usrPassId" class="font-weight-bold">Enter
								User Password</label> <input type="email" class="form-control"
								name="password" id="passId" value="${user.password}">
						</div>
						<div class="col-6">
							<label for="countryId" class="font-weight-bold">Select
								Country</label> <select name="country" id="countryId"
								class="form-control" onchange="findStateByCountryId(this.value)">
								<option value="0">-select-</option>
								<c:forEach items="${countyList}" var="country">
									<option value="${country.cid}">${country.name}</option>
								</c:forEach>
							</select>
						</div>
						<div class="col-6">
							<label for="stateId" class="font-weight-bold">Select
								State</label> <select name="state" id="stateId" class="form-control">

							</select>

						</div>
						<div class="col-6">
							<label for="usrPhotoId" class="font-weight-bold">Upload
								User Photo</label> <input type="file" class="form-control" name="file"
								id="photoId" value="${user.photo}">
						</div>
						<div class="col-12 text-center mt-2">
							<input type="button" class="btn btn-success" value="SUBMIT">
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
	<script src="js/jQuery.js"></script>
	<script src="js/bootstrap.min.js"></script>
	<script type="text/javascript">
		function findStateByCountryId(c) {
			$.ajax({
				type : 'GET',
				url : 'findStateByCountryId',
				data : {
					countryId : c
				},
				success : function(resp) {
					$('#stateId').html(resp);
				}
			});
		}
	</script>
</body>
</html>