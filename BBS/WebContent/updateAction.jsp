<!-- 실제로 글쓰기를 눌러서 글을 작성해 주는 페이지 -->
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- 게시글을 작성할 수 있는 데이터베이스는 BbsDAO객체를 이용해서 다룰수 있기때문에 참조 -->	
<%@ page import="bbs.BbsDAO"%>
<%@ page import="bbs.Bbs"%>
<!-- bbsdao의 클래스 가져옴 -->
<%@ page import="java.io.PrintWriter"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>jsp 게시판 웹사이트</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
			userID = (String) session.getAttribute("userID");//유저아이디에 해당 세션값을 넣어준다.
		}
		//글쓰기 같은 경우에는 로그인이 된사람만 가능해야 하기때문에 조건을 걸어준다.
		if (userID == null) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('로그인을 하세요.')");
			//로그인 안된 사람들은 로그인 페이지로 이동하게 만들어주면 된다.
			script.println("location.href = 'login.jsp'");
			script.println("</script>");
			//로그인이 된 사람들은 이쪽으로 넘어가게 해준다.
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
		}else {
			//사용자가 만약에 제목이나, 내용을 입력하지 않았을 경우에 발생 할 상황
			if (request.getParameter("bbsTitle") == null || request.getParameter("bbsContent") == null			//자바빈즈를 사용하지않아서 title,content로 넘어오는것들을 비교할 필요가있음	글제목,내용이 update.jsp에서 매개변수 넘어와서 비교
				|| 	request.getParameter("bbsTitle").equals("")  || request.getParameter("bbsContent").equals(""))	 {		//글 제목,내용잉 빈칸인지 확인
				PrintWriter script = response.getWriter();									
				script.println("<script>");
				script.println("alert('입력이 안된 사항이 있습니다')");
				script.println("history.back()");
				script.println("</script>");
			//모든 조건이 다 만족 되었을때
			} else {
				//실제로 데이터 베이스에 등록을 해준다 BbsDAO 인스턴스를 만들고,
				BbsDAO bbsDAO = new BbsDAO();
				//write함수를 실행해서 실제로 게시글을 작성 할 수 있게한다. 함수(차례대로 매개변수를 넣어준다.) 이러면 아주 간단하게 작동한다.
				int result = bbsDAO.update(bbsID ,request.getParameter("bbsTitle"), request.getParameter("bbsContent"));
				//만약에 함수에 반환된 값이 -1라면 디비오류 발생이니까
				if (result == -1) {
					//실패띄워줌
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("alert('글수정에 실패했습니다')");
					script.println("history.back()");
					script.println("</script>");
				} else {
					//그렇지않으면 성공적으로 글을 작성한 부분이기때문에 게시판 메인화면으로 보낸다.
					PrintWriter script = response.getWriter();
					script.println("<script>");
					script.println("location.href='bbs.jsp'");
					//script.println("history.back()");
					script.println("</script>");
				}
			}
		}
	%>
</body>
</html>
