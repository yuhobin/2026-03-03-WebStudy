package com.sist.dao;
/*
이름      널?       유형             
------- -------- -------------- 
NO      NOT NULL NUMBER         
NAME    NOT NULL VARCHAR2(51)   
SUBJECT NOT NULL VARCHAR2(2000) 
CONTENT NOT NULL CLOB           
PWD     NOT NULL VARCHAR2(10)   
REGDATE          DATE           
HIT              NUMBER     

한개의 게시물 정보를 저장할 목적 => 사용자 요청 => 한번에 전송

매칭 
	오라클		자바					MySQL/MariaDB
	CHAR
	VARCHAR2	String				VARCHAR
	CLOB							TEXT
	
	NUMBER		int					int
	NUMBER(2,1) double				double
	
	DATE		java.util.Date		DATETIME
	-------------------------		LocalDateTime
			=> 데이터형 / 내장 함수
			=> SQL => 표준화
			=> 문법 / 흐름 (순서) => 모든 언어 사용이 가능
 */
import java.util.*;

import lombok.Data;
// 읽기 (getter) / 쓰기 (setter)
@Data
public class BoardVO {
	private int no, hit;
	private String name, subject, content, pwd, dbday;
	private Date regdate;
}
