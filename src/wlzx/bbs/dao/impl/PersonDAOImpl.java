package wlzx.bbs.dao.impl ;

import java.sql.* ;
import java.util.ArrayList;
import java.util.List;

import wlzx.bbs.vo.* ;
import wlzx.bbs.dbc.* ;
import wlzx.bbs.dao.* ;

public class PersonDAOImpl implements PersonDAO {
	/*
		功能：
			·判断是否是正确的用户名和密码
			·从数据库中取出用户的真实姓名,Nid和权限
	*/
	public boolean login(Person person) throws Exception {
		boolean flag = false ;
		String sql = "SELECT Nid,name,authority FROM person WHERE account=? and password=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setString(1,person.getAccount()) ;
			pstmt.setString(2,person.getPassword()) ;
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				flag = true ;
				person.setNid(rs.getInt(1)) ;
				person.setName(rs.getString(2)) ;
				person.setAuthority(rs.getInt(3));
				
			}
			rs.close() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("操作出错") ;
		} finally {
			dbc.close() ;
		}
		return flag ;
	}
	//注册新用户
	public void register(Person person) throws Exception {
		String sql = "INSERT INTO person(Nid,name,account,password) VALUES(Nid,?,?,?)" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setString(1,person.getName()) ;
			pstmt.setString(2,person.getAccount()) ;
			pstmt.setString(3,person.getPassword()) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("注册出错") ;
		} finally {
			dbc.close() ;
		}
	}
	//以id查询
	public Person queryById(int id) throws Exception {
		Person person = null ;
		String sql = "SELECT Nid,name,password FROM person WHERE Nid=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
			ResultSet rs = pstmt.executeQuery() ;
			if(rs.next()) {
				person = new Person() ;
				person.setNid(rs.getInt(1));
				person.setName(rs.getString(2)) ;
				person.setPassword(rs.getString(3)) ;
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("id查询出错") ;
		} finally {
			dbc.close() ;
		}
		return person ;
	}
	//查询全部用户
	public List queryAll(int i,int j) throws Exception {
		List all = new ArrayList() ;
		String sql = "SELECT Nid,name,account,password,authority from person limit ?, ?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1, j);
			pstmt.setInt(2, i);
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Person person = new Person() ;
				person.setNid(rs.getInt(1)) ;
				person.setName(rs.getString(2)) ;
				person.setAccount(rs.getString(3)) ;
				person.setPassword(rs.getString(4)) ;
				person.setAuthority(rs.getInt(5)) ;
				all.add(person) ;
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("查询全部用户出错") ;
		} finally {
			dbc.close() ;
		}
		return all ;
	}
	//模糊查询，分页用
	public List queryByLike(String cond,int i,int j) throws Exception {
		List all = new ArrayList() ;
		String sql = "SELECT Nid,name,account,password,authority FROM person WHERE name like ? or account like ? limit ?, ?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setString(1,"%"+cond+"%") ;
			pstmt.setString(2,"%"+cond+"%") ;
			pstmt.setInt(3, j);
			pstmt.setInt(4, i);
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Person person = new Person() ;
				person.setNid(rs.getInt(1)) ;
				person.setName(rs.getString(2)) ;
				person.setAccount(rs.getString(3)) ;
				person.setPassword(rs.getString(4)) ;
				person.setAuthority(rs.getInt(5)) ;
				all.add(person) ;
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("操作出错") ;
		} finally {
			dbc.close() ;
		}
		return all ;
	}
	//模糊查询
	public List queryByLike(String cond) throws Exception {
		List all = new ArrayList() ;
		String sql = "SELECT Nid,name,account,password,authority FROM person WHERE name like ? or account like ?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setString(1,"%"+cond+"%") ;
			pstmt.setString(2,"%"+cond+"%") ;
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Person person = new Person() ;
				person.setNid(rs.getInt(1)) ;
				person.setName(rs.getString(2)) ;
				person.setAccount(rs.getString(3)) ;
				person.setPassword(rs.getString(4)) ;
				person.setAuthority(rs.getInt(5)) ;
				all.add(person) ;
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("操作出错") ;
		} finally {
			dbc.close() ;
		}
		return all ;
	}
	//获取总用户个数
	public int number() throws Exception {
		int a = 0;
		String sql = "SELECT count(*) FROM person" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			ResultSet rs = pstmt.executeQuery() ;
			if(rs.next()) {
				a = rs.getInt(1);
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("记录个数读取出错") ;
		} finally {
			dbc.close() ;
		}
		return a;
	}
	//获取模糊查询用户个数
	public int number(String cond) throws Exception {
		int a = 0;
		String sql = "SELECT count(*) FROM person WHERE name like ? or account like ?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setString(1,"%"+cond+"%") ;
			pstmt.setString(2,"%"+cond+"%") ;
			ResultSet rs = pstmt.executeQuery() ;
			if(rs.next()) {
				a = rs.getInt(1);
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("记录个数读取出错") ;
		} finally {
			dbc.close() ;
		}
		return a;
	}
	//删除用户
	public void delete_u(int id) throws Exception {
		String sql = "DELETE FROM person WHERE Nid=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("删除出错") ;
		} finally {
			dbc.close() ;
		}
}
	//删除用户相关帖子
	public void delete_invi(int id) throws Exception {
		String sql = "DELETE FROM t_invitation WHERE person_id=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("删除出错") ;
		} finally {
			dbc.close() ;
		}
	}
	//删除用户相关回复
	public void delete_reply(int id) throws Exception {
		String sql = "DELETE FROM t_reply WHERE person_id=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("删除出错") ;
		} finally {
			dbc.close() ;
		}
	}
	//删除用户关联回复的评论
	public void delete_c(int id) throws Exception {
		String sql = "DELETE FROM t_comment WHERE person_id=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("删除出错") ;
		} finally {
			dbc.close() ;
		}
	}
	//修改用户名
	public void updateName(Person person) throws Exception {
		String sql = "UPDATE person SET name=? WHERE Nid=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setString(1,person.getName()) ;
			pstmt.setInt(2,person.getNid()) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("操作出错") ;
		} finally {
			dbc.close() ;
		}
	}
	//修改用户密码
	public void updatePassword(Person person) throws Exception {
		String sql = "UPDATE person SET password=? WHERE Nid=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setString(1,person.getPassword()) ;
			pstmt.setInt(2,person.getNid()) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("操作出错") ;
		} finally {
			dbc.close() ;
		}
	}
	//判断是否重复的账户
	public int repeat(String account) throws Exception {
		int a = 0;
		String sql = "SELECT count(*) FROM person WHERE account=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setString(1, account);
			ResultSet rs = pstmt.executeQuery() ;
			if(rs.next()) {
				a = rs.getInt(1);
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("判定账号是否重复出错") ;
		} finally {
			dbc.close() ;
		}
		return a;
	}
	//上传头像路径
	public void head(int id, String address) throws Exception {
		String sql = "INSERT INTO head(userid,address) VALUES(?,?)" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
			pstmt.setString(2,address) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("操作出错") ;
		} finally {
			dbc.close() ;
		}
	}
	//判定是否有头像
	public int queryHead(int id) throws Exception {
		int a = 0;
		String sql = "SELECT count(*) FROM head WHERE userid=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery() ;
			if(rs.next()) {
				a = rs.getInt(1);
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("判定是否有头像出错") ;
		} finally {
			dbc.close() ;
		}
		return a;
	}
}