<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<div class="container">
		<div class="row">
			<h1>JSP 지시자</h1>
			<table class="table">
				<tr>
					<td colspan="2">
						JSP에서 파일(페이지)에 대한 전반적인 설정이나 동작방식 지시하는 명령문
					</td>
				</tr>
				<tr>
					<td colspan="2">
					지시자의 종류
					</td>
				</tr>
				<tr>
					<td>**page</td>
					<td>JSP 페이지에 대한 전체 속성을 설정</td> 	
				</tr>
				<tr>
					<td>include</td>
					<td>JSP 페이지 특정 영역에 다른 JSP를 포함할때 사용 : 정적</td>
				</tr>
				<tr>
					<td>**taglib</td>
					<td>자바의 문법(제어문, 화면이동, 변환, String):태그형 라이브러리</td>
				</tr>
			</table>
			<h1>지시자 속성</h1>
			<table class="table">
				<tr>
					<td colspan="3">
						기본형태 : &lt;%@ page 속성="값"...%gt;
						<br>
						속성="값" 반드시 ""
					</td>
				</tr>
				<tr>
					<td>contentType</td>
					<td>문자 설정 / 브라우저 출력형식을 지정</td>
					<td>html:text/html;charset=UTF-8
						<br>
						xml: test/xml;charset=UTF-8
						<br>
						json: text/plain;charset=UTF-8
					</td>
				</tr>
				<tr>
					<td>import</td>
					<td>java에서 지원 / 사용자 정의 클래스를 읽어 올때 사용</td>
					<td>import="java.util.*,java.sql.*"</td>
				</tr>
				<tr>
					<td>errorPage</td>
					<td>에러가 발생하는 브라우저에 보여주는 파일 => 바로 이동 (forword)</td>
					<td>errorPage="파일명"</td>
				</tr>
				<tr>
					<td>buffer</td>
					<td>default:8kb, HTML 출력에 필요한 메모리 공간 (사용자 당 1개 생성)</td>
					<td>buffer="16kb"</td>
				</tr>
			</table>
		</div>
	</div>
</body>
</html>