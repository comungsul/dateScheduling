<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import= "java.sql.*"%>
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
		if(request.getParameter("title") !=null)//bbs.jsp에서 글을 눌러 view로 넘어오는데 title을 가지고 넘어옴
		{
			bbsTitle=request.getParameter("title");
			
		}
		if(bbsTitle==null)
		{
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('존재하지 않는 글 입니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		
		//Bbs bbs= new BbsDAO().getBbs(bbsTitle);
		
	
		String id=null;
	
	
		
		try {
			  ResultSet rs;
		          Connection conn;
		          String SQL= "SELECT * FROM duty WHERE title = ?";
			  String DB_URL="jdbc:mysql://db:3306/example_db?useSSL=false&autoReconnect=true&characterEncoding=utf8";
                         String DB_USER="example_db_user";
                         String DB_PASSWORD="example_db_pass";
                         Class.forName("com.mysql.jdbc.Driver");
                         conn=DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			  
			  PreparedStatement pstmt=conn.prepareStatement(SQL);
			  pstmt.setString(1,bbsTitle);
			  rs=pstmt.executeQuery();
			  
			  while(rs.next())
			  {
				  //title ,info, id, date, weight
				  
				  id=rs.getString(3);
				  
			  }
		}catch(Exception e) {
			e.printStackTrace();
		}
		
		if(!userId.equals(id)){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('권한이 없습니다.')");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
		//로그인이 된 경우
		else{
				//BbsDAO bbsDAO = new BbsDAO();
				int result = -6030;
				try {
			 		ResultSet rs;
		          		Connection conn;
					String SQL="DELETE FROM `duty` WHERE(`title`=?);";
			  		String DB_URL="jdbc:mysql://db:3306/example_db?useSSL=false&autoReconnect=true&characterEncoding=utf8";
                         		String DB_USER="example_db_user";
                        		String DB_PASSWORD="example_db_pass";
                         		Class.forName("com.mysql.jdbc.Driver");
                         		conn=DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
			  		
			  		PreparedStatement pstmt=conn.prepareStatement(SQL);
			  		pstmt.setString(1,bbsTitle);
			  		result=pstmt.executeUpdate();
			  
			 
					}catch(Exception e) {
						e.printStackTrace();
								}
		
				
				
				if(result==-6030) result=-1;
				
				if(result==-1){//db오류 
					PrintWriter script=response.getWriter();
					script.println("<script>"); //이런 스크립트문장을 자동적으로 생성
					script.println("alert('일정삭제에 실패했습니다.')"); //main으로 이동
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
			
		
	
		
	%>
</body>
</html>
