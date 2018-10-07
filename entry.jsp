
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
} else {
    userid = (String) session.getAttribute("userid");
}

String entry = null;

entry = request.getParameter("id");

if(userid != null && entry != null) {

    Statement st = conn.createStatement();
    ResultSet rs = st.executeQuery("SELECT * FROM jspBlog WHERE id=" + entry + " AND userid='" + userid + "'");

    if(rs.next()) {
        String id = rs.getString("id");
        String title = rs.getString("title");
        String user = rs.getString("userid");
        String datetime = rs.getString("datetime");
        String content = rs.getString("content");

    Statement st1 = conn.createStatement();
    ResultSet rs1 = st.executeQuery("SELECT * FROM jspBlogDesign WHERE userid = '" + userid + "'");
    if(rs1.next()) {
%>
    <center><a href="index.jsp?userid=<%=userid%>"><img src="<%=rs1.getString("banner")%>" style="position:relative;bottom:20px;"></a></center>
<%
    }
%>
    <table class="table" cellpadding="2">
        <tr>
            <td>
                <h4><a href="index.jsp?userid=<%=userid%>">Home</a> > <a href="entry.jsp?userid=<%=userid%>&id=<%=entry%>"><%=title%></a></h4>
		<table class="table table-striped">
                    <tr>
			<td>
                            On <%=datetime%> user <%=user%> wrote:<br><br>
                            <table width=100% class="table">
				<tr>
                                    <td>
					<h2><%=title%></h2>
					<%=content%>
                                    </td>
				</tr>
                            </table>
			</td>
                    </tr>
		</table>

<%
        int month, year;

        rs = st.executeQuery("SELECT to_char(to_timestamp (date_part('month', datetime)::text, 'MM'), 'Month') mont, date_part('month',datetime) mon, date_part('year',datetime) as yea, " +
			"count(datetime) as countArticlesInMonth FROM jspBlog WHERE userid='" + userid + "'" +
			"GROUP BY date_part('year',datetime), date_part('month',datetime) ORDER BY date_part('year',datetime), date_part('month',datetime)");
%>
            </td>
            <td style="width:180px;border:1px solid #e0e0e0">
<%
        if(rs != null)
        while(rs.next()) {
            String themonth = rs.getString("mont");
            int mon = rs.getInt("mon");
            year = rs.getInt("yea");
            String countArticlesInMonth = rs.getString("countArticlesInMonth");
            %>
            <a href="index.jsp?userid=<%=userid%>&mon=<%=mon%>&year=<%=year%>"><%=themonth%>, <%=year%> (<%=countArticlesInMonth%>)</a><br>
            <%
        }
%>
            </td>
	</tr>
    </table>
<%
    }

}

try {
    conn.close();
} catch(Exception e) {
}
%>

<%@include file="footer.jsp"%>

</body>
</html>