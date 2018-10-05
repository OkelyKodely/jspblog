
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

if(session.getAttribute("userid") == null) {

	userid = request.getParameter("userid");
	password = request.getParameter("password");

} else {
	
        userid = (String) session.getAttribute("userid");
	password = (String) session.getAttribute("password");

}
%>

<%
if(userid != null && password != null) {
    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("select id from jspBlogUsers where id = '" + userid + "' and password = '" + password + "'");
    String title = request.getParameter("title");
    String content = request.getParameter("content");
    if(title == null)
        title = "";
    if(content == null)
        content = "";
    title = title.replace("'","''");
    content = content.replace("'","''");

    if(!title.equals("") && !content.equals("")) {
        Statement st2 = conn.createStatement();
        st2.execute("insert into jspBlog (title,content,datetime,userid) values ('" + title + "','" + content + "',current_timestamp,'"+userid+"')");
        response.sendRedirect("login.jsp");
    }

    if(rs.next()) {
        session.setAttribute("userid", userid);
        session.setAttribute("password", password);
%>
<%@include file="header.jsp"%>

	<div class="container">

<form method="post" action="new.jsp">
		<table class="table table-striped">
			<tr><td><h1>Dashboard</h1></td></tr>
			<tr><td>Go <a href="login.jsp">back</a> to the main page of the Dashboard.</td></tr>
				<tr>
					<td>
						ID: New ID
					</td>
				</tr>
				<tr>
					<td>
						Title: <input type="text" name="title">
					</td>
				</tr>
				<tr>
					<td>
						Date: Current
					</td>
				</tr>

				<tr>
					<td>
						<textarea name="content" rows="20" cols="130"></textarea>
					</td>
				</tr>
				<tr>
					<td>
						<input type="submit" value="Submit">
					</td>
				</tr>

		</table>
</form>
	</div>

	<%@include file="footer.jsp"%>

</body>

<%
	} else {
	%>
        <%@include file="header.jsp"%>

	<div class="container">

		<table class="table table-striped">
			<thead>
				<tr>
					<th>Login</th>
				</tr>
				<tr>
					<td>
						<form method="post" action="login.jsp">
						<table class="table">
							<tr><td>User ID: </td><td><input type="text" name="userid"></td></tr>
							<tr><td>Password: </td><td><input type="password" name="password"></td></tr>
							<tr><td colspan="2"><input type="submit" value="Login"></td></tr>
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
	}
} else {
%>
<%@include file="header.jsp"%>

	<div class="container">

		<table class="table table-striped">

			<thead>
				<tr>
					<th>Login</th>
				</tr>
				<tr>
					<td>
						<form method="post" action="login.jsp">
						<table class="table">
							<tr><td>User ID: </td><td><input type="text" name="userid"></td></tr>
							<tr><td>Password: </td><td><input type="password" name="password"></td></tr>
							<tr><td colspan="2"><input type="submit" value="Login"></td></tr>
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
}

try {
    conn.close();
} catch(Exception e) {
}
%>

</html>