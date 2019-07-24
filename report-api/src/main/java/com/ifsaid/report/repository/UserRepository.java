package com.ifsaid.report.repository;

import java.util.List;

import com.ifsaid.report.entity.User;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends JpaRepository<User, String> {

    User findByAccount(String account);
    
    User findByMail(String mail);

    User findByEmployeeId(String employeeId);

    @Query(value = "select mail from User as u where u.dept = ?1")
    int countByDept(Integer deptId);

    List<User> findByDept(Integer deptId);

    @Query(value = "select count(u) from User as u where u.account = ?1 or u.mail = ?1 ")
    Integer countByAccountOrMail(String account);

}
