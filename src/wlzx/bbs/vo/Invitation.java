package wlzx.bbs.vo ;

public class Invitation {
	private int Nid ;
	private String title ;
	private String author ;
	private String content ;
	private String time ;
	private int person_id ;
	private String showtime ;
	
	public void setNid(int Nid) {
		this.Nid = Nid ;
	}
	public void setTitle(String title) {
		this.title = title ;
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
	public String getTitle() {
		return title ;
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
	public int getPerson_id() {
		return person_id;
	}
	public void setPerson_id(int person_id) {
		this.person_id = person_id;
	}
	public String getShowtime() {
		return showtime;
	}
	public void setShowtime(String showtime) {
		this.showtime = showtime;
	}
	
}