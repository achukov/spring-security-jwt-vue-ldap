<template>
  <div class="app-container">
    <div class="filter-container findscreen">
      <el-row :gutter="20">
        <el-col :span="24">
          <div class="fr">
            <el-button type="primary" icon="iconfont my-icon-add" class="filter-item" @click="handleCreate">new record</el-button>
          </div>
        </el-col>
      </el-row>
    </div>
    <div class="dutymap">
      <el-calendar v-model="calendarValue">
        <template slot="dateCell" slot-scope="{date, data}">
          <div class="dutymap_con">
            <div class="foodday">{{ date.getDate() }}</div>
            <div v-if="data.isSelected" class="iconfont my-icon-choiceTop foodchoice" title="Selected"/>
            <template>
              <template v-for="item in list">
                <div v-if="item.dutydate === data.day" :key="item.id">
                  <div class="foodlist">
                    <div class="name_left" @click="handleUpdate(item)">
                      {{ item.oid }}
                    </div>
                    <div class="name_right">
                      <el-button type="danger" size="mini" icon="el-icon-delete" plain alt="delete" title="delete" @click="handleDelete(item)" />
                    </div>
                  </div>
                </div>
              </template>
            </template>
          </div>
        </template>
      </el-calendar>
    </div>
    <el-dialog :visible.sync="createDialogFormVisible" title="New value-added class information" width="450px">
      <el-form ref="createForm" :model="temp" :rules="rules" label-position="right" label-width="100px">
        <div class="sameform">
          <el-form-item label="Date：" prop="dutydate">
            <el-date-picker v-model="temp.dutydate" type="date" placeholder="Please select a date" format="dd-MM-yyyy" value-format="yyyy-MM-dd" />
          </el-form-item>
          <el-form-item label="Duty note：">
            <el-input v-model="temp.remark" type="textarea" placeholder="Please enter the duty note" rows="5" />
          </el-form-item>
        </div>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="createData()">Save</el-button>
        <el-button @click="createDialogFormVisible = false">Cancel</el-button>
      </div>
    </el-dialog>
    <el-dialog :visible.sync="updateDialogFormVisible" title="Edit duty information" width="450px">
      <el-form ref="updateForm" :model="temp" :rules="rules" label-position="right" label-width="100px">
        <div class="sameform">
          <el-form-item label="Duty date：" prop="dutydate">
            <el-date-picker v-model="temp.dutydate" type="date" placeholder="Please select a date" format="dd-MM-yyyy" value-format="yyyy-MM-dd" />
          </el-form-item>
          <el-form-item label="Duty note：">
            <el-input v-model="temp.remark" type="textarea" placeholder="Please enter the duty note" rows="5" />
          </el-form-item>
        </div>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="updateData()">Save</el-button>
        <el-button @click="updateDialogFormVisible = false">Cancel</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import DatePicker from '@/components/DatePicker/index';
import { getCurrentMonthFirst, parseTime, getCurrentMonthLast } from '@/utils';
import { queryStaffDutySetting, createStaffDutySetting, deleteStaffDutySetting, updateStaffDutySetting } from '@/api/duty';
import { mapGetters } from 'vuex';
export default {
  name: 'DutySetting',
  components: {
    DatePicker
  },
  data() {
    return {
      temp: {},
      list: null,
      total: 0,
      listLoading: false,
      listQuery: {
        page: 1,
        size: 10,
        search: null,
        total: 0
      },
      rules: {
        dutydate: [
          { required: true, message: 'Please select a date', trigger: 'change' }
        ]
      },
      defaultProps: {
        children: 'children',
        label: 'label'
      },
      branchId: undefined,
      branchsMap: undefined,
      updateDialogFormVisible: false,
      createDialogFormVisible: false,
      updateCheckDialogFormVisible: false,
      createCheckDialogFormVisible: false,
      createCycleDialogFormVisible: false,
      staffDialogFormVisible: false,
      staffNames: undefined,
      dutyId: undefined,
      calendarValue: undefined
    };
  },
  computed: {
    ...mapGetters([
      'user'
    ])
  },
  watch: {
    calendarValue: {
      handler(newValue, oldValue) {
        var newVal = new Date(newValue);
        this.listQuery.startDate = getCurrentMonthFirst(newVal);
        this.listQuery.endDate = getCurrentMonthLast(newVal);
        this.getList();
      },
      deep: true
    }
  },
  created() {
    this.getList();
  },
  methods: {
    getList() {
      this.list = [];
      queryStaffDutySetting(this.listQuery).then(response => {
        this.list = response.data;
        console.log(this.list);
        this.total = response.data.total;
      });
    },
    handleCreate() {
      this.temp = {
        staffIdsArray: []
      };
      this.staffNames = undefined;
      this.$nextTick(() => {
        this.$refs['createForm'].clearValidate();
      });
      this.createDialogFormVisible = true;
    },
    createData() {
      this.$refs['createForm'].validate((valid) => {
        if (valid) {
          this.temp.username = this.$store.state.user.mail;
          this.temp.oid = this.$store.state.user.employeeId;
          createStaffDutySetting(this.temp).then(ret => {
            this.createDialogFormVisible = false;
            this.$message({
              message: ret.message,
              type: 'success'
            });
            this.getList();
          });
        }
      });
    },
    handleDelete(row) {
      this.$confirm('This action will permanently delete the data. Do you want to continue?', 'warning', {
        confirmButtonText: 'Confirm',
        cancelButtonText: 'Cancel',
        type: 'warning'
      }).then(() => {
        this.deleteData(row);
      });
    },
    deleteData(row) {
      deleteStaffDutySetting(row.id).then(ret => {
        this.$message({
          type: 'success',
          message: ret.message
        });
        if (this.list.length === 1) {
          this.listQuery.current -= 1;
        }
        this.getList();
      });
    },
    handleUpdate(row) {
      this.temp = Object.assign({}, row);
      this.updateDialogFormVisible = true;
      this.$nextTick(() => {
        this.$refs['updateForm'].clearValidate();
      });
    },
    updateData() {
      this.$refs['updateForm'].validate((valid) => {
        if (valid) {
          if (this.temp.staffIdsArray) {
            this.temp.staffIds = this.temp.staffIdsArray.join(',');
          } else {
            this.$message({
              type: 'warning',
              message: '请添加值班人'
            });
            return;
          }
          updateStaffDutySetting(this.temp).then(ret => {
            this.updateDialogFormVisible = false;
            this.$message({
              message: ret.message,
              type: 'success'
            });
            this.getList();
          });
        }
      });
    },
    handleCreateCheck(item) {
      this.cronStrList = [];
      this.cycleCronList = [];
      this.temp = Object.assign({}, item);
      this.temp.categoryId = this.temp.id;
      delete this.temp.id;
      this.createCheckDialogFormVisible = true;
      this.$nextTick(() => {
        this.$refs['createCheckForm'].clearValidate();
      });
    },
    getCurrentMonthFirst(time) {
      return getCurrentMonthFirst(time);
    },
    formatTime(time, cFormat) {
      return parseTime(time, cFormat);
    }
    // handleSelectStaff(val) {
    //   if (val.length <= 0) {
    //     this.staffNames = null;
    //     this.temp.staffIdsArray = null;
    //     this.staffDialogFormVisible = false;
    //     return;
    //   }
    //   // 获取教职工信息
    //   getStaffsByStaffIds({ ids: val.join(',') }).then(ret => {
    //     if (ret.data.length > 0) {
    //       var str = null;
    //       for (var i in ret.data) {
    //         if (!str) {
    //           str = ret.data[i].staffName;
    //         } else {
    //           str += ',' + ret.data[i].staffName;
    //         }
    //       }
    //       this.staffNames = str;
    //     }
    //   });
    //   this.staffDialogFormVisible = false;
    //   this.temp.staffIdsArray = val;
    // }
  }
};
</script>

<style>
  .moreperson span{
    line-height: 30px !important;
    margin-right:5px;
    float: left;
  }
  .moreperson span.itemdescadd{
    background: #409EFF;
    width: 30px;
    height: 30px;
    display: block;
    border-radius: 50%;
    text-align: center;
    color: #fff;
  }
  .myitem_foodmenuday .message {
    width: 350px;
    height: 360px;
  }
  .myitem_foodmenuday .message .item .desc {
    height: 240px;
  }
  .dutymap .el-calendar-table .el-calendar-day {
    height: 130px;
    overflow: hidden;
  }
  .dutymap .el-calendar-table td.is-today {
    background: #F2F8FE;
  }
  .dutymap .dutymap_con {
    position: relative;
    height: 110px;
  }
  .dutymap .dutymap_con .foodday {
    position: absolute;
    top: 5px;
    left: 0;
    text-align: center;
    font-weight: bold;
    font-size: 16px;
  }
  .dutymap .dutymap_con .foodchoice {
    position: absolute;
    top: -10px;
    right: -8px;
    z-index: 1;
    font-size: 30px;
    color: #409EFF;
  }
  .dutymap .dutymap_con .foodcontrol {
    position: absolute;
    bottom: -10px;
    right: 0;
    font-size: 18px;
    color: #999;
    width: 100%;
    height: 30px;
    text-align: right;
  }
  .dutymap .dutymap_con .foodlist .el-button{
    padding: 6px;
    font-size: 12px;
  }
  .dutymap .dutymap_con .foodlist {
    position: relative;
    left: 30px;
    font-size: 12px;
    overflow-y: auto;
    width: 120px;
    height: 19px;
    display:table;
  }
  .dutymap .dutymap_con .foodlist .name_left {
    position: relative;
    display:table-cell;
    left: 10px;
  }
  .dutymap .dutymap_con .foodlist .name_right {
    display:table-cell;
  }
  .chocieweekfood .el-tabs__nav{
    text-align: center;
    width: 100%;
    padding-left: 50px;
  }
  .chocieweekfood .el-tabs__active-bar{
    display: none;
  }
  .chocieweekfood .el-tabs__item.is-active {
    color: #409EFF;
    font-weight: bold;
    border-bottom: 2px solid #409EFF;
  }
  .chocieweekfood .el-tabs__item{
    color: #333;
    padding: 0 20px !important;
  }
  .chocieweekfood .el-tabs__content{
    padding-top:15px;
  }
</style>
