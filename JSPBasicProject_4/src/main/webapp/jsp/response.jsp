<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- 169page
		1. JSP에서 사용되는 내장 객체 : 미리 객체가 생성
			request : HttpServletRequest => 요청 정보
			response : HttpServletResponse => 응답 정답
			session : HttpSession 서버에 필요한 데이터 저장
			out : 출력버퍼와 제어
				  ------ 실행 시에 HTML을 저장하는 메모리 공간
				  JspWriter <%= %> => EL ${}
			application : 서버 정보 => ServletContext
			pageContext : 내장 객체 관히 / include / forward
				Pagecontext
				=> <jsp:include> <jsp:forward>
			exception : 예외처리 => Exception
			page : Object => 자신의 객체 (this)
			config : 환경 설정 => web.xml
					ServletConfig
		
		= request : HttpServletRequest
		1) 역할
			http://localhost/JSPBasicProject_4/jsp/response.jsp
			---------------- ----------------------------------
				서버 정보				요청정보 ==> URL
							 ---------------------------------- URL
							 ------------------ ContextPath
			=> 주소창을 통해서 서버로 전송 
			   ----
			  # 서버정보
			  	서버이름 : getServerName()
			  	프로토콜 : getProtocol()
			  	전송방식 : getMethod()
			  			----------- RestFul
			  			=> 다른 프로그램과 연동 : GET / POST / DELETE / PUT
			  			GET : 화면 출력 => SELECT
			  			POST : 데이터를 받아서 저장 => INSERT
			  			DELETE : 삭제 => DELETE
			  			PUT : 수정 => UPDATE
			  			*** web에서는 주로 사용 => GET / POST
			  # 브라우저 정보 
			 ***클라이언트의 IP => getRemoteAddr()
			  	클라이언트의 PORT => getServerPort() => 80
			  					 CI/CD => 8080 /8081 ...
			  	URL	==> getRequestURL()
			 ***URI ==> getRequestURI()
			 ***ContextPath => getContextPath()
			 # 사용자 요청 정보
			 	단일값 읽어오기 : text, password, file, date, radio...
			 	String 변수 = request.getParametwe("name속성값")
			 	다중값 읽기 : checkbox, <select multiple>
			 	String[] 변수 = request.getParameterValues("name속성값");
			 	한글 깨지는 경우 : setCharacterEncoding("UTF-8");
			 	---------------------------------------------
			 	
			 	웹으로 전송 : 인코딩 (byte[])
			 	자바 : %EC%9E%90%EB%B0%94
			 	받는 경우
			 		자바 => 디코딩 => setCharacterEncoding("UTF-8");
			 	Window 11 => 자동 변환
			 	
			 	----------------------------------------------
			 	전송 시 
			 		main.jsp?no=10
			 				key value => key가 중복되면 안된다 => map방식
			 		10을 main.jsp로 전송한다
			 			--------
			 		String no=request.getParameter("no");
			 			   -- 10
			 		**웹에서는 모드 데이터가 String
			 		**메소드의 매개변수에서 받아서 처리
			 		
			 	** 상세보기 : primary key (중복이 없는 값)
			 	** 검색 : 검색어
			 	** 회원가입 => 입력된 데이터 전체 전송
			 	** 로그인 : id/pwd
			 	** 예약 : 맛집 / 예약일 / 예약시간 / 인원
			 	
			 # 추가 정보
			  -------- MVC에서는 데이터베이스 결과값을 추가해서 JSP로 전송
			  *** setAttribute("키",값(object))
			  *** Object getAttribute("키") => 형변환 후 사용
			  주고 받기
			  	  --- 응답 
			  --- 요청
			  
			= response 객체
				======> HttpServletResponse
						-------------------
						응답 : HTML (브라우저로 전송)
							  setContentType("text/html;charset=UTF-8")
							  Cookie 전송
							  addCookie(쿠키명)
							  => 미리 전송 : setHeader
							  	=> 다운로드 시 / JSON 전송
						*** 두개를 동시에 응답 할 수 없다 (파일 한개만 전송이 가능)
						화면 이동 정보 
						sendRedirect("이동할 파일명") : GET
						insert => insert_ok => list
								  ---------
								  sendRedirect("list")
						** 단점 : request를 초기화 
						** 보완 : forward => reuest를 계속 유지 
						** URL주소의 파일명 
--%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

</body>
</html>