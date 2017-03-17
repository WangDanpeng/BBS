package wlzx.bbs.dao ;

import java.util.* ;

import wlzx.bbs.vo.* ;

public interface InvitationDAO {
	//增加
	public void insert(Invitation invi) throws Exception ;
	//删除
	public void delete(int id) throws Exception ;
	//删除关联回复
	public void deleteReply(int id) throws Exception ;
	//删除关联回复的评论
	public void delete_c(int id) throws Exception;
	//以id查询
	public Invitation queryById(int id) throws Exception ;
	//查询全部,分页用
	public List queryAll(int i,int j) throws Exception ;
	//查询全部
	public List queryAll() throws Exception;
	//获取总用户个数
	public int number() throws Exception;
	//修改
	public void update(Invitation invi) throws Exception;
	//获取帖子回复个数
	public int numberReply(int id) throws Exception;
	//获取帖子回复的评论个数
	public int numberComment(int id) throws Exception;
	/*//以id查询客户端
	public String queryClient(int id) throws Exception;*/
}