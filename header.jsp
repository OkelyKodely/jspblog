<head>
<title>JSP BLOG</title>
<base href="/jspblog/">
<link href="bootstrap.min.css" rel="stylesheet" />
</head>

<body>
<nav class="navbar navbar-inverse">
	<div class="container">
		<div class="navbar-header">
                    <%
                        String uid = "";
                        if(session.getAttribute("userid") != null)
                            uid = (String) session.getAttribute("userid");
                        else if(request.getParameter("userid") != null)
                            uid = request.getParameter("userid");
                        
                        if(!uid.equals("")) {
                        %>
			<a class="navbar-brand" href="index.jsp"><%=uid%>'s blog</a>
                        <%
                        } else {
                        %>
			<a class="navbar-brand" href="index.jsp">JSP BLOG</a>
                        <%
                        }
                        %>
		</div>
		<div id="navbar">
			<ul class="nav navbar-nav navbar-right">
				<%
                                if(session.getAttribute("userid") == null) {
				%>
				<li class="active"><a href="login.jsp">Sign in</a></li>
				<li class="active"><a href="register.jsp">Sign up</a></li>
				<%
                                } else {
				%>
				<li class="active">
					<div class="navbar-brand">
						<a href="login.jsp" style="color:white;">Manage blog</a>
						|&nbsp;<a href="logout.jsp" style="color:white;">Sign out</a>
					</div>
			  </li>
				<%
				}
				%>
			</ul>
		</div>
	</div>
</nav>