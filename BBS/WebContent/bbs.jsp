<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.io.PrintWriter" %>
<%@ page import="bbs.BbsDAO" %>
<%@ page import="bbs.Bbs" %>
<%@ page import="java.util.ArrayList" %>	<!-- 게시판 목록출력을 위해 -->
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width",initial-scale="1">
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
	
		int pageNumber=1;	
		if (request.getParameter("pageNumber")!=null){
			pageNumber=Integer.parseInt(request.getParameter("pageNumber"));	//게시판이 몇번째 페이지인지 알려줄수있게 하기위해 페이지넘버를 1로 지정하고 
																				//파라미터로 페이지넘버가 넘어오면 해당 페이지 표시
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
			
			<%
				if(userID==null){	//유저 세션이 없을시
			%>
			<ul class="nav navbar-nav navbar-right">			<!-- 로그인 or 회원가입하게 만든다 -->
				<li class="dropdown">
					<a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">접속하기<span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li ><a href="login.jsp">로그인</a></li>
						<li><a href="join.jsp">회원가입</a></li>
					</ul>
				</li>	
			</ul>
			
			<%
				}else{
					
			%>
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
			
			<%
				}
			%>
			
		</div>
	</nav>
	
	<div class="container">		<!-- 글을 쓰면 보여주는 역활 -->
		<div class="row">
			<table class="table table-striped" style="text-alige:center; border:1px solid #dddddd">	<!-- 테이블 홀짝으로 번갈아가면서 색상변경 -->
				<thead>	<!-- 테이블 제목부분 -->
					<tr>	<!-- 테이블 하나의 행 -->
						<th style="backgroud-color:#eeeeee; text-align:center;">번호</th>
						<th style="backgroud-color:#eeeeee; text-align:center;">제목</th>
						<th style="backgroud-color:#eeeeee; text-align:center;">작성자</th>
						<th style="backgroud-color:#eeeeee; text-align:center;">작성일</th>
					</tr>
				</thead>
				<tbody>
				<%
					BbsDAO bbsDAO=new BbsDAO();		//bbsDAO를 가져온다
					ArrayList<Bbs> list= bbsDAO.getList(pageNumber);		
					for(int i=0; i<list.size(); i++){
						
				%>
					<tr>
						<td><%= list.get(i).getBbsID() %></td>
						<td><a href="view.jsp?bbsID=<%= list.get(i).getBbsTitle() %>"><%=list.get(i).getBbsTitle() %></a></td>
						<td><%= list.get(i).getUserID() %></td>
						<td><%= list.get(i).getBbsDate().substring(0,11)+list.get(i).getBbsDate().substring(11,13)+"시"+list.get(i).getBbsDate().substring(14,16)+"분" %></td>
					</tr>
					<%
					}
					%>
				</tbody>
			</table>
			<%
				if(pageNumber !=1){
					
			%>
				<a href="bbs.jsp?pageNumber=<%=pageNumber -1 %>" class="btn btn-success btn-arraw-left">이전</a>
			<%
				}	if(bbsDAO.nextPage(pageNumber +1)){
			%>
			<a href="bbs.jsp?pageNumber=<%=pageNumber +1 %>" class="btn btn-success btn-arraw-left">다음</a>
			<%
				}
			%>
			<a href="write.jsp" class="btn btn-primary pull-right">글쓰기</a>
		</div>
	</div>
	<script src = "https://code.jquery.com/jquery-3.1.1.min.js"></script>
	<script src = "js/bootstrap.js"></script>
</body>
</html>
