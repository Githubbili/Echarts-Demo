package com.mapper;

import com.entity.Account;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.Map;

@Mapper
public interface EchartsMapper {
    Account select(String user, String pass);

	Account getUser(String user);

	void update(Account account);

	List<Account> query(Map<String, Object> map);

	void insert(Account account);
}
