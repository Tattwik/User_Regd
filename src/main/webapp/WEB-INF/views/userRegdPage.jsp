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
			<div class="card-header h2 text-primary" id="head">USER
				REGISTRATION FORM</div>
			<div class="card-body">
				<form action="./saveUser" method="post"
					enctype="multipart/form-data">
					<input type="hidden" name="uid" id="usrId" value="0">
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
								User Password</label> <input type="password" class="form-control"
								name="password" id="passId" value="${user.password}">
						</div>
						<div class="col-6">
							<label for="addrsId" class="font-weight-bold">Enter User
								Address</label>
							<textarea class="form-control" name="address" id="addrsId"
								rows="2" cols="6"></textarea>
						</div>
						<div class="col-6">
							<label for="countryId" class="font-weight-bold">Select
								Country</label> <select name="country" id="countryId"
								class="form-control" onchange="findStateByCountryId(this.value)">
								<option value="0">-select-</option>
								<c:forEach items="${countyList}" var="country">
									<option value="${country.cid}"
										<c:if test="${country.cid == user.country.cid}">selected='selected'</c:if>>${country.name}</option>
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
						<input type="hidden" name="isdelete" id="delId" value="No">
						<div class="col-12 text-center mt-2">
							<input id="subBtn" type="submit" class="btn btn-success"
								value="SUBMIT"> <input id="cnclBtn" type="button"
								class="btn btn-warning" value="CANCEL" onclick="cancel()"
								style="display: none;">
						</div>
					</div>
				</form>
				<table class="table table-bordered table-striped mt-2" id="userTbl">
					<thead>
						<tr>
							<th>SlNo</th>
							<th>User Id</th>
							<th>User Name</th>
							<th>User Email</th>
							<th>User Address</th>
							<th>Residing State</th>
							<th>Residing Country</th>
							<th>User Photo</th>
							<th>ACTION</th>
							<th>ACTION</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${userList}" var="user" varStatus="counter">
							<tr>
								<td>${counter.count}</td>
								<td>${user.uid}</td>
								<td>${user.name}</td>
								<td>${user.email}</td>
								<td>${user.address}</td>
								<td>${user.state.name}</td>
								<td>${user.country.name}</td>
								<td><a href="./getImage?fileName=${user.photo}">${user.photo}</a></td>
								<td><input type="button" class="btn btn-primary"
									onclick="populate(${user.uid} , '${user.name}', 
											'${user.email}', 
											'${user.address}'	
											)"
									value="UPDATE"></td>
								<td><a class="btn btn-danger"
									href="./deleteUser?uId=${user.uid}">DELETE</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
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
		function populate(id, n, e, a, s, c) {
			document.getElementById("head").innerHTML = "UPDATE USER DETAILS"
			document.getElementById("subBtn").value="UPDATE";
			document.getElementById("subBtn").classList.remove("btn");
			document.getElementById("subBtn").classList.remove("btn-success");
			document.getElementById("subBtn").classList.add("btn");
			document.getElementById("subBtn").classList.add("btn-primary");
			document.getElementById("cnclBtn").style.display="inline";
			var i = id;
			var uname = n;
			var email = e;
			var address = a;
			document.getElementById("usrId").value = id;
			document.getElementById("nameId").value = uname;
			document.getElementById("emailId").value = email;
			document.getElementById("addrsId").value = address;
		}
		function cancel() {
			location.reload();
		}
	</script>
</body>
</html>