package com.sist.dao;
/*
EMPNO    NOT NULL NUMBER(4)    
ENAME             VARCHAR2(10) 
JOB               VARCHAR2(9)  
MGR               NUMBER(4)    
HIREDATE          DATE         
SAL               NUMBER(7,2)  
COMM              NUMBER(7,2)  
DEPTNO            NUMBER(2)    
 * 
 */
import java.util.*;

import lombok.Data;
// => View
// => 독립적으로 사용이 가능
@Data
public class EmpVO {
	private int empno, mgr, sal, comm, deptno;
	private String ename, job, dbday;
	private Date hiredate;
	private DeptVO dvo=new DeptVO();
	// 자바에서 조인은 포함 클래스
	// MyBatis / JPA
}
