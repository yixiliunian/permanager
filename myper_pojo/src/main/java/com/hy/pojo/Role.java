package com.hy.pojo;

import java.io.Serializable;
import java.util.List;

public class Role implements Serializable {

	private Integer roleid;
	private String roleCn;
	private String roleEn;
	private String roleDesc;
	private String roleStatus;
	private List<Priviliage> prilist;
	public Integer getRoleid() {
		return roleid;
	}
	public void setRoleid(Integer roleid) {
		this.roleid = roleid;
	}
	public String getRoleCn() {
		return roleCn;
	}
	public void setRoleCn(String roleCn) {
		this.roleCn = roleCn;
	}
	public String getRoleEn() {
		return roleEn;
	}
	public void setRoleEn(String roleEn) {
		this.roleEn = roleEn;
	}
	public String getRoleDesc() {
		return roleDesc;
	}
	public void setRoleDesc(String roleDesc) {
		this.roleDesc = roleDesc;
	}
	public String getRoleStatus() {
		return roleStatus;
	}
	public void setRoleStatus(String roleStatus) {
		this.roleStatus = roleStatus;
	}
	public List<Priviliage> getPrilist() {
		return prilist;
	}
	public void setPrilist(List<Priviliage> prilist) {
		this.prilist = prilist;
	}
}
