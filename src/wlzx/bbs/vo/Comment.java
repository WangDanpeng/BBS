package wlzx.bbs.vo ;

public class Comment {
	private int Nid ;
	private String author ;
	private String content ;
	private String time ;
	private int invitation_id ;
	private int person_id ;
	private int reply_id ;
	private int see ;
	private int invi_user_id ;
	private int reply_user_id ;
	
	public void setNid(int Nid) {
		this.Nid = Nid ;
	}
	public void setAuthor(String author) {
		this.author = author ;
	}
	public void setContent(String content) {
		this.content = content ;
	}
	
	public int getNid() {
		return Nid ;
	}
	public String getAuthor() {
		return author ;
	}
	public String getContent() {
		return content ;
	}
	public String getTime() {
		String a = time.substring(0, 16);
		return a;
	}
	public void setTime(String time) {
		this.time = time;
	}
	public int getInvitation_id() {
		return invitation_id;
	}
	public void setInvitation_id(int invitation_id) {
		this.invitation_id = invitation_id;
	}
	public int getPerson_id() {
		return person_id;
	}
	public void setPerson_id(int person_id) {
		this.person_id = person_id;
	}
	public int getReply_id() {
		return reply_id;
	}
	public void setReply_id(int reply_id) {
		this.reply_id = reply_id;
	}
	public int getSee() {
		return see;
	}
	public void setSee(int see) {
		this.see = see;
	}
	public int getInvi_user_id() {
		return invi_user_id;
	}
	public void setInvi_user_id(int invi_user_id) {
		this.invi_user_id = invi_user_id;
	}
	public int getReply_user_id() {
		return reply_user_id;
	}
	public void setReply_user_id(int reply_user_id) {
		this.reply_user_id = reply_user_id;
	}
}