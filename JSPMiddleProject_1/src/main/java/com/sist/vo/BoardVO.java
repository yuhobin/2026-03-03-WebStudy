package com.sist.vo;
import lombok.*;
import java.util.*;
@Data
public class BoardVO {
	private int no, hit;
	private String name, subject, content, pwd, dbday;
	private Date regdate;
}
