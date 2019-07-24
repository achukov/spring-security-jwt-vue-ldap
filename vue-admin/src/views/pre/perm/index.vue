<!--  -->
<template>
  <div v-loading="loading" v-has="'perm:view'" id="pmn">
    <div v-title>Authority management</div>
    <el-row :gutter="20">
      <el-col :span="10">
        <el-tree :data="treeData" :props="defaultProps" accordion @node-click="handleNodeClick"/>
      </el-col>
      <el-col :span="14">
        <el-card class="box-card">

          <div slot="header" class="clearfix">
            <span class="card-header">Permission details</span>
            <el-button-group style="float: right;">
              <el-button v-has="'perm:update'" type="primary" size="mini" icon="el-icon-edit" @click=" isEdit = !isEdit ">Update</el-button>
              <el-button v-has="'perm:new'" type="primary" size="mini" icon="el-icon-share" @click="addEntity">New</el-button>
              <el-button v-has="'perm:delete'" type="primary" size="mini" icon="el-icon-delete" @click="deleteEntity">Delete</el-button>
            </el-button-group>
          </div>

          <el-form ref="pmnForm" :rules="rules" :model="pmnForm" label-width="100px">
            <el-form-item label="Privilege ID">
              <el-input v-model="pmnForm.pid" :disabled="true"/>
            </el-form-item>

            <el-form-item label="Title" prop="title">
              <el-input :disabled="isEdit" v-model="pmnForm.title" clearable />
            </el-form-item>

            <template v-if="pmnForm.type === 'menu'">
              <el-form-item label="Icon" prop="icon">
                <el-input :disabled="isEdit" v-model="pmnForm.icon" clearable />
              </el-form-item>
            </template>

            <el-form-item label="Uniquely identifies" prop="resources">
              <el-input :disabled="isEdit" v-model="pmnForm.resources" clearable placeholder="Emphasize that it must be the only English letter" />
            </el-form-item>

            <el-form-item label="Superior authority" prop="parentId" >
              <el-select v-model="pmnForm.parentId" :disabled="isEdit" filterable clearable placeholder="Select superior authority" >
                <el-option v-for="item in listDate" :key="item.pid" :label="item.title" :value="item.pid"/>
              </el-select>
            </el-form-item>

            <el-form-item label="Type" prop="type" >
              <el-select v-model="pmnForm.type" :disabled="isEdit" placeholder="Choose a type" >
                <el-option v-for="item in pmnType" :key="item.type" :label="item.name" :value="item.type"/>
              </el-select>
            </el-form-item>

            <el-form-item label="Description" prop="describe">
              <el-input :disabled="isEdit" v-model="pmnForm.describe" clearable />
            </el-form-item>

            <el-form-item v-if="isEdit === false">
              <el-button type="primary" @click="saveAndFlush">Save</el-button>
              <el-button @click=" isEdit = !isEdit ">Cancel</el-button>
            </el-form-item>

          </el-form>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>

import { getPermissionTree, getPermissionAll, savePermission, updatePermission, removePermissionById } from '@/api/permission'

export default {
  components: {},
  data() {
    return {
      pmnForm: {
        pid: 0,
        icon: '',
        title: '',
        parentId: '',
        resources: '',
        describe: '',
        type: ''
      },
      loading: false,
      isEdit: true, // Can I edit?
      treeData: [],
      listDate: [],
      pmnType: [
        { type: 'button', name: 'Button' },
        { type: 'menu', name: 'Menu' }
      ],
      defaultProps: {
        children: 'children',
        label: 'title'
      },
      // Verification rule
      rules: {
        title: [{ required: true, message: 'Permission title cannot be empty', trigger: 'blur' }],
        parentId: [{ required: true, message: 'Superior authority cannot be empty', trigger: 'blur' }],
        resources: [{ required: true, message: 'The ID must be globally unique', trigger: 'blur' },
          { validator: function(rule, value, callback) {
            const regex = /[a-z]{2}$/
            if (!regex.test(value)) {
              callback(new Error('The logo must be in English lowercase with more than 5 letters'))
            } else {
              callback()
            }
          }, trigger: 'blur' }
        ],
        describe: [{ required: true, message: 'Permission description cannot be empty', trigger: 'blur' }],
        type: [{ required: true, message: 'Permission type cannot be empty', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getPermissionTreeData()
    this.getPermissionListData()
  },
  methods: {
    getPermissionTreeData() {
      // Get permission list to display as tree node
      const _this = this
      _this.loading = true
      getPermissionTree().then((result) => {
        if (result.status === 200) {
          _this.treeData = result.data
          _this.loading = false
        }
      }).catch((err) => {
        console.log('err :', err)
      })
    },
    getPermissionListData() {
      // Get permission list to display as a list
      const _this = this
      _this.loading = true
      getPermissionAll().then((result) => {
        if (result.status === 200) {
          _this.listDate = result.data
          _this.listDate.push({ pid: 0, title: 'Menu' })
          _this.loading = false
        }
      }).catch((err) => {
        console.log('err :', err)
      })
    },
    handleNodeClick(data) {
      this.pmnForm = {
        pid: data.pid,
        icon: data.icon,
        title: data.title,
        parentId: data.parentId,
        resources: data.resources,
        describe: data.describe,
        createTime: data.createTime,
        type: data.type
      }
    },
    addEntity() {
      this.pmnForm = { pid: 0, icon: '', title: '', parentId: 0, resources: '', describe: '', type: 'menu' }
      this.isEdit = false
    },
    deleteEntity() {
      const _this = this
      if (_this.pmnForm.pid > 0) {
        _this.$confirm('Make sure to delete [' + _this.pmnForm.title + '] ? Please confirm that there are no sub-rights under this permission. And no role is using this permission. Otherwise it cannot be deleted. Continue?', 'Warning',
          { confirmButtonText: 'Confirm', cancelButtonText: 'Cancel', type: 'warning' })
          .then(() => {
            removePermissionById(_this.pmnForm.pid).then((result) => {
              if (result.status === 200) {
                _this.$notify({ type: 'success', title: 'Success', message: 'Delete permission succeeded!' })
                _this.getPermissionTreeData()
                _this.getPermissionListData()
                _this.isEdit = true
              }
            }).catch((err) => {
              console.log('err :', err)
              _this.$notify.error({ title: 'Error', message: err.message })
            })
          }).catch(() => {
            _this.$message({ type: 'info', message: 'Undelete' })
          })
      } else {
        _this.$notify.error({ title: 'Error', message: 'Please select the permission before you can delete it.' })
      }
    },
    saveAndFlush() {
      const _this = this
      _this.$refs.pmnForm.validate(valid => {
        if (valid) {
          if (_this.pmnForm.pid > 0) {
            updatePermission(_this.pmnForm).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Modify permission successfully!', type: 'success' })
                _this.getPermissionTreeData()
                _this.getPermissionListData()
              }
              _this.isEdit = true
            }).catch((err) => {
              console.log('err :', err)
              _this.$notify.error({ title: 'Error', message: err.message })
            })
          } else {
            savePermission(_this.pmnForm).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'New permission succeeded!', type: 'success' })
                _this.getPermissionTreeData()
                _this.getPermissionListData()
              }
              _this.isEdit = true
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

</style>

<style>
#pmn .el-tree-node__expand-icon,
#pmn .el-tree-node__label {
  font-size: 1.5rem;
}

#pmn .el-tree-node__content {
  height: 2.5rem;
}

#pmn .el-alert__title{
  font-size: 1rem;
}

</style>
