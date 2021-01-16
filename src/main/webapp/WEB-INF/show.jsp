<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isErrorPage="true" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Show Event</title>
		<style>
			table {
			  border-collapse: collapse;
			  width: 500px;
			}
			
			td, th {
			  border: 1px solid #dddddd;
			  text-align: left;
			  padding: 8px;
			}
			
			tr:nth-child(even) {
			  background-color: #dddddd;
			}
		</style>
	</head>
	<body>
		<div id= "title">
			<h1>${event.name}</h1>
		</div>
		<div id= "details">
			<h3> Host: ${event.host.first_name} ${event.host.last_name}</h3>
			<h3>Event Date: ${event.date}</h3>
			<h3>Location: ${event.city}, ${event.state}</h3>
			<h3></h3>
			<h3>People who are attending this event:</h3>
			<table>
				<thead>
					<tr>
						<th>Name</th>
						<th>Location</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items="${event.user}" var="user">
						<tr>
							<td>${user.first_name} ${user.last_name}</td>
							<td>${user.city} ${user.state}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
		</div>
	</body>
</html>