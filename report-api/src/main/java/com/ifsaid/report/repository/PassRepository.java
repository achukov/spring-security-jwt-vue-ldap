package com.ifsaid.report.repository;

import com.ifsaid.report.entity.Pass;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface PassRepository extends JpaRepository<Pass, Long> {

    @Query(value = "select a from Pass as a where a.state = 1 and a.categoryId =:categoryId ")
    Page<Pass> findAllByCategoryId(Pageable page, @Param("categoryId") Integer categoryId);

    @Query("select a from Pass as a where "
            + " a.visitors like (CONCAT( '%', LOWER(:search), '%')) or"
            + " a.contactperson like (CONCAT( '%', LOWER(:search), '%')) or"
            + " a.phonenumber like (CONCAT( '%', LOWER(:search), '%')) or"
            + " a.carnumber like (CONCAT( '%', LOWER(:search), '%')) or"
            + " a.cartype like (CONCAT( '%', LOWER(:search), '%'))")
    Page<Pass> findAllBySearch(Pageable page, @Param("search") String search);

    @Query(value = "select a from Pass as a where a.createdBy =:createdBy ")
    Page<Pass> findAllbyAuthor(Pageable page, @Param("createdBy") String createdBy);

    @Query("select a from Pass as a where "
            + " (a.visitors like (CONCAT( '%', LOWER(:search), '%')) or"
            + " a.contactperson like (CONCAT( '%', LOWER(:search), '%')) or"
            + " a.phonenumber like (CONCAT( '%', LOWER(:search), '%')) or"
            + " a.carnumber like (CONCAT( '%', LOWER(:search), '%')) or"
            + " a.cartype like (CONCAT( '%', LOWER(:search), '%')))"
            + " and a.createdBy =:createdBy")
    Page<Pass> findAllByAuthorAndSearch(Pageable page, @Param("search") String search, @Param("createdBy") String createdBy);

}
