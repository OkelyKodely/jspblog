
<%@page language="java" import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">

<%@include file="header.jsp"%>

<body>

	<div class="container">

		<h1>All Users</h1>

		<table class="table table-striped">
			<thead>
				<tr>
					<th>#ID</th>
					<th>Name</th>
					<th>Email</th>
					<th>framework</th>
					<th>newsletter</th>
					<th>Action</th>
				</tr>
			</thead>

<%
String hostName = "ec2-54-163-240-54.compute-1.amazonaws.com";
String dbName = "d89l9begjikklj";
String userName = "isscllglmxgeln";
String passWord = "334f696049572d4bc9c3b6b78c3410301e24dd3b5fd2b96dc15bf4c1c6fed113";

Connection conn = null;

try {
    Class.forName("org.postgresql.Driver");
    String url = "jdbc:postgresql://" + hostName + "/" + dbName + "?user=" + userName + "&password=" + passWord + "&ssl=true&sslfactory=org.postgresql.ssl.NonValidatingFactory";
    conn = DriverManager.getConnection(url);
} catch(Exception e) {out.println(e.getMessage());}

Statement st = conn.createStatement();

ResultSet rs = st.executeQuery("SELECT * FROM jspBlogUsers");

while(rs.next()) {
    String userid = rs.getString("id");
    String username = rs.getString("name");
    String useremail = rs.getString("email");
    String newsletter = rs.getString("newsletter");
    String framework = rs.getString("framework");
%>
				<tr>
					<td>
						<%=userid%>
					</td>
					<td><%=username%></td>
					<td><%=useremail%></td>
					<td><%=framework%></td>
					<td>
					<div class="checkbox">
						<label>
						<%
						if(newsletter.equals("1")) {
						%>
	 					<input type="checkbox" id="newsletter" checked="checked" disabled="disabled" />
						<%
                                                } else {
						%>
						<input type="checkbox" id="newsletter" disabled="disabled" />
						<%
						}
						%>
						</label>
					</div>
					</td>
					<td>
						<button class="btn btn-info" onclick="location.href='show.jsp?userid=<%=userid%>'">Query</button>
						<button class="btn btn-primary" onclick="location.href='userform.jsp?userid=<%=userid%>'">Update</button>
						<button class="btn btn-danger" onclick="this.disabled=true;deleteuser.jsp?userid=<%=userid%>')">Delete</button>
					</td>
				</tr>

			<%
}

try {
    conn.close();
} catch(Exception e) {
}
%>
		</table>

	</div>

<%@include file="footer.jsp"%>

</body>
</html>