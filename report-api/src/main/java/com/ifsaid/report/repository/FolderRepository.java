package com.ifsaid.report.repository;

import java.util.List;

import com.ifsaid.report.entity.Folder;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface FolderRepository extends JpaRepository<Folder, Integer> {

    int countByParentId(Integer parentId);
    
    List<Folder> findByParentId(Integer parentId);

    @Query("select a from Folder a where "
    + " a.owner like (CONCAT( '%', LOWER(:search), '%')) or"
    + " a.ownersubs like (CONCAT( '%', LOWER(:search), '%'))")
    Page<Folder> findAllBySearch(Pageable page, @Param("search") String search);
}
