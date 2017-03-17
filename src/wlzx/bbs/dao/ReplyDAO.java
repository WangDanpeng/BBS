package wlzx.bbs.dao ;

import java.util.* ;

import wlzx.bbs.vo.* ;

public interface ReplyDAO {
	//增加
	public void insert(Reply reply) throws Exception ;
	//删除
	public void delete(int id) throws Exception ;
	//删除关联评论
	public void delete_c(int id) throws Exception;
	//查询全部，分页用
	public List queryAll(int id,int i,int j) throws Exception ;
	//查询全部
	public List queryAll() throws Exception ;
	//查询全部未读回复
	public List queryUnread(int id) throws Exception ;
	//获取总回复个数
	public int number(int id) throws Exception;
	//获取未读回复个数
	public int numberUnread(int id) throws Exception;
	//设置回复已读
	public void update(Reply reply) throws Exception;
	//以id查询楼层
	public int queryFloor(int id) throws Exception;
	//查询全部回复
	public List queryAll(int id) throws Exception;
}