package com.ifsaid.report.entity;

import com.ifsaid.report.common.entity.BaseEntity;
import lombok.Data;
import lombok.EqualsAndHashCode;

import javax.persistence.*;
import java.io.Serializable;
import java.util.Date;

@Entity
@Table(name = "tb_ldp")
@Data
@EqualsAndHashCode(callSuper = false)
public class Ldp extends BaseEntity implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "t_lid")
    private long lid;

    @Column(name = "t_serialnumber")
    private String serialnumber;

    @Column(name = "t_employeeid")
    private Double employeeid;

    @Column(name = "t_dmgtype")
    private String dmgtype;

    @Column(name = "t_dmgdescription")
    private String dmgdescription;

    @Column(name = "t_asset")
    private String asset;

    @Column(name = "t_expldate")
    private Date commisdate;

    @Column(name = "t_ifrs")
    private String ifrs;

    @Column(name = "t_content_id")
    private Integer contentId;

    @Column(name = "t_add_comments")
    private String addcomments;

    @Column(name = "t_add_comments2")
    private String addcomments2;

    @Column(name = "t_add_comments3")
    private String addcomments3;

    @Column(name = "t_add_comments4")
    private String addcomments4;

    @Column(name = "t_add_comments5")
    private String addcomments5;

    @Column(name = "t_is_repare")
    private Integer isrepare;

    @Column(name = "t_price")
    private Double price;

    @Column(name = "t_lm_decis")
    private Integer lmdecis;

    @Column(name = "t_state")
    private String state;

    @Column(name = "t_overall")
    private Integer overall;

    @Column(name = "t_created_by")
    private String createdBy;

    @Column(name = "t_updated_by")
    private String updatedBy;

    @Column(name = "t_history_log")
    private String historyLog;

}