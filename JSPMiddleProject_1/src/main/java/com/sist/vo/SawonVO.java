package com.sist.vo;
import lombok.*;
// 지금부터는 <%= %>는 사용하지 않는다 => ${}
// 1. Spring / SpringBoot => MVC
@Data
public class SawonVO {
	private int sabun;
	private String name;
	private String dept;
	private String job;
	private String loc;
}
