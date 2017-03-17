package wlzx.bbs.factory ;

import wlzx.bbs.dao.* ;
import wlzx.bbs.dao.impl.* ;

public class DAOFactory {
	public static PersonDAO getPersonDAOInstance() {
		return new PersonDAOImpl() ;
	}
	public static InvitationDAO getInvitationDAOInstance() {
		return new InvitationDAOImpl() ;
	}
	public static ReplyDAO getReplyDAOInstance() {
		return new ReplyDAOImpl() ;
	}
	public static CommentDAO getCommentDAOInstance() {
		return new CommentDAOImpl() ;
	}
}