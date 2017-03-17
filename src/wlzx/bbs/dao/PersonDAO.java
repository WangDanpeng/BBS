package wlzx.bbs.dao ;

import java.util.List;

import wlzx.bbs.vo.* ;

public interface PersonDAO {
	//做登陆验证
	public boolean login(Person person) throws Exception ;
	//注册新用户
	public void register(Person person) throws Exception ;
	//以id查询
	public Person queryById(int id) throws Exception;
	//查询全部用户
	public List queryAll(int i,int j) throws Exception ;
	//获取总用户个数
	public int number() throws Exception;
	//删除用户
	public void delete_u(int id) throws Exception ;
	//删除用户关联帖子
	public void delete_invi(int id) throws Exception;
	//删除用户关联回复
	public void delete_reply(int id) throws Exception;
	//删除用户关联回复的评论
	public void delete_c(int id) throws Exception;
	//修改用户名
	public void updateName(Person person) throws Exception;
	//修改用户密码
	public void updatePassword(Person person) throws Exception;
	//模糊查询，分页用
	public List queryByLike(String cond,int i,int j) throws Exception;
	//模糊查询
	public List queryByLike(String cond) throws Exception;
	//获取总用户个数
	public int number(String cond) throws Exception;
	//判断是否重复的账户
	public int repeat(String account) throws Exception;
	//上传头像路径
	public void head(int id, String address) throws Exception;
	//判定是否有头像
	public int queryHead(int id) throws Exception;
}