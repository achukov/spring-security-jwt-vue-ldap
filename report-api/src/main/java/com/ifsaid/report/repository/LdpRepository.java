package com.ifsaid.report.repository;

import com.ifsaid.report.entity.Ldp;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface LdpRepository extends JpaRepository<Ldp, Long> {

//     @Query(value = "select a from Ldp as a where a.state = 1 and a.categoryId =:categoryId ")
//     Page<Ldp> findAllByCategoryId(Pageable page, @Param("categoryId") Integer categoryId);

    @Query("select a from Ldp as a where a.price like (CONCAT( '%', LOWER(:search), '%'))")
    Page<Ldp> findAllBySearch(Pageable page, @Param("search") String search);

//     @Query(value = "select a from ldp as a where a.createdBy =:createdBy ")
//     Page<Ldp> findAllbyAuthor(Pageable page, @Param("createdBy") String createdBy);

}
