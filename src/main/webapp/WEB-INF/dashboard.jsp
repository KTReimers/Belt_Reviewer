<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page isErrorPage="true" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Dashboard</title>
		<style>
			#inState{
				margin-bottom:20px;
			}
			h4{
				margin-bottom:20px;
			}
			table {
			  border-collapse: collapse;
			  width: 100%;
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
		<h1>Welcome </h1>
		<h4>Here are some events in your state:</h4>
		<div id="inState">
			<table>
				<thead>
					<tr>
						<th>Name</th>
						<th>Date</th>
						<th>Location</th>
						<th>Host</th>
						<th>Action/Status</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items= "${events}" var= "event">
						<c:if test="${event.state == user.state}">
							<tr>
								<td><a href="/events/${event.id}/show">${event.name}</a></td>
								<td>${event.date}</td>
								<td>${event.city}, ${event.state}</td>
								<td>${event.host.first_name}</td>
								<c:choose>
									<c:when test="${event.host.id == user_id}">
										<td>
											<a href="/events/${event.id}/edit">edit</a> | <a href="/events/${event.id}/delete">delete</a>
										</td>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${event.user.contains(user)}">
												<td>
													Joining | <a href="/events/${event.id}/cancel">Cancel</a>
												</td>
											</c:when>
											<c:otherwise>
												<td>
													<a href="/events/${event.id}/join">Join</a>
												</td>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<h4>Here are some events in other states:</h4>
		<div id="outState">
			<table>
				<thead>
					<tr>
						<th>Name</th>
						<th>Date</th>
						<th>Location</th>
						<th>Host</th>
						<th>Action/Status</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach items= "${events}" var= "event">
					<c:if test="${event.state != user.state}">
							<tr>
								<td><a href="/events/${event.id}/show">${event.name}</a></td>
								<td>${event.date}</td>
								<td>${event.city}, ${event.state}</td>
								<td>${event.host.first_name}</td>
								<c:choose>
									<c:when test="${event.host.id == user_id}">
										<td>
											<a href="/events/${event.id}/edit">edit</a> | <a href="/events/${event.id}/delete">delete</a>
										</td>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${event.user.contains(user)}">
												<td>
													Joining | <a href="/events/${event.id}/cancel">Cancel</a>
												</td>
											</c:when>
											<c:otherwise>
												<td>
													<a href="/events/${event.id}/join">Join</a>
												</td>
											</c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
							</tr>
						</c:if>
					</c:forEach>
				</tbody>
			</table>
		</div>
		<h1>Create an Event</h1>
		<form:form action="/events/new" method="post" modelAttribute="event">
		<form:input path="host" value= "${user_id}" type="hidden"/>
			<p>
				Name:
					<form:label path="name"></form:label>
					<form:errors path="name"/>
					<form:input  type="text" path="name"/>
			</p>
			<p>
				Date:
					<form:label path="date"></form:label>
					<form:errors path="date"/>
					<form:input  type="date" path="date"/>
			</p>
			<p>
				City:
					<form:label path="city"></form:label>
					<form:errors path="city"/>
					<form:input  type="text" path="city"/>
			</p>
			<p>
				State:
					<form:select path="state">
						<form:option value ="AL">Alabama</form:option>
	                    <form:option value ="AK">Alaska</form:option>
	                    <form:option value ="AZ">Arizona</form:option>
	                    <form:option value ="AR">Arkansas</form:option>
	                    <form:option value ="CA">California</form:option>
	                    <form:option value ="CO">Colorado</form:option>
	                    <form:option value ="CT">Connecticut</form:option>
	                    <form:option value ="DE">Delaware</form:option>
	                    <form:option value ="FL">Florida</form:option>
	                    <form:option value ="GA">Georgia</form:option>
	                    <form:option value ="HI">Hawaii</form:option>
	                    <form:option value ="ID">Idaho</form:option>
	                    <form:option value ="IL">Illinois</form:option>
	                    <form:option value ="IN">Indiana</form:option>
	                    <form:option value ="IA">Iowa</form:option>
	                    <form:option value ="KS">Kansas</form:option>
	                    <form:option value ="KY">Kentucky</form:option>
	                    <form:option value ="LA">Louisana</form:option>
	                    <form:option value ="ME">Maine</form:option>
	                    <form:option value ="MD">Maryland</form:option>
	                    <form:option value ="MA">Massachusetts</form:option>
	                    <form:option value ="MI">Michigan</form:option>
	                    <form:option value ="MN">Minnesota</form:option>
	                    <form:option value ="MS">Mississippi</form:option>
	                    <form:option value ="MO">Missouri</form:option>
	                    <form:option value ="MT">Montana</form:option>
	                    <form:option value ="NE">Nebraska</form:option>
	                    <form:option value ="NV">Nevada</form:option>
	                    <form:option value ="NH">New Hampshire</form:option>
	                    <form:option value ="NJ">New Jersey</form:option>
	                    <form:option value ="NM">New Mexico</form:option>
	                    <form:option value ="NY">New York</form:option>
	                    <form:option value ="NC">North Carolina</form:option>
	                    <form:option value ="ND">North Dakota</form:option>
	                    <form:option value ="OH">Ohio</form:option>
	                    <form:option value ="OK">Oklahoma</form:option>
	                    <form:option value ="OR">Oregon</form:option>
	                    <form:option value ="PA">Pennsylvania</form:option>
	                    <form:option value ="RI">Rhode Island</form:option>
	                    <form:option value ="SC">South Carolina</form:option>
	                    <form:option value ="SD">South Dakota</form:option>
	                    <form:option value ="TN">Tennessee</form:option>
	                    <form:option value ="TX">Texas</form:option>
	                    <form:option value ="UT">Utah</form:option>
	                    <form:option value ="VT">Vermont</form:option>
	                    <form:option value ="VA">Virginia</form:option>
	                    <form:option value ="WA">Washington</form:option>
	                    <form:option value ="WV">West Virginia</form:option>
	                    <form:option value ="WI">Wisconsin</form:option>
	                    <form:option value ="WY">Wyoming</form:option>
					</form:select>
			</p>
			<button type="submit">Submit new Event</button>
		</form:form>
	</body>
</html>