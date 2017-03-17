package wlzx.bbs.vo ;

public class Person {
	private int Nid ;
	private String name ;
	private String account ;
	private String password ;
	private int authority ;
	
	public void setNid(int Nid) {
		this.Nid = Nid ;
	}
	public void setName(String name) {
		this.name = name ;
	}
	public void setPassword(String password) {
		this.password = password ;
	}
	
	public int getNid() {
		return Nid ;
	}
	public String getName() {
		return name ;
	}
	public String getPassword() {
		return password ;
	}
	public String getAccount() {
		return account;
	}
	public void setAccount(String account) {
		this.account = account;
	}
	public int getAuthority() {
		return authority;
	}
	public void setAuthority(int authority) {
		this.authority = authority;
	}
}