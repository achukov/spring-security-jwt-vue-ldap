<template>
  <el-container v-has="'pass:view'">
    <el-header height ="35px">
      <div v-title>Pass Approval</div>

      <div class="filter-container">
        <el-button v-has="'pass:new'" type="success" plain size="mini" @click="addEntity">New Request</el-button>
        <el-input v-model="page.search" size="mini" placeholder="Search" prefix-icon="el-icon-search" style="width: 250px; margin-left: 10px;" class="filter-item" @keyup.enter.native="handleFilter()"/>
      </div>

      <el-dialog :visible.sync="dialog.visible" :title="dialog.title" :close-on-click-modal="false" :center="true" top="5vh" width="700px">
        <el-form id="Ldp" ref="entity" :model="entity" :rules="rules" :inline="false" label-position="top" size="mini" >
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Серийный номер" prop="serialnumber">
                  <el-input v-model="entity.serialnumber" placeholder="Серийный номер"/>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Характер ущерба" prop="dmgtype">
                  <el-input v-model="entity.dmgtype" placeholder="Характер ущерба"/>
                </el-form-item>
              </el-col>
            </el-row>
          </fieldset>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button size="mini" type="primary" @click="saveAndFlush()">Save</el-button>
          <el-button size="mini" @click="dialog.visible = false">Cancel</el-button>
          <el-button size="mini" type="success" @click="startProcess()">Submit</el-button>
          <!--  <el-button type="primary" @click="handleTask('btn_success')">handleTask</el-button>-->
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
              <el-button v-has="'pass:update'" type="primary" icon="el-icon-edit" plain size="mini" @click="updateEntity(scope.row)"/>
            </el-tooltip>
            <el-tooltip :open-delay="600" class="item" effect="light" content="Delete document" placement="top-end">
              <el-button v-has="'pass:delete'" type="danger" icon="el-icon-delete" plain size="mini" @click="deleteEntity(scope.row)"/>
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
    <el-table v-loading="taskLoading" :data="taskData" :key="tableKey" size="mini" border highlight-current-row style="width: 100%">
      <el-table-column width="200px" align="center" label="ID">
        <template slot-scope="scope">
          <span>{{ scope.row.taskId }}</span>
        </template>
      </el-table-column>
      <el-table-column width="200px" align="center" label="mission name">
        <template slot-scope="scope">
          <span>{{ scope.row.taskName }}</span>
        </template>
      </el-table-column>
      <el-table-column width="200px" align="center" label="Submission time">
        <template slot-scope="scope">
          <span>{{ scope.row.time | formatTime }}</span>
        </template>
      </el-table-column>
      <el-table-column fixed="right" align="center" label="operating" width="150">
        <template slot-scope="scope">
          <el-button size="small" type="success" @click="handleSubmit(scope.row)">Handle</el-button>
          <el-button size="small" type="danger" @click="handleDelete(scope.row)">delete</el-button>
        </template>
      </el-table-column>
    </el-table>
  </el-container>
</template>

<script>

import { scrollTo } from '@/utils/scroll-to';
import { getLdpPage, saveLdp, updateLdp, removeLdpById } from '@/api/ldp';
import { getTaskByName } from '@/api/workflow';
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
      pageTasks: {
        page: 1,
        size: 15,
        search: null,
        total: 0
      },
      list: null,
      actPicUrl: '',
      showOverflowTooltip: true,
      formLabelWidth: '130px',
      entity: {
        lid: 0,
        serialnumber: '',
        employeeid: '',
        dmgtype: '',
        dmgdescription: '',
        asset: '',
        commisdate: '',
        ifrs: '',
        isrepare: '',
        price: ''
      },
      dialog: {
        visible: false,
        title: ''
      },
      taskData: [],
      tableData: [],
      tableKey: 0,
      loading: false,
      taskLoading: false,
      typeoptions: ['Пропуск на посещение', 'Пропуск на въезд'],
      parkoptions: ['Гостевой', 'Погрузка-разгрузка', 'Посадка пассажиров'],
      leveloptions: ['Наземный', 'Подземный'],
      statusoptions: [{ value: 0, label: 'Отменен' }, { value: 1, label: 'Новый' }, { value: 2, label: 'На Согласовании' }, { value: 3, label: 'Утвержден' }],
      // Verification rule
      rules: {
        startdate: [{ type: 'date', required: true, message: 'Необходимо заполнить дату начала', trigger: 'change' }],
        enddate: [{ type: 'date', required: true, message: 'Необходимо заполнить дату окончания', trigger: 'change' }],
        visitors: [{ required: true, message: 'Необходимо указать количество посетителей', trigger: 'blur' }],
        contactperson: [{ required: true, message: 'Необходимо заполнить список посетителей', trigger: 'blur' }],
        phonenumber: [
          { required: true, message: 'Необходимо указать номер телефона', trigger: 'blur' },
          { pattern: /^(\+7)?\s\(?[0-9]{3}\)?\s[0-9]{3}\-?[0-9]{4}$/, message: 'Укажите номер телефона полностью', trigger: 'blur' }
        ],
        cartype: [{ required: true, message: 'Необходимо указать марку автомобиля', trigger: 'blur' }],
        parktype: [{ required: true, message: 'Необходимо указать вид парковки', trigger: 'blur' }],
        parklevel: [{ required: true, message: 'Необходимо указать указать уровень парковки', trigger: 'blur' }],
        describe: [{ required: true, message: 'Role description cannot be empty', trigger: 'blur' }],
        carnumber: [{ required: true, message: 'Необходимо указать регистрационный номер автомобиля', trigger: 'blur' }
        ]
      }
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
    this.getTasks();
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
    getTasks() {
      const _this = this;
      this.taskLoading = true;
      getTaskByName(_this.pageTasks).then((result) => {
        if (result.status === 200) {
          _this.taskData = result.data.content;
          _this.page.total = result.data.totalElements;
          _this.taskLoading = false;
        }
      }).catch((err) => {
        console.log('err :', err);
      });
    },
    currentChange(index) {
      this.page.page = index;
      this.getTableData();
    },
    emptyEntity() {
      this.entity.lid = 0;
      this.entity.createdBy = 'NA';
      this.entity.serialnumber = '';
      this.entity.employeeid = '';
      this.entity.dmgtype = '';
      this.entity.dmgdescription = '';
      this.entity.asset = '';
      this.entity.commisdate = '';
      this.entity.ifrs = '';
      this.entity.isrepare = '';
      this.entity.price = '';
    },
    addEntity() {
      this.emptyEntity();
      this.dialog.title = 'New Loss and Damage Claim Procedure';
      this.dialog.visible = true;
      this.$nextTick(() => {
        this.$refs.entity.clearValidate();
      });
    },
    updateEntity(data) {
      this.emptyEntity();
      this.entity.lid = data.lid;
      this.entity.serialnumber = data.serialnumber;
      this.entity.employeeid = data.employeeid;
      this.entity.dmgtype = data.dmgtype;
      this.entity.dmgdescription = data.dmgdescription;
      this.entity.asset = data.asset;
      this.entity.commisdate = data.commisdate;
      this.entity.ifrs = data.ifrs;
      this.entity.isrepare = data.isrepare;
      this.entity.price = data.price;
      this.actPicUrl = 'http://localhost:8090/activitiesView/info/' + data.lid;
      this.dialog.title = 'Loss and Damage Claim Procedure';
      this.dialog.visible = true;
    },
    handleTask(elem) {
      // const paramMap = {};
      // paramMap.outcome = elem;
      // paramMap.lid = this.lid;
      // paramMap.comment = 'aaa';
      // paramMap.LdpId =
      // this.obj.taskId = this.taskId;
      // this.obj.taskFlag = result;
      // this.obj.comment = this.form.comment;
      // this.obj.leaveId = this.form.id;
      // this.obj.days = this.form.days;
    },
    deleteEntity(data) {
      const _this = this;
      if (data.lid > 0) {
        _this.$confirm('Are you sure you want to delete this record?', 'warning',
          { confirmButtonText: 'Confirm', cancelButtonText: 'Cancel', type: 'warning' })
          .then(() => {
            removeLdpById(data.psid).then((result) => {
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
    saveAndFlush() {
      const _this = this;
      _this.$refs.entity.validate(valid => {
        if (valid) {
          if (_this.entity.lid > 0) {
            updateLdp(_this.entity).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Modify successfully!', type: 'success' });
                _this.getTableData();
                _this.dialog.visible = false;
              }
            }).catch((err) => {
              console.log('err :', err);
            });
          } else {
            saveLdp(_this.entity).then((result) => {
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
    }
  }
};

</script>

<style lang="scss">
.el-form-item__label {
  padding: 0 20px 0 0;
}
.el-alert__title {
  font-size: 1rem;
}
.init-container {
    line-height: 24px;
    font-weight: 700;
    font-size: 14px;
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
