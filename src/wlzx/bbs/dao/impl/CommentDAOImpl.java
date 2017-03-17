package wlzx.bbs.dao.impl ;

import java.sql.* ;
import java.util.* ;

import wlzx.bbs.vo.* ;
import wlzx.bbs.dao.* ;
import wlzx.bbs.dbc.* ;

public class CommentDAOImpl implements CommentDAO {
	//回复
	public void insert(Comment comment) throws Exception {
		String sql = "INSERT INTO t_comment(Nid,author,content,invitation_id,time,person_id,reply_id,see,invi_user_id,reply_user_id) VALUES(Nid,?,?,?,now(),?,?,?,?,?)" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setString(1,comment.getAuthor()) ;
			pstmt.setString(2,comment.getContent()) ;
			pstmt.setInt(3,comment.getInvitation_id()) ;
			pstmt.setInt(4,comment.getPerson_id()) ;
			pstmt.setInt(5,comment.getReply_id()) ;
			pstmt.setInt(6,comment.getSee()) ;
			pstmt.setInt(7,comment.getInvi_user_id()) ;
			pstmt.setInt(8,comment.getReply_user_id()) ;
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
		String sql = "DELETE FROM t_comment WHERE Nid=?" ;
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
	public List queryAll() throws Exception {
		List all = new ArrayList() ;
		String sql = "SELECT Nid,author,content,time,invitation_id,person_id,reply_id,see,invi_user_id,reply_user_id FROM t_comment" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Comment comment = new Comment() ;
				comment.setNid(rs.getInt(1)) ;
				comment.setAuthor(rs.getString(2)) ;
				comment.setContent(rs.getString(3)) ;
				comment.setTime(rs.getString(4)) ;
				comment.setInvitation_id(rs.getInt(5)) ;
				comment.setPerson_id(rs.getInt(6)) ;
				comment.setReply_id(rs.getInt(7)) ;
				comment.setSee(rs.getInt(8)) ;
				comment.setInvi_user_id(rs.getInt(9)) ;
				comment.setReply_user_id(rs.getInt(10)) ;
				all.add(comment) ;
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
		String sql = "SELECT Nid,author,content,time,invitation_id,person_id,reply_id,see,invi_user_id,reply_user_id FROM t_comment where reply_id = ?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Comment comment = new Comment() ;
				comment.setNid(rs.getInt(1)) ;
				comment.setAuthor(rs.getString(2)) ;
				comment.setContent(rs.getString(3)) ;
				comment.setTime(rs.getString(4)) ;
				comment.setInvitation_id(rs.getInt(5)) ;
				comment.setPerson_id(rs.getInt(6)) ;
				comment.setReply_id(rs.getInt(7)) ;
				comment.setSee(rs.getInt(8)) ;
				comment.setInvi_user_id(rs.getInt(9)) ;
				comment.setReply_user_id(rs.getInt(10)) ;
				all.add(comment) ;
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
	//获取未读回复个数
	public int numberUnreadI(int id) throws Exception {
		int a = 0;
		String sql = "SELECT count(*) FROM t_comment where invi_user_id=? and see=0 or see=2 and invi_user_id=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
			pstmt.setInt(2,id) ;
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
	public int numberUnreadR(int id) throws Exception {
		int a = 0;
		String sql = "SELECT count(*) FROM t_comment where see=0 and reply_user_id=? or see=1 and reply_user_id=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
			pstmt.setInt(2,id) ;
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
	//查询全部未读回复
	public List queryUnreadI(int id) throws Exception {
		List all = new ArrayList() ;
		String sql = "SELECT author,content,invitation_id,time,Nid,reply_id FROM t_comment where invi_user_id=? and see=0 or see=2 and invi_user_id=? order by time desc" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1, id);
			pstmt.setInt(2, id);
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Comment comment = new Comment() ;
				comment.setAuthor(rs.getString(1)) ;
				comment.setContent(rs.getString(2)) ;
				comment.setInvitation_id(rs.getInt(3)) ;
				comment.setTime(rs.getString(4)) ;
				comment.setNid(rs.getInt(5)) ;
				comment.setReply_id(rs.getInt(6)) ;
				all.add(comment) ;
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
	//查询全部未读回复
	public List queryUnreadR(int id) throws Exception {
		List all = new ArrayList() ;
		String sql = "SELECT author,content,invitation_id,time,Nid,reply_id FROM t_comment where reply_user_id=? and see=0 or see=1 and reply_user_id=? order by time desc" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1, id);
			pstmt.setInt(2, id);
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Comment comment = new Comment() ;
				comment.setAuthor(rs.getString(1)) ;
				comment.setContent(rs.getString(2)) ;
				comment.setInvitation_id(rs.getInt(3)) ;
				comment.setTime(rs.getString(4)) ;
				comment.setNid(rs.getInt(5)) ;
				comment.setReply_id(rs.getInt(6)) ;
				all.add(comment) ;
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
	//设置回复已读
	public void update(Comment comment) throws Exception {
		String sql = "UPDATE t_comment SET see=? WHERE Nid=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,comment.getSee()) ;
			pstmt.setInt(2,comment.getNid()) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("操作出错") ;
		} finally {
			dbc.close() ;
		}
	}
}