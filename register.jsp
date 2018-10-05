
<%@page language="java" import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">

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

String userid = null;
String password = null;
String name = null;
String email = null;

userid = request.getParameter("userid");

if(userid != null) {
    
    password = request.getParameter("password");
    name = request.getParameter("name");
    email = request.getParameter("email");
    
    Statement st = conn.createStatement();
    st.execute("insert into jspBlogUsers (id,password,name,email,newsletter,framework) values ('"+userid+"','"+password+"','"+name+"','"+email+"','1','1')");
    st.execute("insert into jspBlogDesign (userid,banner) values ('"+userid+"','banner1.jpg')");
    response.sendRedirect("index.jsp");
}

%>

<%@include file="header.jsp"%>

	<div class="container">

		<table class="table table-striped">
			<thead>
				<tr>
					<th>Register</th>
				</tr>
				<tr>
					<td>
						<form method="post" action="register.jsp">
						<table class="table">
							<tr><td>User ID: </td><td><input type="text" name="userid"></td></tr>
							<tr><td>Password: </td><td><input type="password" name="password"></td></tr>
                                                        <tr><td>Name: </td><td><input type="text" name="name"></td></tr>
                                                        <tr><td>Email: </td><td><input type="text" name="email"></td></tr>
							<tr><td colspan="2"><input type="submit" value="Register"></td></tr>
						</table>
						</form>
					</td>
				</tr>
			</thead>

		</table>

	</div>

	<%@include file="footer.jsp"%>

</body>
<%

try {
    conn.close();
} catch(Exception e) {
}
%>
</html>