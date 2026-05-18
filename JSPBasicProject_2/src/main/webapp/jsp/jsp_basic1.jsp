<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%--
	1. JSP 구조 (동작 방식)
	2. 지시자 
		page / include / taglib
	3. 스크립트릿
		<% %>, <%= %>, <%! %>
	4. 내장 객체
		request / response / session / pageContext / out
		application / config / exception / page
		=> 미리 객체 생성이 되어 있다
	5. 상태 관리 => 데이터 관리 : session / cookie
	6. 데이터베이스 연동 : JDBC / ConnectionPool
	7. 활용 => 간단한 사이트 (게시판, 로그인, 회원 관리)
	8. JSTL / EL
	9. MVC ==> Sprig 
	
	----------------------------------------------
	자바 
		1. 변수 / 데이터형 정리
			int, boolean, double
		2. 일차원 배열
		3. 연산자 / 제어문 (if, while, for)
			산술 / 증감 / 형변환 / 비교 / 논리 / 대입
		4. 메소드
		5. 객체 지향 프로그램
			=> 캡슐화, 오버라이딩, 인터페이스
		6. 라이브러리
			=> String / Wrapper / StringTokenizer / Math
			=> FileInputStream / FileOutputStream
				FileReader, BufferdReader
			=> java.sql => Connection / Resulset / Statement
			
		60page JSP의 동작 과정 
		1. 브라우저에서 URL을 이용해서 요청 
			=> 반드시 파일명 요청 => 파일을 찾아서 보여 달라
			=> 데이터 전송 URL?
		2. 웹 서버에서 요청을 받는다 
			html / css / json / xml => 웹서버 자체에서 분리
			jsp / servlet => 톰켓으로 전송
							 --
							 자바 컴파일 => 실행 => HTML을 브라우저에서 읽는 메모리에 저장
							 1) 자바로 변경 : a.jsp = >a_jsp.java
							 2) 변경된 자바 컴파일 : a_jsp.class
							 3) 실행
							 	out.write("<html>") => HTML을 메모리에 저장
							 						  -----------------
							 						  출력 버퍼 => 브라우저에서 읽어가는 위치
							 4) 출력버퍼에 저장된 html을 브라우저에서 읽어서 출력
		71page JSP의 생명주기
		1. _jspInit() : 초기화 => web.xml에 필요한 설정 => 자동으로 읽어 간다
				|
		2. _jspService() : JSP코딩이 되는 영역
				|			화면 / 출력을 담당
		3. _jspDestory() : 메모리 해제
		
		4. jspService() {
			JSP에서 코딩된 HTML을 
			out.write("<html>")
			---------- 생략된다
		}
		-------------------------배포 시에 소스를 통쨰로 전송 : 보안에 노출
								=> 회사 : 유지보수
								=> 화면만 출력 : Front
		
			
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