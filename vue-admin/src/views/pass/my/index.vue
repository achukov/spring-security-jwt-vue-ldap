<template>
  <el-container v-has="'pass:view'">
    <el-header height ="35px">
      <div v-title>My Pass Approval</div>

      <div class="filter-container">
        <el-button v-has="'pass:new'" type="success" plain size="mini" @click="addEntity">New Request</el-button>
        <el-input v-model="page.search" size="mini" placeholder="Search" prefix-icon="el-icon-search" style="width: 250px; margin-left: 10px;" class="filter-item" @keyup.enter.native="handleFilter()"/>
      </div>

      <el-dialog :visible.sync="dialog.visible" :title="dialog.title" :close-on-click-modal="false" :center="true" top="5vh" width="700px">
        <el-form id="Pass" ref="entity" :model="entity" :rules="rules" :inline="false" label-position="top" size="mini" >
          <el-collapse v-model="activeName" accordion>
            <el-collapse-item title="info" name="1">
              <div> Номер: {{ entity.psid }} </div>
              <div> Автор: {{ entity.createdBy }} </div>
              <div style="white-space: pre-line;"> История: {{ entity.historyLog | formatText }} </div>
            </el-collapse-item>
            <el-collapse-item title="status" name="2">
              <el-steps :active="entity.state" align-center process-status="success" finish-status="finish">
                <el-step title="Новый" description="Заполнение документа"/>
                <el-step title="На Согласовании" description="Утверждается отделом безопасности"/>
                <el-step title="Утвержден" description="Заявка согласована"/>
              </el-steps>
            </el-collapse-item>
          </el-collapse>
          <el-row :gutter="20">
            <el-col :span="16" :offset="6">
              <div style="margin-bottom: 10px; margin-top: 10px; text-align: left">
                <el-radio-group :disabled="isEdit" v-model="entity.type" size="small">
                  <el-radio-button v-for="item in typeoptions" :key="item" :label="item" :value="item"/>
                </el-radio-group>
              </div>
            </el-col>
          </el-row>
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Дата начала" prop="startdate">
                  <el-date-picker :disabled="isEdit" v-model="entity.startdate" type="datetime" format="dd-MM-yyyy HH:mm" placeholder="Please pick a date" />
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Дата окончания" prop="enddate">
                  <el-date-picker :disabled="isEdit" v-model="entity.enddate" type="datetime" format="dd-MM-yyyy HH:mm" placeholder="Please pick a date" />
                </el-form-item>
              </el-col>
            </el-row>
            <el-row :gutter="20">
              <el-col :span="24">
                <el-form-item :label-width="formLabelWidth" label="Посетители" prop="visitors">
                  <el-input
                    :disabled="isEdit"
                    v-model="entity.visitors"
                    :autosize="{ minRows: 3, maxRows: 5}"
                    type="textarea"
                    placeholder="Фамилия, Имя, Отчество посетителя пишутся в одну строку, каждый новый посетитель пишется с новой строки."
                    cleareble/>
                <!-- <UserList/> -->
                </el-form-item>
              </el-col>
            </el-row>
          </fieldset>
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Контактное лицо" prop="contactperson">
                  <el-input :disabled="isEdit" v-model="entity.contactperson" placeholder="ivan_ivanov@bat.com"/>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Телефон для связи" prop="phonenumber">
                  <el-input v-mask="'+7 (###) ###-####'" :disabled="isEdit" v-model="entity.phonenumber" type="tel" placeholder="+7 (___) ___-____">
                    <i slot="prefix" class="el-input__icon el-icon-phone"/>
                  </el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </fieldset>
          <fieldset v-if="entity.type =='Пропуск на въезд'" style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <el-row :gutter="20">
              <el-col :span="12">
                <template>
                  <el-form-item :label-width="formLabelWidth" label="Номер автомобиля" prop="carnumber">
                    <el-input v-uppercase :disabled="isEdit" v-model="entity.carnumber" placeholder="А777АА199"/>
                  </el-form-item>
                </template>
              </el-col>
              <el-col :span="12">
                <template>
                  <el-form-item :label-width="formLabelWidth" label="Марка автомобиля" prop="cartype">
                    <el-input :disabled="isEdit" v-model="entity.cartype" placeholder="TOYOTA"/>
                  </el-form-item>
                </template>
              </el-col>
            </el-row>
            <el-row :gutter="20">
              <el-col :span="12">
                <template>
                  <el-form-item :label-width="formLabelWidth" label="Вид парковки" prop="parktype">
                    <el-select :disabled="isEdit" v-model="entity.parktype" placeholder="please choose" class="filter-item">
                      <el-option v-for="item in parkoptions" :key="item" :label="item" :value="item"/>
                    </el-select>
                  </el-form-item>
                </template>
              </el-col>
              <el-col :span="12">
                <template>
                  <el-form-item :label-width="formLabelWidth" label="Уровень парковки" prop="parklevel">
                    <el-select :disabled="isEdit" v-model="entity.parklevel" placeholder="please choose" class="filter-item">
                      <el-option v-for="item in leveloptions" :key="item" :label="item" :value="item"/>
                    </el-select>
                  </el-form-item>
                </template>
              </el-col>
            </el-row>
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Требуется доступ в здание" prop="buildingaccess">
                  <el-switch :disabled="isEdit" v-model="entity.buildingaccess" active-text="Да" inactive-text="Нет" active-value="1" inactive-value="0"/>
                </el-form-item>
              </el-col>
            </el-row>
          </fieldset>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button v-if="isEdit === false && entity.state === 0" size="mini" type="primary" @click="saveAndFlush(1)">Save and Submit</el-button>
          <el-button v-if="isEdit === false" size="mini" @click="dialog.visible = false">Cancel</el-button>
        </span>
      </el-dialog>

    </el-header>
    <el-main>
      <el-table v-loading="loading" :data="tableData" :default-sort = "{prop: 'psid', order: 'descending'}" size="mini" border tooltip-effect="light" element-loading-text="Loading..." style="width: 100%">
        <!-- <el-table-column type="expand">
          <template slot-scope="scope">
            <p>Посетители: {{ scope.row.visitors }}</p>
          </template>
        </el-table-column> -->
        <el-table-column sortable fixed prop="psid" label="Id" width="60"/>
        <el-table-column show-overflow-tooltip sortable prop="createTime" label="Создано">
          <template slot-scope="scope">
            <i class="el-icon-time"/>
            <span style="margin-left: 5px">{{ scope.row.createTime | formatTime }}</span>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip label="Кем создано" width="180">
          <template slot-scope="scope">
            <span style="margin-left: 5px"> {{ scope.row.createdBy }}</span>
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
        <el-table-column show-overflow-tooltip prop="visitors" label="Посетители" width="180"/>
        <el-table-column show-overflow-tooltip prop="carnumber" label="Номер автомобиля" width="180"/>
        <el-table-column sortable prop="state" label="Статус">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.state==0" type="info" size="mini">Новый</el-tag>
            <el-tag v-if="scope.row.state==1" type="warning" size="mini">На Согласовании</el-tag>
            <el-tag v-if="scope.row.state==2" type="success" size="mini">Утвержден</el-tag>
            <el-tag v-if="scope.row.state==3" type="danger" size="mini">Отменен</el-tag>
          </template>
        </el-table-column>
        <el-table-column sortable prop="buildingaccess" label="Доступ в здание" width="150">
          <template slot-scope="scope"> {{ scope.row.buildingaccess | showBuild }} </template>
        </el-table-column>
        <el-table-column fixed="right" label="Actions" width="125">
          <template slot-scope="scope">
            <el-tooltip :open-delay="600" class="item" effect="light" content="Edit document" placement="top-start">
              <el-button v-has="'pass:update'" type="primary" icon="el-icon-edit" plain size="mini" @click="updateEntity(scope.row)"/>
            </el-tooltip>
            <el-tooltip :open-delay="600" class="item" effect="light" content="Delete document" placement="top-end">
              <el-button v-has="'pass:delete'" v-if="scope.row.state === 0" type="danger" icon="el-icon-delete" plain size="mini" @click="deleteEntity(scope.row)"/>
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
  </el-container>
</template>

<script>

import { scrollTo } from '@/utils/scroll-to';
import { getMyPassPage, savePass, updatePass, removePassById } from '@/api/pass';
import { mapGetters } from 'vuex';
// import UserList from '@/components/UserList'

export default {
  components: {
    // UserList
  },
  data() {
    return {
      page: {
        page: 1,
        size: 17,
        search: null,
        total: 0
      },
      isEdit: false,
      activeName: '0',
      showOverflowTooltip: true,
      formLabelWidth: '130px',
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
        historyLog: '',
        buildingaccess: 0,
        state: 0
      },
      dialog: {
        visible: false,
        title: ''
      },
      tableData: [],
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
          // ,{
          //   validator: function(rule, value, callback) {
          //     const regex = /[АВЕКМНОРСТУХ]\d{3}[АВЕКМНОРСТУХ]{2}\d{2,3}/
          //     if (!regex.test(value)) {
          //       callback(new Error('регистрационный номер латиницей'))
          //     } else {
          //       callback()
          //     }
          //   }, trigger: 'blur'
          // }
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
      getMyPassPage(_this.page).then((result) => {
        if (result.status === 200) {
          _this.tableData = result.data.content;
          _this.page.total = result.data.totalElements;
          _this.loading = false;
        }
      }).catch((err) => {
        console.log('err :', err);
      });
    },
    currentChange(index) {
      // Switch paging
      this.page.page = index;
      this.getTableData();
    },
    emptyEntity() {
      this.entity.psid = 0;
      this.entity.type = 'Пропуск на посещение';
      this.entity.createdBy = '';// = this.$store.state.user.account
      this.entity.startdate = '';
      this.entity.enddate = '';
      this.entity.visitors = '';
      this.entity.contactperson = '';
      this.entity.phonenumber = '';
      this.entity.carnumber = '';
      this.entity.cartype = '';
      this.entity.parktype = '';
      this.entity.parklevel = '';
      this.entity.buildingaccess = 0;
      this.entity.state = 0;
    },
    addEntity() {
      this.isEdit = false;
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
      this.entity.visitors = data.visitors;
      this.entity.contactperson = data.contactperson;
      this.entity.phonenumber = data.phonenumber;
      this.entity.carnumber = data.carnumber;
      this.entity.cartype = data.cartype;
      this.entity.parktype = data.parktype;
      this.entity.parklevel = data.parklevel;
      this.entity.buildingaccess = data.buildingaccess;
      this.entity.state = data.state;
      this.entity.createTime = data.createTime;
      this.entity.historyLog = data.historyLog;
      this.dialog.title = 'Pass Approval Request';
      this.dialog.visible = true;
      this.entity.state !== 0 ? this.isEdit = true : this.isEdit = false;
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
            _this.entity.historyLog = _this.entity.historyLog + 'Updated by: ' + this.$store.state.user.account + ' at: ' + new Date().toLocaleString();
            updatePass(_this.entity).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Заявка отправлена на согласование', type: 'success' });
                _this.getTableData();
                _this.dialog.visible = false;
              }
            }).catch((err) => {
              console.log('err :', err);
            });
          } else {
            savePass(_this.entity).then((result) => {
              _this.isEdit = false;
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Заявка отправлена на согласование', type: 'success' });
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
