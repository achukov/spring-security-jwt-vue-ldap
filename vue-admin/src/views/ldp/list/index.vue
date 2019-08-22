<template>
  <el-container v-has="'pass:view'">
    <el-header height ="35px">
      <div v-title>Pass Approval</div>

      <div class="filter-container">
        <el-button v-has="'pass:new'" type="success" plain size="mini" @click="handleCreate">New Request</el-button>
        <el-input v-model="page.search" size="mini" placeholder="Search" prefix-icon="el-icon-search" style="width: 250px; margin-left: 10px;" class="filter-item" @keyup.enter.native="handleFilter()"/>
      </div>

      <el-dialog :visible.sync="dialog.visible" :title="dialog.title" :close-on-click-modal="false" :center="true" top="5vh" width="1100px">
        <el-form id="Ldp" ref="form" :model="form" :rules="rules" :inline="false" label-position="top" size="mini" >
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 10px; border: 1px solid #DCDFE6;">
            <legend>Оборудование и ущерб</legend>
            <el-row :gutter="20">
              <el-col :span="8">
                <el-form-item :label-width="formLabelWidth" label="Серийный номер" prop="serialNumber">
                  <el-input v-model="form.serialNumber" placeholder="Серийный номер">
                    <el-button slot="append" icon="el-icon-search" @click="getAssetById(form.serialNumber)"/>
                  </el-input>
                </el-form-item>
                <el-form-item :label-width="formLabelWidth" label="Наименование" prop="eqtName">
                  <el-input v-model="form.eqtName" placeholder="Наименование"/>
                </el-form-item>
                <el-form-item :label-width="formLabelWidth" label="OneId" prop="oid">
                  <el-input v-model="form.oid" placeholder="OneId"/>
                </el-form-item>
                <el-form-item :label-width="formLabelWidth" label="Ответственный сотрудник" prop="email">
                  <el-input v-model="form.email" placeholder="Ответственный сотрудник"/>
                </el-form-item>
                <el-form-item :label-width="formLabelWidth" label="Линейный Менеджер" prop="lmEmail">
                  <el-input v-model="form.lmEmail" placeholder="Линейный Менеджер"/>
                </el-form-item>
                <el-form-item :label-width="formLabelWidth" label="Email HR BP" prop="hrbp">
                  <el-input v-model="form.hrbp" placeholder="Email HR BP"/>
                </el-form-item>
              </el-col>
              <el-col :span="8">
                <el-form-item :label-width="formLabelWidth" label="Юр. лицо" prop="organization">
                  <el-input v-model="form.organization" placeholder="Юр. лицо"/>
                </el-form-item>
                <el-form-item :label-width="formLabelWidth" label="Локация" prop="location">
                  <el-input v-model="form.location" placeholder="Локация"/>
                </el-form-item>
                <el-form-item :label-width="formLabelWidth" label="Asset (если CAPEX)" prop="capex">
                  <el-input v-model="form.capex" placeholder="Asset (если CAPEX)"/>
                </el-form-item>
                <el-form-item :label-width="formLabelWidth" label="Дата ввода в эксплуатацию" prop="expldate">
                  <el-input v-model="form.expldate" placeholder="Дата ввода в эксплуатацию"/>
                </el-form-item>
                <el-form-item :label-width="formLabelWidth" label="Остаточная стоимость (IFRS)" prop="ifrs">
                  <el-input v-model="form.ifrs" placeholder="Остаточная стоимость (IFRS)"/>
                </el-form-item>
              </el-col>
              <el-col :span="8">
                <el-form-item :label-width="formLabelWidth" label="Характер ущерба" prop="dmgtype">
                  <el-input v-model="form.dmgtype" placeholder="Характер ущерба"/>
                </el-form-item>
                <el-form-item :label-width="formLabelWidth" label="Описание ущерба" prop="dmgdescription">
                  <el-input v-model="form.dmgdescription" type="textarea" placeholder="Описание ущерба"/>
                </el-form-item>
                <el-upload
                  :on-preview="handlePreview"
                  :on-remove="handleRemove"
                  :before-remove="beforeRemove"
                  :limit="3"
                  :on-exceed="handleExceed"
                  :file-list="fileList"
                  class="upload-demo"
                  action="https://jsonplaceholder.typicode.com/posts/"
                  multiple>
                  <el-button size="mini" type="warning">Upload photo</el-button>
                  <div slot="tip" class="el-upload__tip">jpg/png files with a size less than 500kb</div>
                </el-upload>
              </el-col>
            </el-row>
          </fieldset>
          <!-- <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 10px; border: 1px solid #DCDFE6;">-->
          <!-- </fieldset>-->
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button v-if="form.procStarted === 0" size="mini" type="primary" @click="saveAndFlushEntity()">Save and Submit</el-button>
          <el-button v-if="form.procStarted === 1" size="mini" type="primary" @click="saveAndFlushEntity()">Save</el-button>
          <el-button size="mini" @click="dialog.visible = false">Cancel</el-button>
        </span>
        <el-image :src="actPicUrl" style="width: 400px; height: 500px"/>
      </el-dialog>

    </el-header>
    <el-main>
      <el-table v-loading="loading" :data="tableData" :default-sort = "{prop: 'lid', order: 'descending'}" size="mini" border tooltip-effect="light" element-loading-text="Loading..." style="width: 100%">

        <el-table-column sortable fixed prop="lid" label="Id" width="60"/>
        <el-table-column show-overflow-tooltip sortable prop="serialnumber" label="serialnumber"/>
        <el-table-column show-overflow-tooltip sortable prop="employeeid" label="employeeid"/>
        <el-table-column show-overflow-tooltip sortable prop="dmgtype" label="dmgtype"/>
        <el-table-column show-overflow-tooltip sortable prop="dmgdescription" label="dmgdescription"/>
        <el-table-column show-overflow-tooltip sortable prop="asset" label="asset"/>
        <el-table-column show-overflow-tooltip sortable prop="commisdate" label="commisdate"/>
        <el-table-column show-overflow-tooltip sortable prop="ifrs" label="ifrs"/>
        <el-table-column show-overflow-tooltip sortable prop="isrepare" label="isrepare"/>
        <el-table-column show-overflow-tooltip sortable prop="price" label="price"/>
        <el-table-column fixed="right" label="Actions" width="125">
          <template slot-scope="scope">
            <el-tooltip :open-delay="600" class="item" effect="light" content="Edit document" placement="top-start">
              <el-button v-has="'pass:update'" type="primary" icon="el-icon-edit" plain size="mini" @click="handleSubmit(scope.row)"/>
            </el-tooltip>
            <el-tooltip :open-delay="600" class="item" effect="light" content="Delete document" placement="top-end">
              <el-button v-has="'pass:delete'" type="danger" icon="el-icon-delete" plain size="mini" @click="handleDelete(scope.row)"/>
            </el-tooltip>
          </template>
        </el-table-column>
      </el-table>

    </el-main>
    <el-footer>
      <el-pagination
        :page-size="page.size"
        :page-sizes="[10, 20, 50, 100]"
        :total="page.total"
        small
        background
        layout="sizes, prev, pager, next, jumper"
        @current-change="handleCurrentChange"
        @size-change="handleSizeChange"/>
    </el-footer>
    <!-- <el-dialog :visible.sync="dialogVisible" :close-on-click-modal="false" :center="true" width="40%" title="Комментарии:">
      <el-input v-model="comments" :autosize="{ minRows: 3, maxRows: 5}" type="textarea"/>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" type="primary" @click="saveAndFlush(0)">Сохранить</el-button>
        <el-button size="mini" @click="cancleCommit">Отменить</el-button>
      </span>
    </el-dialog> -->
  </el-container>
</template>

<script>

import { scrollTo } from '@/utils/scroll-to';
import { getLdpPage, saveLdp, updateLdp, removeLdpById } from '@/api/ldp';
import { getAssetById } from '@/api/asset';
import { mapGetters } from 'vuex';

export default {
  components: {
  },
  data() {
    return {
      page: {
        page: 1,
        size: 15,
        search: null,
        total: 0
      },
      actPicUrl: '',
      showOverflowTooltip: true,
      formLabelWidth: '130px',
      form: {
        lid: 0,
        oid: undefined,
        eqtName: undefined,
        createdBy: undefined,
        serialNumber: undefined,
        employeeid: undefined,
        email: undefined,
        lmEmail: undefined,
        hrbp: undefined,
        dmgtype: undefined,
        dmgdescription: undefined,
        capex: undefined,
        expldate: undefined,
        ifrs: undefined,
        comment: undefined,
        respOpinion: undefined,
        lmOpinion: undefined,
        slmOpinion: undefined,
        hrOpinion: undefined,
        isRepare: undefined,
        price: undefined,
        lmDecision: undefined,
        status: undefined,
        overall: undefined,
        procStarted: 0
      },
      dialog: {
        visible: false,
        title: ''
      },
      tableData: [],
      loading: false,
      typeoptions: ['Пропуск на посещение', 'Пропуск на въезд'],
      parkoptions: ['Гостевой', 'Погрузка-разгрузка', 'Посадка пассажиров'],
      leveloptions: ['Наземный', 'Подземный'],
      statusoptions: [{ value: 0, label: 'Отменен' }, { value: 1, label: 'Новый' }, { value: 2, label: 'На Согласовании' }, { value: 3, label: 'Утвержден' }]
      // Verification rule
      // rules: {
      //   startdate: [{ type: 'date', required: true, message: 'Необходимо заполнить дату начала', trigger: 'change' }],
      //   enddate: [{ type: 'date', required: true, message: 'Необходимо заполнить дату окончания', trigger: 'change' }],
      //   visitors: [{ required: true, message: 'Необходимо указать количество посетителей', trigger: 'blur' }],
      //   contactperson: [{ required: true, message: 'Необходимо заполнить список посетителей', trigger: 'blur' }],
      //   phonenumber: [
      //     { required: true, message: 'Необходимо указать номер телефона', trigger: 'blur' },
      //     { pattern: /^(\+7)?\s\(?[0-9]{3}\)?\s[0-9]{3}\-?[0-9]{4}$/, message: 'Укажите номер телефона полностью', trigger: 'blur' }
      //   ],
      //   cartype: [{ required: true, message: 'Необходимо указать марку автомобиля', trigger: 'blur' }],
      //   parktype: [{ required: true, message: 'Необходимо указать вид парковки', trigger: 'blur' }],
      //   parklevel: [{ required: true, message: 'Необходимо указать указать уровень парковки', trigger: 'blur' }],
      //   describe: [{ required: true, message: 'Role description cannot be empty', trigger: 'blur' }],
      //   carnumber: [{ required: true, message: 'Необходимо указать регистрационный номер автомобиля', trigger: 'blur' }
      //   ]
      // }
    };
  },
  computed: {
    ...mapGetters([
      'website',
      'user'
    ])
  },
  created() {
    this.getTableData();
  },
  methods: {
    handleCurrentChange(index) {
      this.page.page = index;
      scrollTo(0, 800);
      this.getTableData();
    },
    handleSizeChange(size) {
      this.page.size = size;
      scrollTo(0, 800);
      this.getTableData();
    },
    handleFilter() {
      this.getTableData();
    },
    getTableData() {
      const _this = this;
      _this.loading = true;
      getLdpPage(_this.page).then((result) => {
        if (result.status === 200) {
          _this.tableData = result.data.content;
          _this.page.total = result.data.totalElements;
          _this.loading = false;
        }
      }).catch((err) => {
        console.log('err :', err);
      });
    },
    getAssetById(id) {
      const _this = this;
      getAssetById(id).then((result) => {
        if (result.status === 200) {
          _this.form = result.data;
        }
      }).catch((err) => {
        console.log('err :', err);
      });
    },
    handleCreate() {
      this.resetTemp();
      this.dialog.title = 'New Loss and Damage Claim Procedure';
      this.dialog.visible = true;
      this.$nextTick(() => {
        this.$refs.form.clearValidate();
      });
    },
    handleSubmit(data) {
      this.resetTemp();
      this.form.lid = data.lid;
      this.form.serialnumber = data.serialnumber;
      this.form.employeeid = data.employeeid;
      this.form.dmgtype = data.dmgtype;
      this.form.dmgdescription = data.dmgdescription;
      this.form.asset = data.asset;
      this.form.expldate = data.expldate;
      this.form.ifrs = data.ifrs;
      this.form.comment = data.comment;
      this.form.respOpinion = data.respOpinion;
      this.form.lmOpinion = data.lmOpinion;
      this.form.slmOpinion = data.slmOpinion;
      this.form.hrOpinion = data.hrOpinion;
      this.form.isRepare = data.isRepare;
      this.form.price = data.price;
      this.form.lmDecision = data.lmDecision;
      this.form.status = data.status;
      this.form.overall = data.overall;
      this.form.procStarted = data.procStarted;
      this.actPicUrl = 'http://localhost:8090/activitiesView/info/' + data.lid;
      this.dialog.title = 'Loss and Damage Claim Procedure';
      this.dialog.visible = true;
    },
    // startProcess() {
    //   const _this = this;
    //   debugger;
    //   if (_this.form.procStarted === 0) {
    //     console.log(this.form.lid);
    //     startTasks(_this.form.lid).then((result) => {
    //       if (result.status === 200) {
    //         updateLdp(_this.form.procStarted = 1);
    //         _this.$notify({ title: 'Success', message: 'Process started successfully!', type: 'success' });
    //         _this.dialog.visible = false;
    //       }
    //     }).catch((err) => {
    //       console.log('err :', err);
    //       _this.$notify.error({ title: 'Error', message: err.message });
    //     });
    //   }
    // },
    handleDelete(data) {
      const _this = this;
      if (data.lid > 0) {
        _this.$confirm('Are you sure you want to delete this record?', 'warning',
          { confirmButtonText: 'Confirm', cancelButtonText: 'Cancel', type: 'warning' })
          .then(() => {
            removeLdpById(data.lid).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Successfully deleted!', type: 'success' });
                _this.getTableData();
              }
            }).catch((err) => {
              console.log('err :', err);
              _this.$notify.error({ title: 'Error', message: err.message });
            });
          }).catch(() => {
            _this.$message({ type: 'info', message: 'Cancelled' });
          });
      }
    },
    saveAndFlushEntity() {
      const _this = this;
      _this.$refs.form.validate(valid => {
        if (valid) {
          if (_this.form.lid > 0) {
            updateLdp(_this.form).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Modify successfully!', type: 'success' });
                _this.getTableData();
                _this.dialog.visible = false;
              }
            }).catch((err) => {
              console.log('err :', err);
            });
          } else {
            saveLdp(_this.form).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Succeeded!', type: 'success' });
                _this.getTableData();
                _this.dialog.visible = false;
              }
            }).catch((err) => {
              console.log('err :', err);
              _this.$notify.error({ title: 'Error', message: err.message });
            });
          }
        }
      });
    },
    resetTemp() {
      this.form = {};
    }
  }
};

</script>

<style lang="scss">
legend {
    font-size: 12px;
    padding: 10px;
}
.el-alert__title {
  font-size: 1rem;
}
.init-container {
    line-height: 14px;
    font-weight: 700;
    font-size: 12px;
    color: #606266;
    margin-bottom: 17px;
}
.fieldset {
margin: 20px;
padding: 0 10px 10px;
border: 1px solid #666;
border-radius: 8px;
box-shadow: 0 0 10px #666;
padding-top: 10px;
}
.legend {
  padding: 2px 4px;
  background: #fff;
  /* For better legibility against the box-shadow */
}
.fieldset > legend {
  float: left;
  margin-top: -20px;
}
.fieldset > legend + * {
  clear: both;
}
.el-tooltip__popper {
  max-width: 30%;
}
</style>
