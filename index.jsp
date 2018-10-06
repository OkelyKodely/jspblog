
<%@page language="java" import="java.sql.*"%>

<!DOCTYPE html>
<html lang="en">

<%@include file="header.jsp"%>

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

if(session.getAttribute("userid") == null) {
    userid = request.getParameter("userid");
}
else {
    userid = (String) session.getAttribute("userid");
}

if(userid != null) {

    String mon = request.getParameter("mon");
    String year = request.getParameter("year");

    Statement st1 = conn.createStatement();
    ResultSet rs1 = null;
    
    if(mon == null || year == null) {
            rs1 = st1.executeQuery("SELECT * FROM jspBlog WHERE userid='" + userid + "' ORDER BY id DESC");
    } else {
            rs1 = st1.executeQuery("SELECT * FROM jspBlog WHERE date_part('year',datetime)=" + year + " AND date_part('month',datetime)=" + mon + " AND userid='" + userid + "' ORDER BY id DESC");
    }

    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM jspBlogDesign WHERE userid = '" + userid + "'");
    if(rs.next()) {
%>
    <a href="index.jsp?userid=<%=userid%>"><img src="<%=rs.getString("banner")%>" width="100%" style="position:relative;bottom:20px;"></a>
<%
    }
%>

    <table class="table" cellpadding="2">
	<tr><td colspan="2"><h4><a href="index.jsp?userid=<%=userid%>">Home</a></h4></td></tr>
	<tr>
            <th>Entries</th>
            <th>Monthly Archives</th>
	</tr>
        <tr>
            <td valign="top">
<%
    while(rs1.next()) {
        String id = rs1.getString("id");
        String title = rs1.getString("title");
        String user = rs1.getString("userid");
        String datetime = rs1.getString("datetime");
        String content = rs1.getString("content");
%>
		<table class="table table-striped">
                    <tr>
			<td>
                            On <%=datetime%> user <%=user%> wrote:<br><br>
                            <table width=100% class="table">
				<tr>
                                    <td>
					<h2><a href="entry.jsp?userid=<%=userid%>&id=<%=id%>"><%=title%></a></h2>
					<%=content%>
                                    </td>
				</tr>
                            </table>
			</td>
                    </tr>
		</table>
<%
    }

    Statement st2 = conn.createStatement();
    ResultSet rs2 = st2.executeQuery("SELECT to_char(to_timestamp (date_part('month', datetime)::text, 'MM'), 'Month') mont, date_part('month',datetime) mon, date_part('year',datetime) as yea, " +
			"count(datetime) as countArticlesInMonth FROM jspBlog WHERE userid='" + userid + "'" +
			"GROUP BY date_part('year',datetime), date_part('month',datetime) ORDER BY date_part('year',datetime), date_part('month',datetime)");
%>
            </td>
            <td style="width:180px;border:1px solid #e0e0e0">
<%
    if(rs2 != null)
    while(rs2.next()) {
        String month = rs2.getString("mont");
        String mont = rs2.getString("mon");
        year = rs2.getString("yea");
        String countArticlesInMonth = rs2.getString("countArticlesInMonth");
%>
        <a href="index.jsp?userid=<%=userid%>&mon=<%=mont%>&year=<%=year%>"><%=month%>, <%=year%> (<%=countArticlesInMonth%>)</a><br>
<%
  }
%>
            </td>
	</tr>
    </table>
<%
}

try {
    conn.close();
} catch(Exception e) {
}
%>

<%@include file="footer.jsp"%>

</body>
</html>