package wlzx.bbs.dbc ;

import java.sql.* ;

public class DataBaseConnection {
	private String DBDRIVER = "org.gjt.mm.mysql.Driver" ;
	private String DBURL = "jdbc:mysql://localhost:3306/bbs" ;
	private String DBUSER = "root" ;
	private String DBPASSWORD = "root" ;
	private Connection conn = null ;
	
	public DataBaseConnection() {
		try {
			Class.forName(DBDRIVER) ;
			conn = DriverManager.getConnection(DBURL,DBUSER,DBPASSWORD) ;
		} catch(Exception e) {}
	}
	public Connection getConnection() {
		return conn ;
	}
	public void close() {
		try {
			conn.close() ;
		} catch(Exception e) {}
	}
}