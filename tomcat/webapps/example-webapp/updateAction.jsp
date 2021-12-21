<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import ="bbs.BbsDAO" %>
<%@ page import ="bbs.Bbs" %>
<%@ page import ="java.io.*" %>
<% request.setCharacterEncoding("utf-8"); %>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<title>web site</title>
</head>

<body>
<% 

		String userId=null;
		if(session.getAttribute("userId")!=null)
		{
			userId=(String)session.getAttribute("userId");
		}
		
		String bbsTitle=null;
		if(request.getParameter("title") !=null)//전 페이지에서 title을 가지고 넘어옴
		{
			bbsTitle=request.getParameter("title");
			//System.out.println(bbsTitle);
		}
		if(bbsTitle==null)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 글 입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		
		Bbs bbs= new BbsDAO().getBbs(bbsTitle);
		
		if(!userId.equals(bbs.getUserId())){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		//로그인이 된 경우
		else{//일정이름, 일정날짜, 일정 중요도를 안썻다면
			if(request.getParameter("title")==null||request.getParameter("date")==null||request.getParameter("weight")==null||request.getParameter("info")==null)
			{
				PrintWriter script=response.getWriter();
				script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
				script.println("alert('쓰지 않은 사항이 있습니다.')"); //이런 스크립트문장을 자동적으로 생성
				script.println("history.back()"); //join으로 다시 이동
				script.println("</script>");
			}
			else
			{//다 잘 썻다면
				BbsDAO bbsDAO = new BbsDAO();
				int result = bbsDAO.update(request.getParameter("title"),request.getParameter("info"),request.getParameter("date"),request.getParameter("weight"));//유저 정보를 db에 넣는다.
				
				if(result==-1){//db오류 
					PrintWriter script=response.getWriter();
					script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
					script.println("alert('일정수정에 실패했습니다.')"); //main으로 이동
					script.println("history.back()"); //이전 페이지로 다시보내버림->update.jsp
					script.println("</script>");
				}
				
				else{//작성된 글 정보를 db에 잘 넣음
					PrintWriter script=response.getWriter();
					script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
					script.println("location.href='bbs.jsp'"); //일정목록으로 돌아감
					script.println("</script>");
				}
				
			}
			
		}
	
		
	%>
</body>
</html>