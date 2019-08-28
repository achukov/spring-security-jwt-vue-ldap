<template>
  <el-container v-has="'pass:view'">
    <el-header height ="35px">
      <div v-title>My Pass Approval</div>

      <div class="filter-container">
        <el-button v-has="'pass:new'" type="success" plain size="mini" @click="handleCreate">New Request</el-button>
        <el-input v-model="page.search" size="mini" placeholder="Search" prefix-icon="el-icon-search" style="width: 250px; margin-left: 10px;" class="filter-item" @keyup.enter.native="handleFilter()"/>
      </div>
      <!-- Create -->
      <el-dialog :visible.sync="createDialogFormVisible" :close-on-click-modal="false" :center="true" title="New Pass Approval Request" top="5vh" width="700px">
        <el-form ref="createForm" :model="temp" :rules="rules" :inline="false" label-position="top" size="mini" >
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <legend style="padding: 0 8px; font-weight: 700;">Время</legend>
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Дата начала" prop="startdate">
                  <el-date-picker v-model="temp.startdate" :picker-options="pickerOptions" type="date" format="dd-MM-yyyy" placeholder="Please pick a date"/>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Дата окончания" prop="enddate">
                  <el-date-picker v-model="temp.enddate" :picker-options="pickerOptions" type="date" format="dd-MM-yyyy" placeholder="Please pick a date" />
                </el-form-item>
              </el-col>
            </el-row>
            <el-form-item>
              <el-row :gutter="20">
                <el-col :span="12">
                  <el-form-item v-if="temp.nonwork" :label-width="formLabelWidth" label="Время начала" prop="starttime">
                    <el-time-picker v-model="temp.starttime" size="mini" placeholder="Select time" format="HH:mm" value-format="HH:mm:ss"/>
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-checkbox v-model="temp.nonwork" :true-label="1" :false-label="0" label="Посещение в нерабочее время"/>
                  <el-checkbox v-model="temp.escort" :true-label="1" :false-label="0" label="Требуется сопровождение службы безопасности"/>
                </el-col>
              </el-row>
            </el-form-item>
          </fieldset>
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <legend style="padding: 0 8px; font-weight: 700;">Посетители</legend>
            <el-row :gutter="20">
              <el-col :span="24">
                <el-form-item prop="visitors">
                  <div class="add_user">
                    <el-button type="success" size="mini" plain @click="handleCreateStaff()"><i class="el-icon-user"/></el-button>
                  </div>
                </el-form-item>
              </el-col>
            </el-row>
            <div class="visitorsData">
              <el-table :data="tempVisitorsTable" stripe size="mini">
                <el-table-column prop="lastname" label="Фамилия"/>
                <el-table-column prop="firstname" label="Имя"/>
                <el-table-column prop="middlename" label="Отчество"/>
                <el-table-column prop="pass_ser" label="Серия"/>
                <el-table-column prop="pass_num" label="Номер"/>
                <el-table-column fixed="right" width="50" >
                  <template slot-scope="scope">
                    <el-button type="danger" size="mini" icon="el-icon-delete" circle alt="delete" title="delete" @click="deleteStaff(scope.row)"/>
                  </template>
                </el-table-column>
              </el-table>
            </div>
          </fieldset>
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <legend style="padding: 0 8px; font-weight: 700;">Транспортные средства</legend>
            <el-row :gutter="20">
              <el-col :span="24">
                <el-form-item prop="vehicles">
                  <div class="add_vehicle">
                    <el-button type="success" size="mini" plain @click="handleCreateVehicle()"><i class="el-icon-truck"/></el-button>
                  </div>
                </el-form-item>
              </el-col>
            </el-row>
            <div class="vehicleData">
              <el-table :data="tempVehiclesTable" stripe size="mini">
                <el-table-column prop="carnumber" label="Номер"/>
                <el-table-column prop="cartype" label="Марка"/>
                <el-table-column prop="parktype" label="Вид" width="100px"/>
                <el-table-column prop="parklevel" label="Уровень"/>
                <el-table-column prop="buildingaccess" label="Доступ">
                  <template slot-scope="scope">
                    <el-tag size="mini">
                      {{ scope.row.buildingaccess | showBuild }}
                    </el-tag>
                  </template>
                </el-table-column>
                <el-table-column fixed="right" width="50" >
                  <template slot-scope="scope">
                    <el-button type="danger" size="mini" icon="el-icon-delete" circle alt="delete" title="delete" @click="deleteVehicle(scope.row)"/>
                  </template>
                </el-table-column>
              </el-table>
            </div>
          </fieldset>
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <legend style="padding: 0 8px; font-weight: 700;">Контакты</legend>
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Контактное лицо" prop="contactperson">
                  <el-input v-model="temp.contactperson" placeholder="username@bat.com"/>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Телефон для связи" prop="phonenumber">
                  <el-input v-mask="'+7 (###) ###-####'" v-model="temp.phonenumber" type="tel" placeholder="+7 (___) ___-____">
                    <i slot="prefix" class="el-input__icon el-icon-phone"/>
                  </el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </fieldset>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button size="mini" type="primary" @click="createData(1)">Save and Submit</el-button>
          <el-button size="mini" @click="createDialogFormVisible = false">Cancel</el-button>
        </span>
      </el-dialog>
      <!-- End -->
      <!-- Update -->
      <el-dialog :visible.sync="updateDialogFormVisible" :close-on-click-modal="false" :center="true" title="Pass Approval Request" top="5vh" width="700px">
        <el-form ref="updateForm" :model="temp" :rules="rules" :inline="false" label-position="top" size="mini" >
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <legend style="padding: 0 8px; font-weight: 700;">Время</legend>
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Дата начала" prop="startdate">
                  <el-date-picker :disabled="isEdit" v-model="temp.startdate" :picker-options="pickerOptions" type="date" format="dd-MM-yyyy" placeholder="Please pick a date"/>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Дата окончания" prop="enddate">
                  <el-date-picker :disabled="isEdit" v-model="temp.enddate" :picker-options="pickerOptions" type="date" format="dd-MM-yyyy" placeholder="Please pick a date" />
                </el-form-item>
              </el-col>
            </el-row>
            <el-form-item>
              <el-row :gutter="20">
                <el-col :span="12">
                  <el-form-item v-if="temp.nonwork" :label-width="formLabelWidth" label="Время начала" prop="starttime">
                    <el-time-picker :disabled="isEdit" v-model="temp.starttime" size="mini" placeholder="Select time" format="HH:mm" value-format="HH:mm:ss"/>
                  </el-form-item>
                </el-col>
                <el-col :span="12">
                  <el-checkbox :disabled="isEdit" v-model="temp.nonwork" :true-label="1" :false-label="0" label="Посещение в нерабочее время"/>
                  <el-checkbox :disabled="isEdit" v-model="temp.escort" :true-label="1" :false-label="0" label="Требуется сопровождение службы безопасности"/>
                </el-col>
              </el-row>
            </el-form-item>
          </fieldset>
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <legend style="padding: 0 8px; font-weight: 700;">Посетители</legend>
            <el-row :gutter="20">
              <el-col :span="24">
                <el-form-item prop="visitors">
                  <div class="add_user">
                    <el-button :disabled="isEdit" type="success" size="mini" plain @click="handleCreateStaff()"><i class="el-icon-user"/></el-button>
                  </div>
                </el-form-item>
              </el-col>
            </el-row>
            <div class="visitorsData">
              <el-table :data="tempVisitorsTable" stripe size="mini">
                <el-table-column prop="lastname" label="Фамилия"/>
                <el-table-column prop="firstname" label="Имя"/>
                <el-table-column prop="middlename" label="Отчество"/>
                <el-table-column prop="pass_ser" label="Серия"/>
                <el-table-column prop="pass_num" label="Номер"/>
                <el-table-column fixed="right" width="50" >
                  <template slot-scope="scope">
                    <el-button :disabled="isEdit" type="danger" size="mini" icon="el-icon-delete" circle alt="delete" title="delete" @click="deleteStaff(scope.row)"/>
                  </template>
                </el-table-column>
              </el-table>
            </div>
          </fieldset>
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <legend style="padding: 0 8px; font-weight: 700;">Транспортные средства</legend>
            <el-row :gutter="20">
              <el-col :span="24">
                <el-form-item prop="vehicles">
                  <div class="add_vehicle">
                    <el-button :disabled="isEdit" type="success" size="mini" plain @click="handleCreateVehicle()"><i class="el-icon-truck"/></el-button>
                  </div>
                </el-form-item>
              </el-col>
            </el-row>
            <div class="vehicleData">
              <el-table :data="tempVehiclesTable" stripe size="mini">
                <el-table-column prop="carnumber" label="Номер"/>
                <el-table-column prop="cartype" label="Марка"/>
                <el-table-column prop="parktype" label="Вид" width="100px"/>
                <el-table-column prop="parklevel" label="Уровень"/>
                <el-table-column prop="buildingaccess" label="Доступ">
                  <template slot-scope="scope">
                    <el-tag size="mini">
                      {{ scope.row.buildingaccess | showBuild }}
                    </el-tag>
                  </template>
                </el-table-column>
                <el-table-column fixed="right" width="50" >
                  <template slot-scope="scope">
                    <el-button :disabled="isEdit" type="danger" size="mini" icon="el-icon-delete" circle alt="delete" title="delete" @click="deleteVehicle(scope.row)"/>
                  </template>
                </el-table-column>
              </el-table>
            </div>
          </fieldset>
          <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
            <legend style="padding: 0 8px; font-weight: 700;">Контакты</legend>
            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Контактное лицо" prop="contactperson">
                  <el-input :disabled="isEdit" v-model="temp.contactperson" placeholder="username@bat.com"/>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item :label-width="formLabelWidth" label="Телефон для связи" prop="phonenumber">
                  <el-input v-mask="'+7 (###) ###-####'" :disabled="isEdit" v-model="temp.phonenumber" type="tel" placeholder="+7 (___) ___-____">
                    <i slot="prefix" class="el-input__icon el-icon-phone"/>
                  </el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </fieldset>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button v-if="!isEdit" size="mini" type="primary" @click="updateData()">Save</el-button>
          <el-button size="mini" @click="updateDialogFormVisible = false">Cancel</el-button>
          <div class="history">
            <el-button type="warning" size="mini" circle @click="showWorkflowHistory = true"><i class="el-icon-chat-line-square"/></el-button>
          </div>
        </span>
      </el-dialog>
      <!-- End -->
    </el-header>
    <el-main>
      <el-table v-loading="loading" :data="tableData" :default-sort = "{prop: 'psid', order: 'descending'}" size="mini" border tooltip-effect="light" element-loading-text="Loading..." style="width: 100%">
        <el-table-column sortable fixed prop="psid" label="Id" width="60"/>
        <el-table-column show-overflow-tooltip sortable prop="createTime" label="Создано" width="170">
          <template slot-scope="scope">
            <i class="el-icon-time"/>
            <span style="margin-left: 5px">{{ scope.row.createTime | formatTime }}</span>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip label="Кем создано" width="190">
          <template slot-scope="scope">
            <span style="margin-left: 5px"> {{ scope.row.createdBy | lowercase }}</span>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip label="Действителен с" width="150">
          <template slot-scope="scope">
            <i class="el-icon-time"/>
            <span style="margin-left: 5px">{{ scope.row.startdate | formatDate }}</span>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip label="Действителен по" width="150">
          <template slot-scope="scope">
            <i class="el-icon-time"/>
            <span style="margin-left: 5px">{{ scope.row.enddate | formatDate }}</span>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip label="Посетители" width="400">
          <template slot-scope="props">
            <div v-for="child in JSON.parse(props.row.visitors)" :key="child.lastname" label-position="left" >
              {{ child.lastname }} {{ child.firstname }} {{ child.middlename }} ({{ child.pass_ser }}-{{ child.pass_num }})
            </div>
          </template>
        </el-table-column>
        <el-table-column show-overflow-tooltip label="Транспорт" width="400">
          <template slot-scope="props">
            <div v-for="child in JSON.parse(props.row.vehicles)" :key="child.carnumber" label-position="left" >
              [{{ child.cartype }} {{ child.carnumber }}] {{ child.parktype }}:{{ child.parklevel }} [{{ child.buildingaccess | showBuild }}]
            </div>
          </template>
        </el-table-column>
        <el-table-column sortable prop="state" label="Статус" width="150">
          <template slot-scope="scope">
            <el-tag v-if="scope.row.state==0" type="info" size="mini">Новый</el-tag>
            <el-tag v-if="scope.row.state==1" type="warning" size="mini">На Согласовании</el-tag>
            <el-tag v-if="scope.row.state==2" type="success" size="mini">Утвержден</el-tag>
            <el-tag v-if="scope.row.state==3" type="danger" size="mini">Отменен</el-tag>
          </template>
        </el-table-column>
        <el-table-column fixed="right" label="Actions" width="125">
          <template slot-scope="scope">
            <el-tooltip :open-delay="600" class="item" effect="light" content="Edit document" placement="top-start">
              <el-button v-has="'pass:update'" type="primary" icon="el-icon-edit" plain size="mini" @click="handleUpdate(scope.row)"/>
            </el-tooltip>
            <el-tooltip :open-delay="600" class="item" effect="light" content="Delete document" placement="top-end">
              <el-button v-has="'pass:delete'" v-if="scope.row.state === 0" type="danger" icon="el-icon-delete" plain size="mini" @click="handleDelete(scope.row)"/>
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
    <el-dialog :visible.sync="staffDialogFormVisible" :close-on-click-modal="false" title="Посетитель" width="450px" height="400px">
      <el-form ref="CreateStaff" :model="staff" :rules="staffRules" size="mini" label-width="100px">
        <el-form-item label="Фамилия:" prop="lastname">
          <el-row type="flex" class="row-bg" justify="center">
            <el-col :span="18">
              <el-input v-model="staff.lastname" name="lastname" placeholder="Фамилия" />
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item label="Имя:" prop="firstname">
          <el-row type="flex" class="row-bg" justify="center">
            <el-col :span="18">
              <el-input v-model="staff.firstname" name="firstname" placeholder="Имя"/>
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item label="Отчество:" prop="middlename">
          <el-row type="flex" class="row-bg" justify="center">
            <el-col :span="18">
              <el-input v-model="staff.middlename" name="middlename" placeholder="Отчество" />
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item label="Паспорт:">
          <el-row type="flex" class="row-bg" justify="center">
            <el-col :span="6">
              <el-input v-model="staff.pass_ser" name="pass_ser" placeholder="Серия" />
            </el-col>
            <el-col :span="1" class="line">-</el-col>
            <el-col :span="11">
              <el-input v-model="staff.pass_num" name="pass_num" placeholder="Номер" />
            </el-col>
          </el-row>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button v-model="staff" size="mini" type="primary" @click="appendStaff(staff)">Сохранить</el-button>
        <el-button size="mini" @click="staffDialogFormVisible = false">Отменить</el-button>
      </span>
    </el-dialog>
    <el-dialog :visible.sync="vehicleDialogFormVisible" :close-on-click-modal="false" title="Транспортное средство" width="450px" height="400px">
      <el-form ref="CreateVehicle" :model="vehicle" :rules="vehicleRules" size="mini" label-width="90px">
        <el-form-item label="Номер:" prop="carnumber">
          <el-row type="flex" class="row-bg" justify="center">
            <el-col :span="18">
              <el-input v-uppercase v-model="vehicle.carnumber" name="carnumber" placeholder="А777АА199" />
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item label="Марка:" prop="cartype">
          <el-row type="flex" class="row-bg" justify="center">
            <el-col :span="18">
              <el-input v-uppercase v-model="vehicle.cartype" name="cartype" placeholder="TOYOTA"/>
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item label="Тип:" prop="parktype">
          <el-row type="flex" class="row-bg" justify="center">
            <el-col :span="18">
              <el-select v-model="vehicle.parktype" placeholder="Укажите вид парковки" class="filter-item">
                <el-option v-for="item in parkoptions" :key="item" :label="item" :value="item"/>
              </el-select>
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item label="Уровень:" prop="parklevel">
          <el-row type="flex" class="row-bg" justify="center">
            <el-col :span="18">
              <el-select v-model="vehicle.parklevel" placeholder="Укажите уровень парковки" class="filter-item">
                <el-option v-for="item in leveloptions" :key="item" :label="item" :value="item"/>
              </el-select>
            </el-col>
          </el-row>
        </el-form-item>
        <el-form-item prop="buildingaccess">
          <el-row type="flex" class="row-bg" justify="center">
            <el-col :span="18">
              <el-checkbox v-model="vehicle.buildingaccess" :true-label="1" :false-label="0" label="Требуется доступ в здание"/>
            </el-col>
          </el-row>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button v-model="vehicle" size="mini" type="primary" @click="appendVehicle(vehicle)">Сохранить</el-button>
        <el-button size="mini" @click="vehicleDialogFormVisible = false">Отменить</el-button>
      </span>
    </el-dialog>
    <el-dialog :visible.sync="showWorkflowHistory" title="Workflow History" width="800px" height="350px">
      <el-form ref="staff" :model="staff" size="mini">
        <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 10px; border: 1px solid #DCDFE6;">
          <el-steps :active="temp.state" align-center process-status="success" finish-status="finish">
            <el-step title="Новый" description="Заполнение документа"/>
            <el-step title="На Согласовании" description="Утверждается отделом безопасности"/>
            <el-step title="Утвержден" description="Заявка согласована"/>
          </el-steps>
          <div> Номер: {{ temp.psid }} </div>
          <div> Автор: {{ temp.createdBy | lowercase }} </div>
          <div style="white-space: pre-line;"> История: {{ temp.historyLog | formatText }} </div>
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
import { getMyPassPage, savePass, updatePass, removePassById } from '@/api/pass';
import { mapGetters } from 'vuex';

export default {
  components: {
  },
  data() {
    return {
      temp: {},
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
      formLabelWidth: '130px',
      comments: '',
      staff: {
        firstname: '',
        lastname: '',
        middlename: ''
      },
      vehicle: {
        carnumber: '',
        cartype: '',
        parktype: '',
        parklevel: '',
        buildingaccess: 0
      },
      showOverflowTooltip: true,
      updateDialogFormVisible: false,
      createDialogFormVisible: false,
      staffDialogFormVisible: false,
      vehicleDialogFormVisible: false,
      showWorkflowHistory: false,
      tableData: [],
      tempVisitorsTable: [],
      tempVehiclesTable: [],
      loading: false,
      isEdit: false,
      typeoptions: ['Пропуск на посещение', 'Пропуск на въезд'],
      parkoptions: ['Гостевой', 'Погрузка-разгрузка', 'Посадка пассажиров'],
      leveloptions: ['Наземный', 'Подземный'],
      statusoptions: [{ value: 0, label: 'Отменен' }, { value: 1, label: 'Новый' }, { value: 2, label: 'На Согласовании' }, { value: 3, label: 'Утвержден' }],
      // Verification rule
      rules: {
        startdate: [{ type: 'date', required: true, message: 'Необходимо заполнить дату начала', trigger: 'change' }],
        starttime: [{ required: true, message: 'Необходимо заполнить время', trigger: 'change' }],
        enddate: [{ type: 'date', required: true, message: 'Необходимо заполнить дату окончания', trigger: 'change' }],
        tempVisitorsTable: [{ required: true, message: 'Необходимо указать количество посетителей', trigger: 'blur' }],
        contactperson: [{ required: true, message: 'Необходимо заполнить список посетителей', trigger: 'blur' }],
        phonenumber: [
          { required: true, message: 'Необходимо указать номер телефона', trigger: 'blur' },
          { pattern: /^(\+7)?\s\(?[0-9]{3}\)?\s[0-9]{3}\-?[0-9]{4}$/, message: 'Укажите номер телефона полностью', trigger: 'blur' }
        ]
      },
      vehicleRules: {
        cartype: [{ required: true, message: 'Необходимо указать марку автомобиля', trigger: 'blur' }],
        parktype: [{ required: true, message: 'Необходимо указать вид парковки', trigger: 'blur' }],
        parklevel: [{ required: true, message: 'Необходимо указать указать уровень парковки', trigger: 'blur' }],
        carnumber: [{ required: true, message: 'Необходимо указать рег. номер автомобиля', trigger: 'blur' }]
      },
      staffRules: {
        lastname: [{ required: true, message: 'Необходимо указать фамилию', trigger: 'blur' }],
        firstname: [{ required: true, message: 'Необходимо указать имя', trigger: 'blur' }],
        middlename: [{ required: true, message: 'Необходимо указать отчество', trigger: 'blur' }],
        pass_ser: [{ required: true, message: 'Необходимо указать серию паспорта', trigger: 'blur' }],
        pass_num: [{ required: true, message: 'Необходимо указать номер паспорта', trigger: 'blur' }]
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
    appendStaff(staff) {
      const _this = this;
      _this.$refs['CreateStaff'].validate((valid) => {
        if (valid) {
          _this.tempVisitorsTable.push(staff);
          _this.staff = {};
          _this.staffDialogFormVisible = false;
        }
      });
    },
    appendVehicle(vehicle) {
      const _this = this;
      _this.$refs['CreateVehicle'].validate((valid) => {
        if (valid) {
          _this.tempVehiclesTable.push(vehicle);
          _this.vehicle = {};
          _this.vehicleDialogFormVisible = false;
        }
      });
    },
    deleteStaff(row) {
      var val = this.tempVisitorsTable.splice(row, 1);
      this.temp.visitors = JSON.stringify(val);
    },
    deleteVehicle(row) {
      var val = this.tempVehiclesTable.splice(row, 1);
      this.temp.vehicles = JSON.stringify(val);
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
      this.page.page = index;
      this.getTableData();
    },
    handleCreate() {
      this.temp = {
        nonwork: 0,
        escort: 0
      };
      this.tempVisitorsTable = [];
      this.tempVehiclesTable = [];
      this.$nextTick(() => {
        this.$refs['createForm'].clearValidate();
      });
      this.createDialogFormVisible = true;
    },
    handleCreateVehicle() {
      this.vehicle = {
        buildingaccess: 0
      };
      // this.tempVehiclesTable = [];
      this.$nextTick(() => {
        this.$refs['CreateVehicle'].clearValidate();
      });
      this.vehicleDialogFormVisible = true;
    },
    handleCreateStaff() {
      this.staff = {};
      // this.tempVisitorsTable = [];
      this.$nextTick(() => {
        this.$refs['CreateStaff'].clearValidate();
      });
      this.staffDialogFormVisible = true;
    },
    handleUpdate(row) {
      this.temp = Object.assign({}, row);
      this.temp.state !== 0 && this.temp.state !== 3 ? this.isEdit = true : this.isEdit = false;
      this.tempVehiclesTable = JSON.parse(this.temp.vehicles);
      this.tempVisitorsTable = JSON.parse(this.temp.visitors);
      this.updateDialogFormVisible = true;
      this.$nextTick(() => {
        this.$refs['updateForm'].clearValidate();
      });
    },
    handleDelete(row) {
      const _this = this;
      if (row.psid > 0) {
        _this.$confirm('Удалить Pass Approval Request № ' + row.psid + ' ?', 'warning',
          { confirmButtonText: 'Удалить', cancelButtonText: 'Отменить', type: 'warning' })
          .then(() => {
            removePassById(row.psid).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Запись успешно удалена.', type: 'success' });
                _this.getTableData();
              }
            }).catch((err) => {
              console.log('err :', err);
              _this.$notify.error({ title: 'Error', message: err.message });
            });
          }).catch(() => {
            _this.$message({ type: 'info', message: 'Отменено' });
          });
      }
    },
    createData(id) {
      const _this = this;
      _this.$refs['createForm'].validate((valid) => {
        if (valid) {
          _this.temp.state = id;
          _this.temp.historyLog = ';Created by: ' + this.$store.state.user.account + ' at: ' + new Date().toLocaleString();
          _this.temp.visitors = JSON.stringify(this.tempVisitorsTable);
          _this.temp.vehicles = JSON.stringify(this.tempVehiclesTable);
          savePass(_this.temp).then((result) => {
            if (result.status === 200) {
              _this.createDialogFormVisible = false;
              _this.$notify({ title: 'Success', message: 'New Pass succeeded!', type: 'success' });
              _this.getTableData();
            }
          }).catch((err) => {
            console.log('err :', err);
            _this.$notify.error({ title: 'Error', message: err.message });
          });
        }
      });
    },
    updateData() {
      const _this = this;
      _this.$refs['updateForm'].validate((valid) => {
        if (valid) {
          _this.temp.historyLog = _this.temp.historyLog + ';Updated by: ' + this.$store.state.user.account + ' at: ' + new Date().toLocaleString();
          _this.temp.visitors = JSON.stringify(this.tempVisitorsTable);
          _this.temp.vehicles = JSON.stringify(this.tempVehiclesTable);
          updatePass(_this.temp).then((result) => {
            if (result.status === 200) {
              _this.updateDialogFormVisible = false;
              _this.$notify({ title: 'Success', message: 'Modify the Pass successfully!', type: 'success' });
              _this.getTableData();
            }
          }).catch((err) => {
            console.log('err :', err);
          });
        }
      });
    }
  }
};

</script>

<style lang="scss">
  /*.el-form .add_user {*/
  /*  position: absolute;*/
  /*  top: -28px;*/
  /*  left: 100px;*/
  /*  z-index: 1;*/
  /*  padding-bottom: 3px;*/
  /*}*/
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
  padding: 6px 6px;
  font-size: 12px;
}
.el-form .add_vehicle .el-button{
  padding: 6px 6px;
  font-size: 12px;
}
.el-alert__title {
  font-size: 1rem;
}
.el-table .cell {
  word-break: break-word;

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
