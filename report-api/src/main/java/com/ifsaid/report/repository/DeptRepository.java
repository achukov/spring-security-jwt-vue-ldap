package com.ifsaid.report.repository;

import com.ifsaid.report.entity.Dept;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface DeptRepository extends JpaRepository<Dept, Integer> {

    int countByParentId(Integer parentId);

}
