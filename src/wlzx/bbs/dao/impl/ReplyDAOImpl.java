package wlzx.bbs.dao.impl ;

import java.sql.* ;
import java.util.* ;

import wlzx.bbs.vo.* ;
import wlzx.bbs.dao.* ;
import wlzx.bbs.dbc.* ;

public class ReplyDAOImpl implements ReplyDAO {
	//回复
	public void insert(Reply reply) throws Exception {
		String sql = "insert into t_reply(Nid,author,content,invitation_id,time,person_id,floor,see,invi_user_id) values(Nid,?,?,?,now(),?,?,?,?)" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setString(1,reply.getAuthor()) ;
			pstmt.setString(2,reply.getContent()) ;
			pstmt.setInt(3,reply.getInvitation_id()) ;
			pstmt.setInt(4,reply.getPerson_id()) ;
			pstmt.setInt(5,reply.getFloor()) ;
			pstmt.setInt(6,reply.getSee()) ;
			pstmt.setInt(7,reply.getInvi_user_id()) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("增加出错") ;
		} finally {
			dbc.close() ;
		}
	}
	//删除回复
	public void delete(int id) throws Exception {
		String sql = "DELETE FROM t_reply WHERE Nid=?" ;
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
	//删除关联评论
	public void delete_c(int id) throws Exception {
		String sql = "DELETE FROM t_comment WHERE reply_id=?" ;
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
	//查询全部回复
	public List queryAll(int id,int i,int j) throws Exception {
		List all = new ArrayList() ;
		String sql = "SELECT * FROM t_reply where invitation_id=? limit ?, ?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1, id);
			pstmt.setInt(2, j);
			pstmt.setInt(3, i);
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Reply reply = new Reply() ;
				reply.setNid(rs.getInt(1)) ;
				reply.setAuthor(rs.getString(2)) ;
				reply.setContent(rs.getString(3)) ;
				reply.setInvitation_id(rs.getInt(4)) ;
				reply.setTime(rs.getString(5)) ;
				reply.setPerson_id(rs.getInt(6)) ;
				reply.setFloor(rs.getInt(7)) ;
				reply.setSee(rs.getInt(8)) ;
				reply.setInvi_user_id(rs.getInt(9)) ;
				all.add(reply) ;
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("查询全部出错") ;
		} finally {
			dbc.close() ;
		}
		return all ;
	}
	//查询全部回复
	public List queryAll(int id) throws Exception {
		List all = new ArrayList() ;
		String sql = "SELECT * FROM t_reply where invitation_id=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Reply reply = new Reply() ;
				reply.setNid(rs.getInt(1)) ;
				reply.setAuthor(rs.getString(2)) ;
				reply.setContent(rs.getString(3)) ;
				reply.setInvitation_id(rs.getInt(4)) ;
				reply.setTime(rs.getString(5)) ;
				reply.setPerson_id(rs.getInt(6)) ;
				reply.setFloor(rs.getInt(7)) ;
				reply.setSee(rs.getInt(8)) ;
				reply.setInvi_user_id(rs.getInt(9)) ;
				all.add(reply) ;
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("查询全部出错") ;
		} finally {
			dbc.close() ;
		}
		return all ;
	}
	//查询全部
	public List queryAll() throws Exception {
		List all = new ArrayList() ;
		String sql = "SELECT * FROM t_reply order by time desc" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Reply reply = new Reply() ;
				reply.setNid(rs.getInt(1)) ;
				reply.setAuthor(rs.getString(2)) ;
				reply.setContent(rs.getString(3)) ;
				reply.setInvitation_id(rs.getInt(4)) ;
				reply.setTime(rs.getString(5)) ;
				reply.setPerson_id(rs.getInt(6)) ;
				reply.setFloor(rs.getInt(7)) ;
				reply.setSee(rs.getInt(8)) ;
				reply.setInvi_user_id(rs.getInt(9)) ;
				all.add(reply) ;
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("查询全部出错") ;
		} finally {
			dbc.close() ;
		}
		return all ;
	}
	//以id查询楼层
	public int queryFloor(int id) throws Exception {
		int a = 0;
		String sql = "SELECT floor FROM t_reply where Nid=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
			ResultSet rs = pstmt.executeQuery() ;
			if(rs.next()) {
				a = rs.getInt(1);
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("查询楼层出错") ;
		} finally {
			dbc.close() ;
		}
		return a ;
	}
	//查询全部未读回复
	public List queryUnread(int id) throws Exception {
		List all = new ArrayList() ;
		String sql = "SELECT author,content,invitation_id,time,Nid,floor,person_id FROM t_reply where invi_user_id=? and see=0 order by time desc" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1, id);
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Reply reply = new Reply() ;
				reply.setAuthor(rs.getString(1)) ;
				reply.setContent(rs.getString(2)) ;
				reply.setInvitation_id(rs.getInt(3)) ;
				reply.setTime(rs.getString(4)) ;
				reply.setNid(rs.getInt(5)) ;
				reply.setFloor(rs.getInt(6)) ;
				reply.setPerson_id(rs.getInt(7)) ;
				all.add(reply) ;
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("查询全部出错") ;
		} finally {
			dbc.close() ;
		}
		return all ;
	}	
	//获取总回复个数
	public int number(int id) throws Exception {
		int a = 0;
		String sql = "SELECT count(*) FROM t_reply where invitation_id=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
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
	//获取未读回复个数
	public int numberUnread(int id) throws Exception {
		int a = 0;
		String sql = "SELECT count(*) FROM t_reply where invi_user_id=? and see=0" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
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
	//设置回复已读
	public void update(Reply reply) throws Exception {
		String sql = "UPDATE t_reply SET see=? WHERE Nid=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,reply.getSee()) ;
			pstmt.setInt(2,reply.getNid()) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("操作出错") ;
		} finally {
			dbc.close() ;
		}
	}
}