<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>JSP 게시판 웹 사이트</title>
</head>
<body>
	<% 
		session.invalidate();	//페이지 접속한 회원 세션 뺏기
	%>
	<script>
		location.href='main.jsp';	//main으로 이동
	</script>
</body>
</html>