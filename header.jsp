<head>
<title>Blog Pad</title>
<base href="/jspblog/">
<link href="bootstrap.min.css" rel="stylesheet" />
<link href="hello.css" rel="stylesheet" />
</head>

<body>
<nav class="navbar navbar-inverse">
	<div class="container">
		<div class="navbar-header">
			<a class="navbar-brand" href="index.jsp">Blog Pad</a>
		</div>
		<div id="navbar">
			<ul class="nav navbar-nav navbar-right">
				<%
                                if(session.getAttribute("userid") == null) {
				%>
				<li class="active"><a href="login.jsp">Login</a></li>
				<li class="active"><a href="register.jsp">Register</a></li>
				<%
                                } else {
				%>
				<li class="active">
					<div class="navbar-brand">
						<a href="login.jsp" style="color:white;">Dashboard</a>
						&nbsp;<a href="logout.jsp" style="color:white;">(Logout)</a>
					</div>
			  </li>
				<%
				}
				%>
			</ul>
		</div>
	</div>
</nav>