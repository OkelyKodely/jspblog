
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
    if(rs.next()) {
        session.setAttribute("userid", userid);
        session.setAttribute("password", password);
%>
<%@include file="header.jsp"%>

	<div class="container">

		<table class="table table-striped">
			<thead>
				<tr><td><h1>Dashboard</h1></td></tr>
				<tr>
					<th colspan="3">You are now logged in to your Dashboard.  Visit your <a href="index.jsp?userid=<%=userid%>">blog</a>.</th>
				</tr>
				<tr><td><a href="new.jsp"><button type="button" class="btn btn-default">New</button></a></td></tr>
<%
String bannr = request.getParameter("banner");
if(bannr != null) {
    st.execute("update jspBlogDesign set banner = '" + bannr + "' where userid = '" + userid + "'");
}

rs = st.executeQuery("select * from jspBlogDesign where userid = '" + userid + "'");
if(rs.next()) {
    bannr = rs.getString("banner");
%>
				<form method="post" action="login.jsp">
				<tr>
					<td colspan="3">
						banner1: <img src="banner1.jpg" width = 300>
						<br>
                                                <input type="radio" name="banner" value="banner1.jpg" <%if(bannr.equals("banner1.jpg")) out.print("checked=\"checked\"");%>>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						banner2: <img src="banner2.jpg" width = 300>
						<br>
                                                <input type="radio" name="banner" value="banner2.jpg" <%if(bannr.equals("banner2.jpg")) out.print("checked=\"checked\"");%>>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						banner3: <img src="banner3.jpg" width = 300>
						<br>
                                                <input type="radio" name="banner" value="banner3.jpg" <%if(bannr.equals("banner3.jpg")) out.print("checked=\"checked\"");%>>
					</td>
				</tr>
				<tr>
					<td colspan="3">
						<input type="submit" value="Save">
					</td>
				</tr>
				</form>
				<tr>
					<td>
						ID
					</td>
					<td>
						Title
					</td>
					<td>
						Date
					</td>
				</tr>

<%
}

rs = st.executeQuery("select * from jspBlog where userid = '" + userid + "' order by id desc");
while(rs.next()) {
%>
				<tr>
					<td>
						<a href="entry.jsp?userid=<%=userid%>&id=<%=rs.getString("id")%>"><%=rs.getString("id")%></a>
					</td>
					<td>
						<a href="edit.jsp?id=<%=rs.getString("id")%>"><%=rs.getString("title")%></a>
					</td>
					<td>
						<%=rs.getString("datetime")%>
					</td>
				</tr>
<%
}
%>

			</thead>

		</table>

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