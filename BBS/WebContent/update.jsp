<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.Bbs" %>	<!-- 실제로 DB사용가능하게 Bbs BbsDAO연결 -->
<%@ page import="bbs.BbsDAO" %>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width", initial-scale="1">
<link rel="stylesheet" href="css/bootstrap.css">
<link rel="stylesheet" href="css/custom.css">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<%
		String userID=null;										
		if(session.getAttribute("userID") !=null){				//세션 존재시
			userID=(String) session.getAttribute("userID");		//string형태로 형변환후 세션관리
		}
		if(userID==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 해주세요')");
			script.println("location.href='login.jsp'");
			script.println("</script>");
		}
		
		int bbsID=0;
		if(request.getParameter("bbsID") != null){
				bbsID =Integer.parseInt(request.getParameter("bbsID"));
		}
		
		if(bbsID==0){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('유효하지 않은 글입니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
		Bbs bbs=new BbsDAO().getBbs(bbsID);		//작성한 글이 작성자인지 확인
		if (!userID.equals(bbs.getUserID())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("history.back()");
			script.println("</script>");
		}
	%>


	<nav class = "navbar navbar-default">
		<div class = "navbar-header">
			<button type = "button" class="navbar-toggle collapsed"
				data-toggle="collapse" data-target="#bs-example-navbar-collapse-1"
				aria-expanded="false">
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="main">JSP 게시판 웹 사이트</a>
		</div>
		<div class ="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
			<ul class="nav navbar-nav">
				<li><a href="main.jsp">메인</a></li>	
				<li class="active"><a href="bbs.jsp">게시판</a></li>				
			</ul>
			
		
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li ><a href="logoutAction.jsp">로그아웃</a></li>
					</ul>
				</li>	
			</ul>
			
		</div>
	</nav>
	
	<div class="container">		<!-- 글을 쓰면 보여주는 역활 -->
		<div class="row">
			<form method="post" action="updateAction.jsp?bbsID=<%= bbsID %>">		<!-- 수정할시 updateAction페이지 불러옴 bbs아이디 보내줌-->
				<table class="table table-striped" style="text-align:center; border:1px solid #dddddd">	<!-- 테이블 홀짝으로 번갈아가면서 색상변경 -->
					<thead>	<!-- 테이블 제목부분 -->
						<tr>	<!-- 테이블 하나의 행 -->
							<th colspan="2" style="background-color:#eeeeee; text-align:center;">게시판 글수정 양식</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="text" class="form-control" placeholder="글 제목" name="bbsTitle" maxlength="50" value="<%=bbs.getBbsTitle()%>"></td>		<!-- 자기가 수정하는 글의 내용을 볼수있게 -->
						</tr>
						<tr>
							<td><textarea  class="form-control" placeholder="글 내용" name="bbsContent" maxlength="2048" style="heightt:350px;"<%=bbs.getBbsContent()%>></textarea>></td>
						</tr>
					</tbody>
				</table>
				<input type="submit" class="btn btn-primary pull-right" value="글수정"/>
			</form>
		</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>