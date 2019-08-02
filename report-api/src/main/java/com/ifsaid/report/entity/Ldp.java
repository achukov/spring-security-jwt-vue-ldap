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
    private Date expldate;

    @Column(name = "t_ifrs")
    private String ifrs;

    @Column(name = "t_content_id")
    private Integer contentId;

    @Column(name = "t_comment")
    private String comment;

    @Column(name = "t_resp_opinion")
    private String respOpinion;

    @Column(name = "t_lm_opinion")
    private String lmOpinion;

    @Column(name = "t_slm_opinion")
    private String slmOpinion;

    @Column(name = "t_hr_opinion")
    private String hrOpinion;

    @Column(name = "t_is_repare")
    private Integer isRepare;

    @Column(name = "t_price")
    private Double price;

    @Column(name = "t_lm_decision")
    private Integer lmDecision;

    @Column(name = "t_overall")
    private Integer overall;

    @Column(name = "t_status")
    private String status;

    @Column(name = "t_created_by")
    private String createdBy;

    @Column(name = "t_proc_started")
    private Integer procStarted;

}