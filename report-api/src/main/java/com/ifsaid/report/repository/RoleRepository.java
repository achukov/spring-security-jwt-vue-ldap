package com.ifsaid.report.repository;

import com.ifsaid.report.entity.Role;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Set;

@Repository
public interface RoleRepository extends JpaRepository<Role, Integer> {

    @Modifying
    @Query(nativeQuery = true, value = "DELETE FROM tb_role_permission WHERE t_role_id = ?1")
    Integer deleteRolePermissionAll(Integer rid);

    @Modifying
    @Query(nativeQuery = true, value = "DELETE FROM tb_user_role WHERE t_user_id = ?1")
    Integer deleteUserRoleAll(String uid);

    @Modifying
    @Query(nativeQuery = true, value = "INSERT INTO tb_role_permission(t_role_id,t_permission_id) VALUES(?1 , ?2)")
    Integer addRolePermission(Integer rid, Integer pid);

    @Modifying
    @Query(nativeQuery = true, value = "INSERT INTO tb_user_role(t_user_id,t_role_id) VALUES(?1 , ?2)")
    Integer addUserRole(String uid, Integer rid);

    @Modifying
    @Query(nativeQuery = true, value = "SELECT r.t_rid,r.t_name,r.t_describe,r.t_create_time,r.t_up_time,r.t_state FROM tb_role AS r \n" +
            "LEFT JOIN tb_user_role AS ur ON r.t_rid = ur.t_role_id WHERE ur.t_user_id = ?1")
    Set<Role> findAllByUserId(String uid);

}
