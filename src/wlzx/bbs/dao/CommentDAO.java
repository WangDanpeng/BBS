package wlzx.bbs.dao ;

import java.util.* ;

import wlzx.bbs.vo.* ;

public interface CommentDAO {
	//增加
	public void insert(Comment comment) throws Exception ;
	//删除
	public void delete(int id) throws Exception ;
	//查询全部
	public List queryAll() throws Exception ;
	//查询全部回复
	public List queryAll(int id) throws Exception;
	//获取未读回复个数
	public int numberUnreadI(int id) throws Exception;
	//获取未读回复个数
	public int numberUnreadR(int id) throws Exception;
	//查询全部未读回复
	public List queryUnreadI(int id) throws Exception;
	//查询全部未读回复
	public List queryUnreadR(int id) throws Exception;
	//设置回复已读
	public void update(Comment comment) throws Exception;
}