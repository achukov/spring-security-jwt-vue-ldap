<template>
  <el-container v-has="'folder:view'" id="folder">
    <el-main v-loading="loading">
      <div class="components-container">
        <split-pane :min-percent="20" :default-percent="50" split="horizontal" @resize="resize">
          <template slot="paneR">
            <div class="bottom-container">
              <el-input v-model="page.search" size="mini" placeholder="Search" prefix-icon="el-icon-search" style="width: 250px; margin-left: 10px;" class="filter-item" @keyup.enter.native="handleFilter()"/>
              <el-table
                v-loading="loading"
                :data="tableData"
                :filter-method="filterNode"
                highlight-current-row
                size="mini"
                border
                fit
                tooltip-effect="light"
                element-loading-text="Loading..."
                style="width: 100%; margin-bottom: 10px;"
                max-height="320"
                @cell-click="handleNodeClick">
                <el-table-column show-overflow-tooltip label="Owner" prop="owner"/>
                <el-table-column show-overflow-tooltip label="Sub Owner" prop="ownersubs"/>
                <el-table-column show-overflow-tooltip label="Path" prop="fullpath"/>
              </el-table>
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
            </div>
          </template>
          <template slot="paneL">
            <split-pane :min-percent="20" :default-percent="30" split="vertical" @resize="resize">
              <template slot="paneL">
                <div class="left-container">
                  <div class="tree">
                    <el-scrollbar :native="false" >
                      <el-input
                        v-model="filterText"
                        placeholder="Search"
                        prefix-icon="el-icon-search"
                        clearable
                        size="small"
                        class="input-with-select"
                        @keyup.enter.native="filterChange" >
                        <!-- <el-select slot="prepend" v-model="select" placeholder="11">
                          <el-option label="by Owner" value="1"/>
                          <el-option label="by Folder" value="2"/>
                        </el-select> -->
                      </el-input>
                      <el-tree
                        ref="tree"
                        :data="treeData"
                        :props="props"
                        :default-expand-all="false"
                        :expand-on-click-node="true"
                        :filter-node-method="filterNode"
                        :indent="22"
                        icon-class="el-icon-plus"
                        highlight-current
                        node-key="id"
                        @node-click="handleNodeClick">
                        <!-- @node-click="handleChange"> -->
                        <div slot-scope="{ node, data }">
                          <div>
                            <svg-icon v-if="data.inherit=='0'" icon-class="folder" color="red" />
                            <svg-icon v-else icon-class="folder" color="green" />
                            <span style="display:inline"> {{ node.label }}</span>
                          </div>
                        </div>
                      </el-tree>
                    </el-scrollbar>
                  </div>
                </div>
              </template>
              <template slot="paneR">
                <div class="right-container">
                  <el-card shadow="hover" class="box-card">
                    <div slot="header" class="clearfix">
                      <el-button-group style="float: right;">
                        <el-button v-has="'folder:new'" type="primary" size="mini" icon="el-icon-share" @click="addEntity">New</el-button>
                        <el-button v-has="'folder:update'" type="primary" size="mini" icon="el-icon-edit" @click=" isEdit = !isEdit ">Edit</el-button>
                        <el-button v-has="'folder:delete'" type="danger" size="mini" icon="el-icon-delete" @click="deleteEntity">Delete</el-button>
                      </el-button-group>
                    </div>
                    <el-form ref="folderForm" :rules="rules" :model="folderForm" size="mini" label-width="80px">
                      <!-- <el-form-item label="Id">
                        <el-input v-model="folderForm.id" :disabled="true"/>
                      </el-form-item> -->
                      <el-form-item label="Title" prop="title">
                        <el-input :disabled="isEdit" v-model="folderForm.title" clearable />
                      </el-form-item>
                      <!-- <el-form-item label="Parent" prop="parentId" >
                        <el-select v-model="folderForm.parentId" :disabled="isEdit" placeholder="Choose a parent folder" >
                          <el-option v-for="item in listData" :key="item.id" :label="item.title" :value="item.id"/>
                        </el-select>
                      </el-form-item> -->
                      <el-form-item label="FullPath" prop="fullpath">
                        <el-cascader :disabled="isEdit" :options="treeData" :props="casprops" v-model="selectedOptions" style="width: 100%" @change="handleChange">
                          <!-- <template slot-scope="{ node, data }">
                            <span>{{ data.title }}</span>
                            <span v-if="!node.isLeaf"> ({{ data.children.length }}) </span>
                          </template> -->
                        </el-cascader>
                      </el-form-item>
                      <!-- <el-form-item label="Fullpath2" prop="fullpath2">
                        <el-input :disabled="isEdit" v-model="selectedOptions" clearable />
                      </el-form-item> -->
                      <el-form-item label="Owner" prop="owner">
                        <el-input :disabled="isEdit" v-model="folderForm.owner" clearable />
                      </el-form-item>
                      <el-form-item label="Substitue" prop="ownersubs">
                        <el-input :disabled="isEdit" v-model="folderForm.ownersubs" clearable />
                      </el-form-item>
                      <el-form-item label="Level" prop="level">
                        <el-input :disabled="isEdit" v-model="folderForm.level" clearable />
                      </el-form-item>
                      <el-form-item label="inherit" prop="inherit">
                        <el-switch :disabled="isEdit" v-model="folderForm.inherit" :active-value="1" :inactive-value="0" />
                      </el-form-item>
                      <el-form-item v-if="isEdit === false">
                        <el-button type="primary" @click="saveAndFlush">Save</el-button>
                        <el-button @click=" isEdit = !isEdit ">Cancel</el-button>
                      </el-form-item>
                    </el-form>
                  </el-card>
                </div>
              </template>
            </split-pane>
          </template>
        </split-pane>
      </div>
    </el-main>
  </el-container>
</template>

<script>

import splitPane from 'vue-splitpane';

import { getFolderTree, getFolderPage, saveFolder, updateFolder, removeFolderById } from '@/api/folder';
import { mapGetters } from 'vuex';

export default {
  components: { splitPane },
  data() {
    return {
      page: {
        page: 1,
        size: 10,
        search: null,
        total: 0
      },
      folderForm: {
        id: 0,
        title: '',
        parentId: '',
        owner: '',
        ownersubs: '',
        level: '',
        inherit: '',
        fullpath: ''
      },
      selectedOptions: [],
      filterText: '',
      select: '',
      loading: false,
      isEdit: true,
      treeData: [],
      tableData: [],
      props: {
        checkStrictly: true,
        value: 'id',
        label: 'title',
        children: 'children'
      },
      casprops: {
        checkStrictly: true,
        value: 'title',
        label: 'title',
        children: 'children'
      },
      // Verification rules
      rules: {
        title: [{ required: true, message: 'Folder title cannot be empty', trigger: 'blur' }],
        parentId: [{ required: true, message: 'The parent folder cannot be empty', trigger: 'blur' }],
        fullpath: [{ required: true, message: 'Fullpath title cannot be empty', trigger: 'blur' }],
        // ownersubs: [{ required: true, message: 'Folder Sub cannot be empty and must be a email', trigger: 'blur', validator: validateEmail }],
        level: [{ required: true, message: 'Folder level cannot be empty and must be a number', trigger: 'blur' }]
        // inherit: [{ required: true, message: 'Folder inherit cannot be empty', trigger: 'blur' }]
      }
    };
  },
  computed: {
    ...mapGetters([
      'website'
    ])
  },
  created() {
    this.getTreeData();
    this.getTableData();
  },
  methods: {
    handleChange(val) {
      // console.log('set fullpath', this.folderForm.fullpath)
      // console.log('set selectedOptions', this.selectedOptions)
      // console.log(val, this.$refs['cascaderAddr'].currentLabels)
    },
    resize() {
    },
    cancelEdit(row) {
      row.owner = row.originalowner;
      row.edit = false;
      this.$message({
        message: 'The Owner has been restored to the original value',
        type: 'warning'
      });
    },
    confirmEdit(row) {
      row.edit = false;
      this.emptyEntity();
      this.folderForm.owner = row.owner;
      this.$message({
        message: 'The Owner has been edited',
        type: 'success'
      });
    },
    handleCurrentChange(index) {
      this.page.page = index;
      this.getTableData();
    },
    handleSizeChange(size) {
      this.page.size = size;
      this.getTableData();
    },
    getTreeData() {
      const _this = this;
      _this.loading = true;
      getFolderTree().then((result) => {
        if (result.status === 200) {
          _this.treeData = result.data;
          _this.loading = false;
        }
      }).catch((err) => {
        console.log('err :', err);
      });
    },
    getTableData() {
      const _this = this;
      _this.loading = true;
      getFolderPage(_this.page).then((result) => {
        if (result.status === 200) {
          /* console.log(result.data.content)*/
          _this.tableData = result.data.content;
          _this.page.total = result.data.totalElements;
          _this.loading = false;
        }
      }).catch((err) => {
        console.log('err :', err);
      });
    },
    handleFilter() {
      this.getTableData();
    },
    handleNodeClick(data) {
      this.folderForm = data;
      if (this.folderForm.fullpath) {
        this.selectedOptions = this.folderForm.fullpath.split('/').map(String);
      } else {
        this.$set(this, 'selectedOptions', []);
      }
    },
    saveAndFlush() {
      const _this = this;
      _this.$refs.folderForm.validate(valid => {
        if (valid) {
          _this.folderForm.upTime = new Date();
          if (_this.folderForm.id > 0) {
            _this.folderForm.fullpath = this.selectedOptions.join('/');
            updateFolder(_this.folderForm).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Modify Folder success!', type: 'success' });
                _this.getTreeData();
                _this.getTableData();
                _this.emptyEntity();
              }
              _this.isEdit = true;
            }).catch((err) => {
              console.log('err :', err);
              _this.$notify.error({ title: 'Error', message: err.message });
            });
          } else {
            _this.folderForm.addTime = new Date();
            saveFolder(_this.folderForm).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'New Folder success!', type: 'success' });
                _this.getTreeData();
                _this.getTableData();
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
    emptyEntity() {
      this.folderForm.id = '';
      this.folderForm.title = '';
      this.folderForm.owner = '';
      this.folderForm.ownersubs = '';
      this.folderForm.level = '';
      this.folderForm.inherit = '';
      this.folderForm.fullpath = '';
      this.selectedOptions = '';
    },
    addEntity() {
      this.isEdit = false;
      const parentId = this.folderForm.id;
      this.folderForm = { id: 0, title: '', parentId: parentId, owner: '', ownersubs: '', level: '', inherit: '', fullpath: '' };
      this.$nextTick(() => {
        this.$refs.entity.clearValidate();
      });
    },
    deleteEntity() {
      const _this = this;
      if (_this.folderForm.id > 0) {
        _this.$confirm('Make sure to delete [' + _this.folderForm.name + '] Please confirm that this Folder is not used below. Otherwise it cannot be deleted. Continue?', 'Warning',
          { confirmButtonText: 'Confirm', cancelButtonText: 'Cancel', type: 'warning' })
          .then(() => {
            removeFolderById(_this.folderForm.id).then((result) => {
              if (result.status === 200) {
                _this.$notify({ type: 'success', title: 'Success', message: 'Delete folder successfully!' });
                _this.getTreeData();
                // _this.getFolderListData()
              }
            }).catch((err) => {
              console.log('err :', err);
              _this.$notify.error({ title: 'Error', message: err.message });
            });
          }).catch(() => {
            _this.$message({ type: 'info', message: 'Undelete' });
          });
      } else {
        _this.$notify.error({ title: 'Error', message: 'Please select the folder before you can delete it.' });
      }
    },
    filterNode(value, data) {
      if (!value) return true;
      return data.ownersubs.toLowerCase().indexOf(value.toLowerCase()) !== -1 || data.owner.toLowerCase().indexOf(value.toLowerCase()) !== -1 || data.title.toLowerCase().indexOf(value.toLowerCase()) !== -1;
    },
    filterChange: function() {
      this.$refs.tree.filter(this.filterText);
      // this.$refs.tableData.filter(this.filterText)
    }
  }
};

</script>
// TODO icons
<style>
.app-container {
    padding: 10px;
}
  .components-container {
    position: relative;
    height: 83vh;
  }
 .tree {
    flex: 1;
    display: flex;
    align-items: stretch;
    justify-content: space-between;
    font-size: 14px;
    padding-right: 4px;
    height: 100%;
    width: 100%;
  }
  .tree .el-input {
  margin-bottom:15px;
  border:none;
  }
  .el-tree>.el-tree-node {
    min-width: 100%;
    display: inline-block;
    border:none;
  }
  ::-webkit-scrollbar {
    width: 15px;
  }
 .el-tree-node__content {
    height: 25px !important;
  }
/* .el-tree-node__expand-icon+span::before {
  display: inline-block;
  vertical-align: bottom;
  margin-bottom: -3px;
  width: 20px;
} */
/* .el-tree-node__content .el-tree-node__expand-icon+span::before {
        content: url(/static/map.png);
  }
.el-tree-node__children .el-tree-node__expand-icon+span::before {
        content: url(/static/folder.png);
} */
 .right-container {
    height: 100%;
    width: 100%;
  }
  .left-container {
    height: 100%;
    width: 100%;
  }
  .bottom-container {
    height: 100%;
    width: 100%;
  }
 .el-form-item__label {
   padding: 0 20px 0 0;
  }
  .el-select .el-input {
    width: 120px;
  }
  .input-with-select .el-input-group__prepend {
    background-color: #fff;
  }
</style>
