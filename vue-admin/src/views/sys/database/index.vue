<template>

  <el-container v-has="'folder:view'" id="folder">
    <el-header height ="35px">
      <div v-title>LN Dababases</div>

      <div class="filter-container">
        <el-button v-has="'folder:new'" type="success" plain size="mini" @click="addEntity">New LN Database</el-button>
        <el-input v-model="page.search" size="mini" placeholder="Search" prefix-icon="el-icon-search" style="width: 250px; margin-left: 10px;" class="filter-item" @keyup.enter.native="handleFilter()"/>
      </div>

      <el-dialog :visible.sync="dialog.visible" :title="dialog.title" :close-on-click-modal="false" :center="true" top="5vh" width="700px">
        <el-form id="Database" ref="entity" :model="entity" :rules="rules" :inline="false" label-position="right" size="mini" >
          <el-row>
            <el-col :span="16">
              <el-form-item label="Title" prop="title">
                <el-input v-model="entity.title" clearable />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="16">
              <el-form-item label="Server Path" prop="path">
                <el-input v-model="entity.path" clearable />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="16">
              <el-form-item label="Description" prop="describe">
                <el-input v-model="entity.describe" clearable />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="16">
              <el-form-item label="Custodian" prop="owner">
                <el-input v-model="entity.owner" clearable />
              </el-form-item>
            </el-col>
          </el-row>
          <el-row>
            <el-col :span="16">
              <el-form-item label="Substitute" prop="ownersubs">
                <el-input v-model="entity.ownersubs" clearable />
              </el-form-item>
            </el-col>
          </el-row>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button size="mini" type="primary" @click="saveAndFlush">Save</el-button>
          <el-button size="mini" @click="dialog.visible = false">Cancel</el-button>
        </span>
      </el-dialog>

    </el-header>
    <el-main>
      <el-table v-loading="loading" :data="tableData" :default-sort = "{prop: 'did', order: 'descending'}" :row-class-name="tableRowClassName" size="mini" border tooltip-effect="light" element-loading-text="Loading..." style="width: 100%">
        <el-table-column show-overflow-tooltip sortable fixed prop="title" label="Title"/>
        <el-table-column show-overflow-tooltip sortable fixed prop="path" label="Server Path"/>
        <el-table-column show-overflow-tooltip sortable fixed prop="describe" label="Description"/>
        <el-table-column show-overflow-tooltip sortable fixed prop="owner" label="Custodian"/>
        <el-table-column show-overflow-tooltip sortable fixed prop="ownersubs" label="Substitute"/>
        <el-table-column fixed="right" label="Actions" width="100">
          <template slot-scope="scope">
            <el-button v-has="'folder:update'" type="primary" icon="el-icon-edit" circle size="mini" @click="updateEntity(scope.row)"/>
            <el-button v-has="'folder:delete'" type="danger" icon="el-icon-delete" circle size="mini" @click="deleteEntity(scope.row)"/>
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
import { scrollTo } from '@/utils/scroll-to'
import { getDatabasePage, saveDatabase, updateDatabase, removeDatabaseById } from '@/api/database'
import { mapGetters } from 'vuex'

export default {
  components: {},
  data() {
    return {
      page: {
        page: 1,
        size: 16,
        search: null,
        total: 0
      },
      entity: {
        did: 0,
        title: '',
        path: '',
        describe: '',
        owner: '',
        ownersubs: ''
      },
      dialog: {
        visible: false,
        title: ''
      },
      rules: {
        title: [{ required: true, message: 'Title cannot be empty', trigger: 'blur' }],
        path: [{ required: true, message: 'Server Path cannot be empty', trigger: 'blur' }],
        describe: [{ required: true, message: 'Description cannot be empty', trigger: 'blur' }],
        owner: [{ required: true, message: 'Custodian cannot be empty', trigger: 'blur' }],
        ownersubs: [{ required: true, message: 'Substitute cannot be empty', trigger: 'blur' }]
      },
      tableData: [],
      loading: false
    }
  },
  computed: {
    ...mapGetters([
      'website',
      'user'
    ])
  },
  created() {
    this.getTableData()
  },
  mounted() {},
  methods: {
    tableRowClassName({ row, rowIndex }) {
      if (row.did % 2 !== 0) {
        return 'warning-row'
      } else {
        return 'success-row'
      }
    },
    getTableData() {
      const _this = this
      _this.loading = true
      getDatabasePage(_this.page).then((result) => {
        if (result.status === 200) {
          console.log(result.data.content)
          _this.tableData = result.data.content
          _this.page.total = result.data.totalElements
          _this.loading = false
        }
      }).catch((err) => {
        console.log('err :', err)
      })
    },
    handleFilter() {
      this.getTableData()
    },
    handleCurrentChange(index) {
      this.page.page = index
      scrollTo(0, 800)
      this.getTableData()
    },
    handleSizeChange(size) {
      this.page.size = size
      scrollTo(0, 800)
      this.getTableData()
    },
    emptyEntity() {
      this.entity.did = 0
      this.entity.title = ''
      this.entity.path = ''
      this.entity.describe = ''
      this.entity.owner = ''
      this.entity.ownersubs = ''
    },
    addEntity() {
      this.emptyEntity()
      this.dialog.title = 'New Record'
      this.dialog.visible = true
      this.$nextTick(() => {
        this.$refs.entity.clearValidate()
      })
    },
    updateEntity(data) {
      this.emptyEntity()
      this.entity.did = data.did
      this.entity.title = data.title
      this.entity.path = data.path
      this.entity.describe = data.describe
      this.entity.owner = data.owner
      this.entity.ownersubs = data.ownersubs
      this.entity.createTime = data.createTime
      this.dialog.title = 'Modify LN Database Record'
      this.dialog.visible = true
    },
    deleteEntity(data) {
      const _this = this
      if (data.did > 0) {
        _this.$confirm('Are you sure you want to delete this record?', 'Warning',
          { confirmButtonText: 'Confirm', cancelButtonText: 'Cancel', type: 'warning' })
          .then(() => {
            removeDatabaseById(data.did).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Successfully deleted!', type: 'success' })
                _this.getTableData()
              }
            }).catch((err) => {
              console.log('err :', err)
              _this.$notify.error({ title: 'Error', message: err.message })
            })
          }).catch(() => {
            _this.$message({ type: 'info', message: 'Cancelled' })
          })
      }
    },
    saveAndFlush() {
      const _this = this
      _this.$refs.entity.validate(valid => {
        if (valid) {
          if (_this.entity.did > 0) {
            updateDatabase(_this.entity).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Modify the Pass successfully!', type: 'success' })
                _this.getTableData()
                _this.dialog.visible = false
              }
            }).catch((err) => {
              console.log('err :', err)
            })
          } else {
            saveDatabase(_this.entity).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'New Pass succeeded!', type: 'success' })
                _this.getTableData()
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
<style lang='scss' scope>
 .el-table .warning-row {
    background: oldlace;
  }

  .el-table .success-row {
    background: #ffffff;
  }
</style>
