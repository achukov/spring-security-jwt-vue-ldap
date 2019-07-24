<template>
  <el-container v-has="'user:view'">
    <el-header>
      <div v-title>User Management</div>
      <el-row :gutter="20">
        <el-col :span="6">
          <el-input v-model="page.search" placeholder="account" />
        </el-col>
        <el-col :span="6">
          <el-button type="primary" icon="el-icon-search">Search</el-button>
        </el-col>
        <el-col :span="6">
          <el-button v-has="'user:new'" type="info" @click="addUserEntity">New User</el-button>
        </el-col>
        <el-col :span="6">
          <!-- Modify user information -->
          <el-dialog :visible.sync="dialog.visible" :title="dialog.title" width="30%">
            <el-form id="user" ref="entity" :model="entity" :rules="rules" label-width="80px">
              <template v-if="entity.uid != ''">
                <el-form-item label="User ID">
                  <el-input v-model="entity.uid" disabled />
                </el-form-item>
              </template>
              <el-form-item label="Avatar" prop="avatar">
                <user-avatar :avatar="entity.avatar" @getAvatar="getAvatar"/>
              </el-form-item>
              <!-- <el-form-item label="NickName" prop="nickname">
                <el-input v-model="entity.nickname" clearable />
              </el-form-item>  -->
              <el-form-item label="Account" prop="account">
                <el-input v-model="entity.account" clearable />
              </el-form-item>
              <template v-if="entity.uid == ''">
                <el-form-item label="Password" prop="password">
                  <el-input v-model="entity.password" type="password" clearable/>
                </el-form-item>
              </template>
              <el-form-item label="Mail" prop="mail">
                <el-input v-model="entity.mail" clearable />
              </el-form-item>
              <!-- <el-form-item label="Gender" prop="gender">
                <el-date-picker v-model="entity.birthday" type="date" placeholder="Select date"/>
              </el-form-item>
              <el-form-item label="Birthday" prop="birthday">
                <el-select v-model="entity.gender" placeholder="please choose">
                  <el-option v-for="item in genderOptions" :key="item.value" :label="item.label" :value="item.value" />
                </el-select>
              </el-form-item> -->
              <el-form-item label="Departament" prop="dept">
                <el-select v-model="entity.dept" placeholder="please choose">
                  <el-option v-for="item in deptList" :key="item.id" :label="item.name" :value="item.id" />
                </el-select>
              </el-form-item>
              <el-form-item label="status">
                <el-select v-model="entity.state" placeholder="please choose">
                  <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value" />
                </el-select>
              </el-form-item>
            </el-form>
            <span slot="footer" class="dialog-footer">
              <el-button @click="dialog.visible = false">Cancel</el-button>
              <el-button type="primary" @click="saveAndFlush">Save</el-button>
            </span>
          </el-dialog>

          <!-- Modify user role -->
          <el-dialog :visible.sync="userRole.visible" :title="userRole.title" width="40%">
            <el-checkbox-group v-model="entity.roles">
              <el-checkbox v-for="(item,index) in roleList" :label="item.rid" :key="index" >{{ item.describe }}</el-checkbox>
            </el-checkbox-group>
            <span slot="footer" class="dialog-footer">
              <el-button @click="userRole.visible = false">Cancel</el-button>
              <el-button type="primary" @click="saveUserRoles">Save</el-button>
            </span>
          </el-dialog>
        </el-col>
      </el-row>
    </el-header>
    <el-main>
      <el-table v-loading="loading" :data="tableData" border style="width: 100%">
        <!-- <el-table-column prop="nickname" label="Nickname" fixed /> -->
        <el-table-column prop="uid" label="User ID" width="150" />
        <el-table-column label="Avatar" width="100">
          <template slot-scope="scope">
            <div class="avatar-wrapper" @click="viewBigAvatar(scope.row.avatar)">
              <img :src="scope.row.avatar" class="user-avatar">
            </div>
          </template>
        </el-table-column>
        <el-table-column prop="account" label="Account" />
        <!-- <el-table-column label="Gender" width="50">
          <template slot-scope="scope">{{ scope.row.gender | showGender }}</template>
        </el-table-column>
        <el-table-column label="Birthday" width="100">
          <template slot-scope="scope">{{ scope.row.birthday | formatDate }}</template>
        </el-table-column> -->
        <el-table-column prop="mail" label="Mail" />
        <el-table-column label="Role">
          <template slot-scope="scope">
            <el-tooltip v-for="(role , index) in scope.row.roles" :key="index" :content="role.name" class="item" effect="dark" placement="top-start">
              <el-tag size="mini">{{ role.describe }}</el-tag>
            </el-tooltip>
          </template>
        </el-table-column>
        <el-table-column label="Department" width="100">
          <template slot-scope="scope">
            <el-tag size="mini">{{ scope.row.department.name }}</el-tag>
          </template>
        </el-table-column>
        <el-table-column label="Status" width="70">
          <template slot-scope="scope">{{ scope.row.state | showState }}</template>
        </el-table-column>
        <el-table-column label="Created">
          <template slot-scope="scope">{{ scope.row.createTime | formatTime }}</template>
        </el-table-column>
        <el-table-column label="Updated">
          <template slot-scope="scope">{{ scope.row.upTime | formatTime }}</template>
        </el-table-column>
        <el-table-column fixed="right" label="Actions" width="250">
          <template slot-scope="scope">
            <el-button type="info" size="mini" @click="updateUserRole(scope.row)">Roles</el-button>
            <el-button v-has="'user:update'" type="primary" size="mini" @click="updateUserEntity(scope.row)">Edit</el-button>
            <el-button v-has="'user:delete'" type="danger" size="mini" @click="deleteUserEntity(scope.row)">Delete</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-main>
    <el-footer>
      <el-pagination :page-size="page.size" :total="page.total" layout="prev, pager, next, jumper" @current-change="currentChange" />
    </el-footer>
  </el-container>
</template>

<script>

import { getUserPage, saveUser, updateUser, removeUserById, updateUserRoles } from '@/api/user'
import { getDeptAll } from '@/api/department'
import { getRoleAll } from '@/api/role'
import UserAvatar from '@/components/UserAvatar'

export default {
  components: {
    UserAvatar
  },
  data() {
    return {
      page: {
        page: 1,
        size: 10,
        search: '',
        total: 0
      },
      entity: {
        uid: '',
        avatar: '',
        nickname: '',
        account: '',
        password: '',
        mail: '',
        gender: 1,
        birthday: '',
        state: 0,
        dept: 0,
        roles: [],
        createTime: ''
      },
      dialog: {
        visible: false,
        title: ''
      },
      userRole: {
        visible: false,
        title: ''
      },
      tableData: [],
      loading: false,
      deptList: [],
      roleList: [],
      options: [{ value: 0, label: 'Deleted' }, { value: 1, label: 'Normal' }, { value: 2, label: 'Hidden' }],
      genderOptions: [{ value: 0, label: 'Female' }, { value: 1, label: 'male' }, { value: 2, label: 'Unknown' }]
      // Verification rule
      // rules: {
      //   avatar: [{ required: true, message: 'The avatar cannot be empty', trigger: 'blur' },
      //     { validator: function(rule, value, callback) {
      //       const regex = /^(?:([A-Za-z]+):)?(\/{0,3})([0-9.\-A-Za-z]+)(?::(\d+))?(?:\/([^?#]*))?(?:\?([^#]*))?(?:#(.*))?$/
      //       if (!regex.test(value)) {
      //         callback(new Error('The avatar address format is unqualified'))
      //       } else {
      //         callback()
      //       }
      //     }, trigger: 'blur' }],
      //   account: [{ required: true, message: 'Login account cannot be empty', trigger: 'blur' },
      //     { validator: function(rule, value, callback) {
      //       const regex = /^[a-zA-Z0-9_-]{6,30}$/
      //       if (!regex.test(value)) {
      //         callback(new Error('Accounts begin with a letter and are between 6 and 16 in length. They can only contain characters, numbers, and underscores.'))
      //       } else {
      //         callback()
      //       }
      //     }, trigger: 'blur' }],
      //   // account: [{ required: true, message: 'account can not be blank', trigger: 'blur' }],
      //   password: [{ required: true, message: 'Password can not be blank', trigger: 'blur' }
      //     // { validator: function(rule, value, callback) {
      //     //   const regex = /^[a-zA-Z]\w{5,17}$/
      //     //   if (!regex.test(value)) {
      //     //     callback(new Error('Passwords begin with a letter and are between 6 and 18 characters long. They can only contain characters, numbers, and underscores.'))
      //     //   } else {
      //     //     callback()
      //     //   }
      //     // }, trigger: 'blur' }
      //   ],
      //   mail: [{ required: true, message: 'E-mail can not be empty', trigger: 'blur' },
      //     { validator: function(rule, value, callback) {
      //       const regex = /^\w+([-+.]\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*$/
      //       if (!regex.test(value)) {
      //         callback(new Error('Email address format is incorrect'))
      //       } else {
      //         callback()
      //       }
      //     }, trigger: 'blur' }]
      // }
    }
  },
  created() {
    this.getUserTableData()
    this.getDeptListData()
    this.getRoleListData()
  },
  methods: {
    getUserTableData() {
      const _this = this
      _this.loading = true
      getUserPage(_this.page).then((result) => {
        if (result.status === 200) {
          _this.tableData = result.data.content
          _this.page.total = result.data.totalElements
          _this.loading = false
        }
      }).catch((err) => {
        console.log('err :', err)
      })
    },
    getDeptListData() {
      // Get a list of departments
      const _this = this
      _this.loading = true
      getDeptAll().then((result) => {
        if (result.status === 200) {
          _this.deptList = result.data
          _this.loading = false
        }
      }).catch((err) => {
        console.log('err :', err)
      })
    },
    getRoleListData() {
      // Get the list of roles
      const _this = this
      _this.loading = true
      getRoleAll().then((result) => {
        if (result.status === 200) {
          _this.roleList = result.data
          _this.loading = false
        }
      }).catch((err) => {
        console.log('err :', err)
      })
    },
    currentChange(index) {
      // Switch paging
      this.page.page = index
      this.getUserTableData()
    },
    viewBigAvatar(url) {
      // View big avatar
      window.open(url)
    },
    updateUserRole(data) {
      // Reassign user permissions
      this.getRoleListData()
      this.emptyEntity()
      this.userRole = {
        visible: true,
        title: 'Modify user role'
      }
      const roles = []
      data.roles.forEach(role => {
        roles.push(role.rid)
      })
      this.entity.uid = data.uid
      this.entity.account = data.account
      this.entity.roles = roles
    },
    saveUserRoles() {
      // Save the user's role information
      const _this = this
      const roles = this.entity.roles
      if (roles !== null && roles.length > 0) {
        _this.$confirm('Make sure to modify [' + _this.entity.account + '] Role? Do you want to continue?', 'Warning',
          { confirmButtonText: 'Confirm', cancelButtonText: 'Cancel', type: 'warning' })
          .then(() => {
            updateUserRoles({ uid: _this.entity.uid, rids: roles }).then((result) => {
              if (result.status === 200) {
                _this.$message({ type: 'success', message: 'Modify the role successfully!' })
                _this.userRole.visible = false
                _this.getUserTableData()
              }
            }).catch((err) => {
              console.log('err :', err)
              _this.$notify.error({ title: 'Error', message: err.message })
            })
          }).catch(() => {
            _this.$message({ type: 'info', message: 'Undelete' })
          })
      } else {
        _this.$notify.error({ title: 'Error', message: 'Please select the role before you can modify it.' })
      }
    },
    getAvatar(data) {
      // Get the value of the uploaded avatar
      this.entity.avatar = data
    },
    emptyEntity() {
      // Clear user information
      this.entity = {
        uid: '',
        avatar: '',
        // nickname: '',
        account: '',
        password: '',
        mail: '',
        gender: 1,
        birthday: '',
        state: 0,
        dept: 0,
        roles: [],
        createTime: ''
      }
    },
    addUserEntity() {
      // Add user
      this.getDeptListData()
      this.emptyEntity()
      this.dialog = {
        visible: true,
        title: 'New user'
      }
    },
    updateUserEntity(data) {
      // Modify user information
      this.emptyEntity()
      this.entity = {
        uid: data.uid,
        avatar: data.avatar,
        // nickname: data.nickname,
        account: data.account,
        password: data.password,
        mail: data.mail,
        gender: data.gender,
        birthday: data.birthday,
        state: data.state,
        dept: data.department.id,
        roles: data.roles,
        createTime: data.createTime
      }
      this.dialog = {
        visible: true,
        title: 'Modify user information'
      }
    },
    deleteUserEntity(data) {
      // Delete this user
      const _this = this
      if (data.uid !== null && data.uid.trim() !== '') {
        _this.$confirm('Make sure to delete [' + data.account + '] Do you want to continue?', 'Warning',
          { confirmButtonText: 'Confirm', cancelButtonText: 'Cancel', type: 'warning' })
          .then(() => {
            removeUserById(data.uid).then((result) => {
              if (result.status === 200) {
                _this.$message({ type: 'success', message: 'successfully deleted!' })
                _this.getUserTableData()
              }
            }).catch((err) => {
              console.log('err :', err)
              _this.$notify.error({ title: 'Error', message: err.message })
            })
          }).catch(() => {
            _this.$message({ type: 'info', message: 'Undelete' })
          })
      } else {
        _this.$notify.error({ title: 'Error', message: 'Please select the user before you can delete it.' })
      }
    },
    saveAndFlush() {
      const _this = this
      _this.$refs.entity.validate(valid => {
        if (valid) {
          if (_this.entity.uid !== '') {
            updateUser(_this.entity).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Modify user success!', type: 'success' })
                _this.getUserTableData()
                _this.dialog.visible = false
              }
            }).catch((err) => {
              console.log('err :', err)
            })
          } else {
            saveUser(_this.entity).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Add user success!', type: 'success' })
                _this.getUserTableData()
                _this.dialog.visible = false
              }
            }).catch((err) => {
              console.log('err :', err)
              _this.$notify.error({ title: 'Error', message: err.message })
            })
          }
        }
      })
    }
  }
}

</script>
<style lang='scss' scoped>
.avatar-wrapper {
  cursor: pointer;
  position: relative;
  .user-avatar {
    width: 50px;
    height: 50px;
    border-radius: 10px;
  }
}
</style>
<style>
.el-tag:hover {
  cursor: pointer;
}
</style>
