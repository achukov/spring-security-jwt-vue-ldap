<template>
  <el-container v-has="'pass:view'">
    <el-header height ="35px">
      <div v-title>Pass Approval</div>

      <div class="filter-container">
        <el-button v-has="'pass:new'" type="success" plain size="mini" @click="addEntity">New Request</el-button>
        <el-input v-model="page.search" size="mini" placeholder="Search" prefix-icon="el-icon-search" style="width: 250px; margin-left: 10px;" class="filter-item" @keyup.enter.native="handleFilter()"/>
      </div>

      <el-dialog :visible.sync="dialog.visible" :title="dialog.title" :close-on-click-modal="false" :center="true" top="5vh" width="700px">
        <el-form id="Pass" ref="entity" :model="entity" :rules="rules" :inline="false" label-position="top" size="mini" >
          <el-row :gutter="20">
            <el-col :span="16" :offset="6">
              <div style="margin-bottom: 10px; margin-top: 10px; text-align: left">
                <el-radio-group v-model="entity.type" size="small">
                  <el-radio-button v-for="item in typeoptions" :key="item.lastname" :label="item" :value="item"/>
                </el-radio-group>
              </div>
            </el-col>
          </el-row>
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Дата начала" prop="startdate">
                  <el-date-picker v-model="entity.startdate" :picker-options="pickerOptions" type="date" format="dd-MM-yyyy" placeholder="Please pick a date" />
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Дата окончания" prop="enddate">
                  <el-date-picker v-model="entity.enddate" :picker-options="pickerOptions" type="date" format="dd-MM-yyyy" placeholder="Please pick a date" />
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="20">
              <el-col :span="12">
                <el-checkbox v-model="entity.nonwork" :true-label="1" :false-label="0" label="Посещение в нерабочее время"/>
                this: {{ entity.nonwork }}
                <el-checkbox v-model="entity.escort" :true-label="1" :false-label="0" label="Требуется сопровождение службы безопасности"/>
                this: {{ entity.escort }}
              </el-col>
            </el-row>
          </fieldset>
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <el-row :gutter="20">
              <el-col :span="24">
                <el-form-item :label-width="formLabelWidth" label="Посетители" prop="visitors">
                  <div class="add_user">
                    <el-button type="primary" size="mini" circle @click="staffDialogFormVisible = true"><i class="el-icon-user"/></el-button>
                  </div>
                </el-form-item>
              </el-col>
            </el-row>
            <div class="visitorsData">
              <el-table :data="tempVisitorsTable" stripe size="mini">
                <el-table-column prop="firstname" label="firstname"/>
                <el-table-column prop="middlename" label="middlename"/>
                <el-table-column prop="lastname" label="lastname"/>
                <el-table-column fixed="right" width="50" >
                  <template slot-scope="scope">
                    <el-button type="danger" size="mini" icon="el-icon-delete" circle alt="delete" title="delete" @click="deleteData(scope.row)"/>
                  </template>
                </el-table-column>
              </el-table>
            </div>
          </fieldset>
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Контактное лицо" prop="contactperson">
                  <el-input v-model="entity.contactperson" placeholder="username@bat.com"/>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Телефон для связи" prop="phonenumber">
                  <el-input v-mask="'+7 (###) ###-####'" v-model="entity.phonenumber" type="tel" placeholder="+7 (___) ___-____">
                    <i slot="prefix" class="el-input__icon el-icon-phone"/>
                  </el-input>
                </el-form-item>
              </el-col>
            </el-row>
            aaaa: {{ entity.type }}
          </fieldset>
          <fieldset v-if="entity.type =='Пропуск на въезд'" style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <el-row :gutter="20">
              <el-col :span="12">
                <template>
                  <el-form-item :label-width="formLabelWidth" label="Номер автомобиля" prop="carnumber">
                    <el-input v-uppercase v-model="entity.carnumber" placeholder="А777АА199"/>
                  </el-form-item>
                </template>
              </el-col>
              <el-col :span="12">
                <template>
                  <el-form-item :label-width="formLabelWidth" label="Марка автомобиля" prop="cartype">
                    <el-input v-model="entity.cartype" placeholder="TOYOTA"/>
                  </el-form-item>
                </template>
              </el-col>
            </el-row>
            <el-row :gutter="20">
              <el-col :span="12">
                <template>
                  <el-form-item :label-width="formLabelWidth" label="Вид парковки" prop="parktype">
                    <el-select v-model="entity.parktype" placeholder="please choose" class="filter-item">
                      <el-option v-for="item in parkoptions" :key="item" :label="item" :value="item"/>
                    </el-select>
                  </el-form-item>
                </template>
              </el-col>
              <el-col :span="12">
                <template>
                  <el-form-item :label-width="formLabelWidth" label="Уровень парковки" prop="parklevel">
                    <el-select v-model="entity.parklevel" placeholder="please choose" class="filter-item">
                      <el-option v-for="item in leveloptions" :key="item" :label="item" :value="item"/>
                    </el-select>
                  </el-form-item>
                </template>
              </el-col>
            </el-row>
            <el-row :gutter="20">
              <el-col :span="12">
                <el-checkbox v-model="entity.buildingaccess" :true-label="1" :false-label="0" label="Требуется доступ в здание"/>
              </el-col>
            </el-row>
          </fieldset>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button size="mini" type="primary" @click="saveAndFlush(1)">Save and Submit</el-button>
          <el-button size="mini" @click="dialog.visible = false">Cancel</el-button>
          <div class="history">
            <el-button type="warning" size="mini" circle @click="showWorkflowHistory = true"><i class="el-icon-chat-line-square"/></el-button>
          </div>
        </span>
      </el-dialog>

    </el-header>
    <el-main>
      <el-table v-loading="loading" :data="tableData" :default-sort = "{prop: 'psid', order: 'descending'}" size="mini" border tooltip-effect="light" element-loading-text="Loading..." style="width: 100%">
        <el-table-column sortable fixed prop="psid" label="Id" width="60"/>
        <el-table-column show-overflow-tooltip sortable prop="createTime" label="Создано">
          <template slot-scope="scope">
            <i class="el-icon-time"/>
            <span style="margin-left: 5px">{{ scope.row.createTime | formatTime }}</span>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip label="Кем создано" width="180">
          <template slot-scope="scope">
            <span style="margin-left: 5px"> {{ scope.row.createdBy | lowercase }}</span>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip sortable prop="type" label="Тип" width="180">
          <template slot-scope="scope">
            <i v-if="scope.row.type=='Пропуск на посещение'" class="el-icon-user"/>
            <i v-else class="el-icon-truck"/>
            <span style="margin-left: 5px">{{ scope.row.type }}</span>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip label="Действителен с">
          <template slot-scope="scope">
            <i class="el-icon-time"/>
            <span style="margin-left: 5px">{{ scope.row.startdate | formatTime }}</span>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip label="Действителен по" width="180">
          <template slot-scope="scope">
            <i class="el-icon-time"/>
            <span style="margin-left: 5px">{{ scope.row.enddate | formatTime }}</span>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip label="Посетители" width="180">
          <template slot-scope="scope">
            {{ scope.row.visitors | mapToStr }}
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip prop="carnumber" label="Номер автомобиля" width="180"/>
        <el-table-column sortable prop="state" label="Статус">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.state==0" type="info" size="mini">Новый</el-tag>
            <el-tag v-if="scope.row.state==1" type="warning" size="mini">На Согласовании</el-tag>
            <el-tag v-if="scope.row.state==2" type="success" size="mini">Утвержден</el-tag>
            <el-tag v-if="scope.row.state==3" type="danger" size="mini">Отменен</el-tag>
          </template>
        </el-table-column>
        <el-table-column fixed="right" label="Решение" width="125">
          <template slot-scope="scope">
            <el-button v-has="'pass:approve'" v-if="scope.row.state === 1" size="mini" icon="el-icon-check" type="success" @click="decision(scope.row, 2)"/>
            <el-button v-has="'pass:approve'" v-if="scope.row.state === 1" size="mini" icon="el-icon-close" type="danger" @click="decision(scope.row, 0)"/>
          </template>
        </el-table-column>
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
    <el-dialog :visible.sync="staffDialogFormVisible" :close-on-click-modal="false" title="Visitor" width="450px" height="400px">
      <el-form ref="staff" :model="staff" size="mini">
        <el-form-item label="firstname:">
          <el-row type="flex" class="row-bg" justify="center">
            <el-col :span="18">
              <el-input v-model="staff.firstname" name="firstname" placeholder="firstname" />
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item label="lastname:">
          <el-row type="flex" class="row-bg" justify="center">
            <el-col :span="18">
              <el-input v-model="staff.lastname" name="lastname" placeholder="lastname" />
            </el-col>
          </el-row>
        </el-form-item> <el-form-item label="middlename:">
          <el-row type="flex" class="row-bg" justify="center">
            <el-col :span="18">
              <el-input v-model="staff.middlename" name="middlename" placeholder="middlename" />
            </el-col>
          </el-row>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button v-model="staff" size="mini" type="primary" @click="appendData(staff)">Добавить</el-button>
        <el-button size="mini" @click="staffDialogFormVisible = false">Отменить</el-button>
      </span>
    </el-dialog>
    <el-dialog :visible.sync="showWorkflowHistory" title="Workflow History" width="550PX" height="350px">
      <el-form ref="staff" :model="staff" size="mini">
        <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
          <el-steps :active="entity.state" align-center process-status="success" finish-status="finish">
            <el-step title="Новый" description="Заполнение документа"/>
            <el-step title="На Согласовании" description="Утверждается отделом безопасности"/>
            <el-step title="Утвержден" description="Заявка согласована"/>
          </el-steps>
          <div> Номер: {{ entity.psid }} </div>
          <div> Автор: {{ entity.createdBy | lowercase }} </div>
          <div style="white-space: pre-line;"> История: {{ entity.historyLog | formatText }} </div>
        </fieldset>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" @click="showWorkflowHistory = false">Закрыть</el-button>
      </span>
    </el-dialog>
  </el-container>
</template>

<script>

import { scrollTo } from '@/utils/scroll-to';
import { getPassPage, savePass, updatePass, removePassById } from '@/api/pass';
import { mapGetters } from 'vuex';
// import UserList from '@/components/UserList'

export default {
  components: {
    // UserList
  },
  data() {
    return {
      pickerOptions: {
        disabledDate(time) {
          return time.getTime() < (Date.now() - 8.64e7);
        },
        shortcuts: [{
          text: 'Today',
          onClick(picker) {
            picker.$emit('pick', new Date());
          }
        }, {
          text: 'Tomorrow',
          onClick(picker) {
            const date = new Date();
            date.setTime(date.getTime() + 3600 * 1000 * 24);
            picker.$emit('pick', date);
          }
        }]
      },
      page: {
        page: 1,
        size: 17,
        search: null,
        total: 0
      },
      activeName: '0',
      showOverflowTooltip: true,
      formLabelWidth: '130px',
      comments: '',
      entity: {
        psid: 0,
        type: '',
        createdBy: '',
        startdate: '',
        enddate: '',
        visitors: '',
        contactperson: '',
        phonenumber: '',
        carnumber: '',
        cartype: '',
        parktype: '',
        parklevel: '',
        buildingaccess: 0,
        state: 0,
        nonwork: 0,
        escort: 0
      },
      staff: {
        firstname: '',
        lastname: '',
        middlename: ''
      },
      dialog: {
        visible: false,
        title: ''
      },
      staffDialogFormVisible: false,
      showWorkflowHistory: false,
      tableData: [],
      tempVisitorsTable: [],
      loading: false,
      authority: {
        list: [],
        psid: 0,
        visible: false,
        title: ''
      },
      // buildoptions: ['Да', 'Нет'],
      typeoptions: ['Пропуск на посещение', 'Пропуск на въезд'],
      parkoptions: ['Гостевой', 'Погрузка-разгрузка', 'Посадка пассажиров'],
      leveloptions: ['Наземный', 'Подземный'],
      statusoptions: [{ value: 0, label: 'Отменен' }, { value: 1, label: 'Новый' }, { value: 2, label: 'На Согласовании' }, { value: 3, label: 'Утвержден' }],
      // Verification rule
      rules: {
        startdate: [{ type: 'date', required: true, message: 'Необходимо заполнить дату начала', trigger: 'change' }],
        enddate: [{ type: 'date', required: true, message: 'Необходимо заполнить дату окончания', trigger: 'change' }],
        tempVisitorsTable: [{ required: true, message: 'Необходимо указать количество посетителей', trigger: 'blur' }],
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
  },
  methods: {
    appendData(staff) {
      this.tempVisitorsTable.push(staff);
      this.staff = {};
      this.staffDialogFormVisible = false;
    },
    deleteData(row) {
      var val = this.tempVisitorsTable.splice(row, 1);
      this.entity.visitors = JSON.stringify(val);
    },
    nextStep() {
      if (this.entity.state++ > 1) this.entity.state = 0;
    },
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
      getPassPage(_this.page).then((result) => {
        if (result.status === 200) {
          _this.tableData = result.data.content;
          _this.page.total = result.data.totalElements;
          _this.loading = false;
        }
      }).catch((err) => {
        console.log('err :', err);
      });
    },
    addComment() {
      this.dialogVisible = true;
    },
    cancleCommit() {
      this.dialogVisible = false;
      this.comments = '';
    },
    currentChange(index) {
      // Switch paging
      this.page.page = index;
      this.getTableData();
    },
    emptyEntity() {
      this.entity = {
        buildingaccess: 0,
        nonwork: 0,
        escort: 0,
        type: 'Пропуск на посещение'
      };
    },
    addEntity() {
      this.emptyEntity();
      this.dialog.title = 'New Pass Approval Request';
      this.dialog.visible = true;
      this.entity.historyLog = ';Created by: ' + this.$store.state.user.account + ' at: ' + new Date().toLocaleString();
      this.$nextTick(() => {
        this.$refs.entity.clearValidate();
      });
    },
    updateEntity(data) {
      this.emptyEntity();
      this.entity.psid = data.psid;
      this.entity.type = data.type;
      this.entity.createdBy = data.createdBy;
      this.entity.startdate = data.startdate;
      this.entity.enddate = data.enddate;
      this.tempVisitorsTable = JSON.parse(data.visitors);
      this.entity.contactperson = data.contactperson;
      this.entity.phonenumber = data.phonenumber;
      this.entity.carnumber = data.carnumber;
      this.entity.cartype = data.cartype;
      this.entity.parktype = data.parktype;
      this.entity.parklevel = data.parklevel;
      this.entity.buildingaccess = data.buildingaccess;
      this.entity.nonwork = data.nonwork;
      this.entity.escort = data.escort;
      this.entity.state = data.state;
      this.entity.createTime = data.createTime;
      this.entity.historyLog = data.historyLog;
      this.dialog.title = 'Pass Approval Request';
      this.dialog.visible = true;
    },
    decision(data, id) {
      const _this = this;
      debugger;
      data.state = id;
      if (data.psid > 0) {
        _this.$confirm('Вы точно хотите ' + (id === 2 ? 'утвердить' : 'отклонить') + ' заявку ?', 'Внимание',
          { confirmButtonText: 'Да', cancelButtonText: 'Отменить', type: 'warning' })
          .then(() => {
            if (id === 2) {
              data.historyLog = data.historyLog + ';Approved by: ' + this.$store.state.user.account + ' at: ' + new Date().toLocaleString();
            } else if (id === 0) {
              // _this.addComment()
              data.historyLog = data.historyLog + ';Rejected by: ' + this.$store.state.user.account + ' at: ' + new Date().toLocaleString();
            }
            updatePass(data).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Successfully!', type: 'success' });
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
    deleteEntity(data) {
      const _this = this;
      if (data.psid > 0) {
        _this.$confirm('Are you sure you want to delete this record?', 'warning',
          { confirmButtonText: 'Confirm', cancelButtonText: 'Cancel', type: 'warning' })
          .then(() => {
            removePassById(data.psid).then((result) => {
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
    saveAndFlush(id) {
      const _this = this;
      _this.$refs.entity.validate(valid => {
        if (valid) {
          _this.entity.state = id;
          if (_this.entity.psid > 0) {
            _this.entity.historyLog = _this.entity.historyLog + ';Updated by: ' + this.$store.state.user.account + ' at: ' + new Date().toLocaleString();
            _this.entity.visitors = JSON.stringify(this.tempVisitorsTable);
            updatePass(_this.entity).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Modify the Pass successfully!', type: 'success' });
                _this.getTableData();
                _this.dialog.visible = false;
              }
            }).catch((err) => {
              console.log('err :', err);
            });
          } else {
            _this.entity.visitors = JSON.stringify(this.tempVisitorsTable);
            console.log(_this.entity.buildingaccess);
            console.log(_this.entity.nonwork);
            console.log(_this.entity.escort);
            savePass(_this.entity).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'New Pass succeeded!', type: 'success' });
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
.el-form .add_user {
  position: absolute;
  top: -28px;
  left: 100px;
  z-index: 1;
  padding-bottom: 3px;
}
.dialog-footer .history {
  position: absolute;
  bottom: 17px;
  right: 30px;
  padding-bottom: 3px;
}
.el-checkbox__label {
  display: inline-block;
  padding-left: 10px;
  line-height: 19px;
  font-size: 12px;
}
.el-form .add_user .el-button{
  padding: 4px;
  font-size: 12px;
}
.el-alert__title {
  font-size: 1rem;
}
/*.el-table .line-break .cell {*/
/*  white-space: pre;*/
/*}*/
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
