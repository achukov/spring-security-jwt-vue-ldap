package com.ifsaid.report.repository;

import com.ifsaid.report.entity.Database;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface DatabaseRepository extends JpaRepository<Database, Integer> {

    List<Database> findAllByOwner(String region);

    @Query("select a from Database a where "
    + " a.title like (CONCAT( '%', LOWER(:search), '%')) or"
    + " a.path like (CONCAT( '%', LOWER(:search), '%')) or"
    + " a.describe like (CONCAT( '%', LOWER(:search), '%')) or"
    + " a.owner like (CONCAT( '%', LOWER(:search), '%')) or"
    + " a.ownersubs like (CONCAT( '%', LOWER(:search), '%'))")
    Page<Database> findAllBySearch(Pageable page, @Param("search") String search);

}
