package wlzx.bbs.dao.impl ;

import java.sql.* ;
import java.util.* ;

import wlzx.bbs.vo.* ;
import wlzx.bbs.dao.* ;
import wlzx.bbs.dbc.* ;

public class InvitationDAOImpl implements InvitationDAO {
	//增加
	public void insert(Invitation invitation) throws Exception {
		String sql = "INSERT INTO t_invitation(Nid,title,author,content,time,person_id,showtime) VALUES(Nid,?,?,?,now(),?,now())" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setString(1,invitation.getTitle()) ;
			pstmt.setString(2,invitation.getAuthor()) ;
			pstmt.setString(3,invitation.getContent()) ;
			pstmt.setInt(4,invitation.getPerson_id()) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("增加出错") ;
		} finally {
			dbc.close() ;
		}
	}
	//删除
	public void delete(int id) throws Exception {
		String sql = "DELETE FROM t_invitation WHERE Nid=?" ;
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
	//删除关联回复
	public void deleteReply(int id) throws Exception {
		String sql = "DELETE FROM t_reply WHERE invitation_id=?" ;
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
	//删除关联回复的评论
	public void delete_c(int id) throws Exception {
		String sql = "DELETE FROM t_comment WHERE invitation_id=?" ;
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
	//以id查询
	public Invitation queryById(int id) throws Exception {
		Invitation invitation = null ;
		String sql = "SELECT Nid,title,author,content,time,person_id,showtime FROM t_invitation WHERE Nid=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
			ResultSet rs = pstmt.executeQuery() ;
			if(rs.next()) {
				invitation = new Invitation() ;
				invitation.setNid(rs.getInt(1)) ;
				invitation.setTitle(rs.getString(2)) ;
				invitation.setAuthor(rs.getString(3)) ;
				invitation.setContent(rs.getString(4)) ;
				invitation.setTime(rs.getString(5)) ;
				invitation.setPerson_id(rs.getInt(6)) ;
				invitation.setShowtime(rs.getString(7)) ;
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("id查询出错") ;
		} finally {
			dbc.close() ;
		}
		return invitation ;
	}
	//查询全部记录,分页用
	public List queryAll(int i,int j) throws Exception {
		List all = new ArrayList() ;
		String sql = "SELECT * FROM t_invitation order by showtime desc limit ?, ?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1, j);
			pstmt.setInt(2, i);
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Invitation invitation = new Invitation() ;
				invitation.setNid(rs.getInt(1)) ;
				invitation.setAuthor(rs.getString(2)) ;
				invitation.setTitle(rs.getString(3)) ;
				invitation.setContent(rs.getString(4)) ;
				invitation.setTime(rs.getString(5)) ;
				invitation.setPerson_id(rs.getInt(6)) ;
				invitation.setShowtime(rs.getString(7)) ;
				all.add(invitation) ;
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
		String sql = "SELECT * FROM t_invitation order by time desc" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			ResultSet rs = pstmt.executeQuery() ;
			while(rs.next()) {
				Invitation invitation = new Invitation() ;
				invitation.setNid(rs.getInt(1)) ;
				invitation.setAuthor(rs.getString(2)) ;
				invitation.setTitle(rs.getString(3)) ;
				invitation.setContent(rs.getString(4)) ;
				invitation.setTime(rs.getString(5)) ;
				invitation.setPerson_id(rs.getInt(6)) ;
				all.add(invitation) ;
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
	//获取总用户个数
	public int number() throws Exception {
		int a = 0;
		String sql = "SELECT count(*) FROM t_invitation" ;
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
	//更新帖子最新回复时间
	public void update(Invitation invi) throws Exception {
		String sql = "UPDATE t_invitation SET showtime=? WHERE Nid=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setString(1,invi.getShowtime()) ;
			pstmt.setInt(2,invi.getNid()) ;
			pstmt.executeUpdate() ;
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("操作出错") ;
		} finally {
			dbc.close() ;
		}
	}
	//获取帖子回复个数
	public int numberReply(int id) throws Exception {
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
	//获取帖子回复的评论个数
	public int numberComment(int id) throws Exception {
		int a = 0;
		String sql = "SELECT count(*) FROM t_comment where invitation_id=?" ;
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
	/*//以id查询客户端
	public String queryClient(int id) throws Exception {
		String a = "";
		String sql = "SELECT client FROM client WHERE id=?" ;
		PreparedStatement pstmt = null ;
		DataBaseConnection dbc = null ;
		dbc = new DataBaseConnection() ;
		try {
			pstmt = dbc.getConnection().prepareStatement(sql) ;
			pstmt.setInt(1,id) ;
			ResultSet rs = pstmt.executeQuery() ;
			if(rs.next()) {
				a = rs.getString(1);
			}
			rs.close();
			pstmt.close() ;
		} catch(Exception e) {
			throw new Exception("id查询出错") ;
		} finally {
			dbc.close() ;
		}
		return a ;
	}*/
}