<!-- Department management -->
<template>
  <el-container v-has="'dept:view'" id="dept">
    <el-header>
      <div v-title>Department management</div>
      <el-alert :title="website.dept.alert" type="info"/>
    </el-header>
    <el-main v-loading="loading">
      <el-row :gutter="20">
        <el-col :span="8">
          <div class="grid-content bg-purple">
            <el-tree :data="treeData" :props="defaultProps" :default-expand-all="true" @node-click="handleNodeClick" />
          </div>
        </el-col>
        <el-col :span="16">

          <el-card class="box-card">
            <div slot="header" class="clearfix">
              <span class="card-header">Department details</span>
              <el-button-group style="float: right;">
                <el-button v-has="'dept:update'" type="primary" size="mini" icon="el-icon-edit" @click=" isEdit = !isEdit ">Update</el-button>
                <el-button v-has="'dept:new'" type="primary" size="mini" icon="el-icon-share" @click="addEntity">New</el-button>
                <el-button v-has="'dept:delete'" type="primary" size="mini" icon="el-icon-delete" @click="deleteEntity">Delete</el-button>
              </el-button-group>
            </div>

            <el-form ref="deptForm" :rules="rules" :model="deptForm" label-width="100px">
              <el-form-item label="Department ID">
                <el-input v-model="deptForm.id" :disabled="true"/>
              </el-form-item>
              <el-form-item label="Department name" prop="name">
                <el-input :disabled="isEdit" v-model="deptForm.name" clearable />
              </el-form-item>
              <el-form-item label="Higher office" prop="parentId" >
                <el-select v-model="deptForm.parentId" :disabled="isEdit" placeholder="Choose a superior department" >
                  <el-option v-for="item in listData" :key="item.id" :label="item.name" :value="item.id"/>
                </el-select>
              </el-form-item>
              <el-form-item label="Level" prop="level">
                <el-input :disabled="isEdit" v-model="deptForm.level" clearable />
              </el-form-item>
              <el-form-item label="Description" prop="describe">
                <el-input :disabled="isEdit" v-model="deptForm.describe" clearable />
              </el-form-item>
              <el-form-item v-if="isEdit === false">
                <el-button type="primary" @click="saveAndFlush">Save</el-button>
                <el-button @click=" isEdit = !isEdit ">Cancel</el-button>
              </el-form-item>
            </el-form>
          </el-card>
        </el-col>
      </el-row>
    </el-main>
  </el-container>
</template>

<script>

import { getDeptTree, getDeptAll, saveDept, updateDept, removeDeptById } from '@/api/department';
import { mapGetters } from 'vuex';

export default {
  components: {},
  data() {
    return {
      deptForm: {
        id: 0,
        name: '',
        parentId: '',
        level: '',
        describe: ''
      },
      loading: false,
      isEdit: true, // Can I edit?
      treeData: [],
      listData: [],
      defaultProps: {
        children: 'children',
        label: 'name'
      },
      // Verification rules
      rules: {
        name: [{ required: true, message: 'Department name cannot be empty', trigger: 'blur' }],
        parentId: [{ required: true, message: 'The superior department cannot be empty', trigger: 'blur' }],
        level: [{ required: true, message: 'Department level cannot be empty and must be a number', trigger: 'blur' }],
        describe: [{ required: true, message: 'Department description cannot be empty', trigger: 'blur' }]
      }
    };
  },
  computed: {
    ...mapGetters([
      'website'
    ])
  },
  created() {
    this.getDeptTreeData();
    this.getDeptListData();
  },
  methods: {
    getDeptTreeData() {
      const _this = this;
      _this.loading = true;
      getDeptTree().then((result) => {
        if (result.status === 200) {
          _this.treeData = result.data;
          _this.loading = false;
        }
      }).catch((err) => {
        console.log('err :', err);
      });
    },
    getDeptListData() {
      const _this = this;
      _this.loading = true;
      getDeptAll().then((result) => {
        if (result.status === 200) {
          _this.listData = result.data;
          _this.loading = false;
        }
      }).catch((err) => {
        console.log('err :', err);
      });
    },
    handleNodeClick(data) {
      this.deptForm = data;
    },
    handleChange(data) {
      console.log('data :', data);
    },
    saveAndFlush() {
      const _this = this;
      _this.$refs.deptForm.validate(valid => {
        if (valid) {
          _this.deptForm.upTime = new Date();
          if (_this.deptForm.id > 0) {
            updateDept(_this.deptForm).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Modify department success!', type: 'success' });
                _this.getDeptTreeData();
                _this.getDeptListData();
              }
              _this.isEdit = true;
            }).catch((err) => {
              console.log('err :', err);
              _this.$notify.error({ title: 'Error', message: err.message });
            });
          } else {
            _this.deptForm.addTime = new Date();
            saveDept(_this.deptForm).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'New department success!', type: 'success' });
                _this.getDeptTreeData();
                _this.getDeptListData();
              }
              _this.isEdit = true;
            }).catch((err) => {
              console.log('err :', err);
              _this.$notify.error({ title: 'Error', message: err.message });
            });
          }
        }
      });
    },
    addEntity() {
      this.isEdit = false;
      const parentId = this.deptForm.id;
      this.deptForm = { id: 0, name: '', parentId: parentId, level: '', describe: '' };
    },
    deleteEntity() {
      const _this = this;
      if (_this.deptForm.id > 0) {
        _this.$confirm('Make sure to delete [' + _this.deptForm.name + '] Please confirm that this department is not used below. Otherwise it cannot be deleted. Continue?', 'Warning',
          { confirmButtonText: 'Confirm', cancelButtonText: 'Cancel', type: 'warning' })
          .then(() => {
            removeDeptById(_this.deptForm.id).then((result) => {
              if (result.status === 200) {
                _this.$notify({ type: 'success', title: 'Success', message: 'Delete department successfully!' });
                _this.getDeptTreeData();
                _this.getDeptListData();
              }
            }).catch((err) => {
              console.log('err :', err);
              _this.$notify.error({ title: 'Error', message: err.message });
            });
          }).catch(() => {
            _this.$message({ type: 'info', message: 'Undelete' });
          });
      } else {
        _this.$notify.error({ title: 'Error', message: 'Please select the department before you can delete it.' });
      }
    }
  }
};

</script>
<style lang='scss' scoped>
.card-header{
  font-size: 1.5rem;
  font-weight: 600;
}
</style>

<style>
#dept .el-tree-node__expand-icon,
#dept .el-tree-node__label {
  font-size: 1.5rem;
}

#dept .el-tree-node__content {
  height: 2.5rem;
}

#dept .el-alert__title{
  font-size: 1rem;
}

</style>
