<template>
  <el-container v-has="'role:view'">
    <el-header>
      <div v-title>Role management</div>

      <el-row :gutter="20">
        <el-col :span="4">
          <el-button v-has="'role:new'" type="primary" @click="addRoleEntity">New role</el-button>
        </el-col>
        <el-col :span="20">
          <el-alert :title="website.role.alert" type="info"/>
        </el-col>
      </el-row>

      <el-dialog :visible.sync="dialog.visible" :title="dialog.title" width="550px">
        <el-form id="role" ref="entity" :model="entity" :rules="rules" label-width="80px">
          <template v-if="entity.rid > 0">
            <el-form-item label="Role ID">
              <el-input v-model="entity.rid" disabled/>
            </el-form-item>
          </template>
          <el-form-item label="Name" prop="name">
            <el-input v-model="entity.name" clearable/>
          </el-form-item>
          <el-form-item label="Description" prop="describe">
            <el-input v-model="entity.describe" clearable/>
          </el-form-item>
          <el-form-item label="State" prop="state">
            <el-select v-model="entity.state" placeholder="please choose">
              <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value"/>
            </el-select>
          </el-form-item>
        </el-form>

        <span slot="footer" class="dialog-footer">
          <el-button @click="dialog.visible = false">Cancel</el-button>
          <el-button type="primary" @click="saveAndFlush">Save</el-button>
        </span>
      </el-dialog>

      <!-- Role permission list -->
      <el-dialog :visible.sync="authority.visible" :title="authority.title" width="600px">
        <el-tree
          ref="tree"
          :data="authority.list"
          :props="authority.props"
          :default-checked-keys="authority.checkedKeys"
          :check-strictly="true"
          show-checkbox
          highlight-current
          node-key="pid"
          @check="clickDeal" />
        <span slot="footer" class="dialog-footer">
          <el-button @click="authority.visible = false">Cancel</el-button>
          <el-button type="primary" @click="updatePermission">Save</el-button>
        </span>
      </el-dialog>

    </el-header>
    <el-main>
      <el-table v-loading="loading" :data="tableData" border style="width: 100%">
        <el-table-column fixed prop="rid" label="Role Id" width="100"/>
        <el-table-column prop="name" label="Name"/>
        <el-table-column prop="describe" label="Description"/>
        <el-table-column label="Status">
          <template slot-scope="scope">
            {{ scope.row.state | showState }}
          </template>
        </el-table-column>
        <el-table-column label="Created">
          <template slot-scope="scope">
            {{ scope.row.createTime | formatTime }}
          </template>
        </el-table-column>
        <el-table-column label="Modified">
          <template slot-scope="scope">
            {{ scope.row.upTime | formatTime }}
          </template>
        </el-table-column>
        <el-table-column fixed="right" label="Actions" width="250">
          <template slot-scope="scope">
            <el-button type="info" size="small" @click="rolePermission(scope.row)">Change</el-button>
            <el-button v-has="'role:update'" type="primary" size="small" @click="updateRoleEntity(scope.row)">Edit</el-button>
            <el-button v-has="'role:delete'" type="danger" size="small" @click="deleteRoleEntity(scope.row)">Delete</el-button>
          </template>
        </el-table-column>
      </el-table>
    </el-main>
    <el-footer>
      <el-pagination
        :page-size="page.size"
        :total="page.total"
        layout="prev, pager, next, jumper"
        @current-change="currentChange"/>
    </el-footer>
  </el-container>
</template>

<script>

import { getRolePage, getRoleById, saveRole, updateRole, removeRoleById, updateRolePermission } from '@/api/role';

import { mapGetters } from 'vuex';

export default {
  components: {},
  data() {
    return {
      page: {
        page: 1,
        size: 10,
        search: null,
        total: 0
      },
      entity: {
        rid: 0,
        describe: '',
        name: '',
        state: ''
      },
      dialog: {
        visible: false,
        title: ''
      },
      tableData: [],
      loading: false,
      authority: {
        list: [],
        props: {
          children: 'children',
          label: 'title'
        },
        checkedKeys: [],
        rid: 0,
        visible: false,
        title: ''
      },
      options: [{ value: 0, label: 'Deleted' }, { value: 1, label: 'Active' }, { value: 2, label: 'Hidden' }],
      // Verification rule
      rules: {
        state: [{ required: true, message: 'Role status cannot be empty', trigger: 'blur' }],
        describe: [{ required: true, message: 'Role description cannot be empty', trigger: 'blur' }],
        name: [{ required: true, message: 'Role name cannot be empty', trigger: 'blur' },
          {
            validator: function(rule, value, callback) {
              const regex = /[R][O][L][E][_][A-Z]{3,}/;
              if (!regex.test(value)) {
                callback(new Error('The role name must be all uppercase English and start with "ROLE_"'));
              } else {
                callback();
              }
            }, trigger: 'blur'
          }
        ]
      }
    };
  },
  computed: {
    ...mapGetters([
      'website'
    ])
  },
  created() {
    this.getTableData();
  },
  methods: {
    getTableData() {
      // Get the list of roles
      const _this = this;
      _this.loading = true;
      getRolePage(_this.page).then((result) => {
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
      this.entity.rid = 0;
      this.entity.describe = '';
      this.entity.name = '';
      this.entity.state = 1;
    },
    addRoleEntity() {
      this.emptyEntity();
      this.dialog.title = 'New role';
      this.dialog.visible = true;
    },
    updateRoleEntity(data) {
      this.emptyEntity();
      this.entity.rid = data.rid;
      this.entity.describe = data.describe;
      this.entity.name = data.name;
      this.entity.state = data.state;
      this.entity.createTime = data.createTime;
      this.dialog.title = 'Modify role';
      this.dialog.visible = true;
    },
    deleteRoleEntity(data) {
      // Delete a role. If the current role is associated with another user or permission, it cannot be deleted.
      const _this = this;
      if (data.rid > 0) {
        _this.$confirm('Make sure to delete [' + data.describe + '] ? Please confirm that there are no users under this role. Otherwise it cannot be deleted. Continue?', 'Warning',
          { confirmButtonText: 'Confirm', cancelButtonText: 'Cancel', type: 'warning' })
          .then(() => {
            removeRoleById(data.rid).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'successfully deleted!', type: 'success' });
                _this.getTableData();
              }
            }).catch((err) => {
              console.log('err :', err);
              _this.$notify.error({ title: 'Error', message: err.message });
            });
          }).catch(() => {
            _this.$message({ type: 'info', message: 'Undelete' });
          });
      } else {
        _this.$notify.error({ title: 'Error', message: 'Please select the role before you can delete it.' });
      }
    },
    saveAndFlush() {
      const _this = this;
      _this.$refs.entity.validate(valid => {
        if (valid) {
          if (_this.entity.rid > 0) {
            // Modify role information
            updateRole(_this.entity).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Modify the role successfully!', type: 'success' });
                _this.getTableData();
                _this.dialog.visible = false;
              }
            }).catch((err) => {
              console.log('err :', err);
            });
          } else {
            // New role
            saveRole(_this.entity).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'New role succeeded!', type: 'success' });
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
    clickDeal(currentObj, treeStatus) {
      const selected = treeStatus.checkedKeys.indexOf(currentObj.pid); // -1 is not selected
      if (selected === -1) {
        this.changeParentAndChild(currentObj);
      } else {
        this.selectedParent(currentObj);
        this.uniteChildSame(currentObj, true);
      }
    },
    uniteChildSame(treeList, isSelected) {
      this.$refs.tree.setChecked(treeList.pid, isSelected);
      if (treeList.children !== null) {
        for (let i = 0; i < treeList.children.length; i++) {
          this.uniteChildSame(treeList.children[i], isSelected);
        }
      }
    },
    changeParentAndChild(currentObj) {
      const currentNode = this.$refs.tree.getNode(currentObj);
      if (currentNode.childNodes.length > 0) {
        this.uniteChildSame(currentObj, false);
      }
      if (currentNode.parent.key) {
        this.changeParentStatus(currentNode.parent);
      }
    },
    selectedParent(currentObj) {
      const currentNode = this.$refs.tree.getNode(currentObj);
      if (currentNode.parent.key) {
        const childCheckedStatus = currentNode.parent.childNodes.every((item, index) => {
          return item.checked === true;
        });
        if (childCheckedStatus) {
          this.$refs.tree.setChecked(currentNode.parent, true);
        } else {
          currentNode.parent.indeterminate = true;
        }
        this.selectedParent(currentNode.parent);
      }
    },
    changeParentStatus(parentNodes) {
      const childNodes = parentNodes.childNodes;
      const childCheckedStatus = childNodes.every((item, index) => {
        return item.checked === false && item.indeterminate === false;
      });
      const childCheckedAllChecked = childNodes.every((item, index) => {
        return item.checked === true;
      });
      if (childCheckedStatus) {
        parentNodes.checked = false;
        parentNodes.indeterminate = false;
      }
      if (childCheckedAllChecked) {
        parentNodes.checked = true;
        parentNodes.indeterminate = false;
      }
      if (!childCheckedStatus && !childCheckedAllChecked) {
        parentNodes.checked = false;
        parentNodes.indeterminate = true;
      }
      if (parentNodes.parent.key) {
        const parentNode = parentNodes.parent;
        this.changeParentStatus(parentNode);
      }
    },
    rolePermission(data) {
      // View the permissions that the current role has
      const _this = this;
      if (data.rid > 0) {
        getRoleById(data.rid).then((result) => {
          // console.log('checked :', result.data.current)
          if (result.status === 200) {
            _this.authority.list = result.data.all;
            _this.authority.checkedKeys = result.data.current;
            _this.authority.rid = data.rid;
            _this.authority.title = data.describe;
            _this.authority.visible = true;
          }
        }).catch((err) => {
          console.log('err :', err);
          _this.$notify.error({ title: 'Error', message: err.message });
        });
      }
    },
    updatePermission() {
      // Modify permissions for a role
      const _this = this;
      const list = _this.$refs.tree.getCheckedKeys();
      const father = _this.$refs.tree.getHalfCheckedNodes();
      // console.log(list)
      // console.log(father)
      if (father != null && father.length > 0) {
        father.forEach(f => {
          list.push(f.pid);
        });
      }
      // console.log('updated list :', list)
      updateRolePermission({ rid: _this.authority.rid, pids: list }).then((result) => {
        if (result.status === 200) {
          _this.$notify({ title: 'Success', message: 'Modify role permissions successfully!', type: 'success' });
          _this.getTableData();
          _this.authority.visible = false;
        }
      }).catch((err) => {
        console.log('err :', err);
        _this.$notify.error({ title: 'Error', message: err.message });
      });
    }
  }
};

</script>
<style lang='scss' scoped>
</style>

<style>

  #role .el-alert__title {
    font-size: 1rem;
  }
</style>

