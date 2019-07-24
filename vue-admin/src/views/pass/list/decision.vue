<template>
  <el-container v-has="'pass:approve'">
    <el-form id="Pass" ref="entity" :model="entity" :rules="rules" :inline="false" label-position="top" size="mini" >
      <div align="center" style="margin-bottom: 10px;">
        <el-button :disabled="entity.state !== 1" size="small" type="success" @click="saveAndFlush(2)">Утвердить</el-button>
        <el-button :disabled="entity.state !== 1" size="small" type="danger" @click="addComment">Отклонить</el-button>
      </div>
      <div style="margin-bottom: 10px;">
        <el-collapse v-model="activeName" accordion>
          <el-collapse-item title="info" name="1">
            <div> Номер: {{ entity.psid }} </div>
            <div> Автор: {{ entity.createdBy }} </div>
            <!-- <div> Тип: {{ entity.type }} </div> -->
          </el-collapse-item>
          <el-collapse-item title="status" name="2">
            <el-steps :active="entity.state" align-center process-status="success" finish-status="finish">
              <el-step title="Новый" description="Заполнение документа"/>
              <el-step title="На Согласовании" description="Утверждается отделом безопасности"/>
              <el-step title="Утвержден" description="Заявка согласована"/>
            </el-steps>
          </el-collapse-item>
        </el-collapse>
      </div>
      <el-row :gutter="20">
        <el-col :span="16" :offset="6">
          <div style="margin-bottom: 10px; margin-top: 10px; text-align: left">
            <el-radio-group :disabled="true" v-model="entity.type" size="small">
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
              <el-input :disabled="isEdit" v-model="entity.visitors" :autosize="{ minRows: 3, maxRows: 5}" type="textarea" placeholder="Please input" cleareble/>
            </el-form-item>
          </el-col>
        </el-row>
      </fieldset>
      <fieldset style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
        <el-row :gutter="20">
          <el-col :span="12">
            <el-form-item :label-width="formLabelWidth" label="Контактное лицо" prop="contactperson">
              <el-input :disabled="isEdit" v-model="entity.contactperson" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item :label-width="formLabelWidth" label="Телефон для связи" prop="phonenumber">
              <el-input :disabled="isEdit" v-model="entity.phonenumber" />
            </el-form-item>
          </el-col>
        </el-row>
      </fieldset>
      <fieldset v-if="entity.type =='Пропуск на въезд'" style="margin-bottom: 5px; border-radius: 5px; padding: 20px; border: 1px solid #DCDFE6;">
        <el-row :gutter="20">
          <el-col :span="12">
            <template>
              <el-form-item :label-width="formLabelWidth" label="Номер автомобиля" prop="carnumber">
                <el-input :disabled="isEdit" v-model="entity.carnumber" />
              </el-form-item>
            </template>
          </el-col>
          <el-col :span="12">
            <template>
              <el-form-item :label-width="formLabelWidth" label="Марка автомобиля" prop="cartype">
                <el-input :disabled="isEdit" v-model="entity.cartype" />
              </el-form-item>
            </template>
          </el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12">
            <template>
              <el-form-item :label-width="formLabelWidth" label="Вид парковки" prop="parktype">
                <el-input :disabled="isEdit" v-model="entity.parktype" />
              </el-form-item>
            </template>
          </el-col>
          <el-col :span="12">
            <template>
              <el-form-item :label-width="formLabelWidth" label="Уровень парковки" prop="parklevel">
                <el-input :disabled="isEdit" v-model="entity.parklevel"/>
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
    <el-dialog :visible.sync="dialogVisible" :close-on-click-modal="false" :center="true" width="40%" title="Комментарии:">
      <el-input v-model="comments" :autosize="{ minRows: 3, maxRows: 5}" type="textarea"/>
      <span slot="footer" class="dialog-footer">
        <el-button size="mini" type="primary" @click="saveAndFlush(0)">Сохранить</el-button>
        <el-button size="mini" @click="cancleCommit">Отменить</el-button>
      </span>
    </el-dialog>
  </el-container>
</template>

<script>

import { updatePass, getPassById } from '@/api/pass'

import { mapGetters } from 'vuex'

export default {
  components: {},
  data() {
    return {
      dialogVisible: false,
      activeName: '1',
      isEdit: true,
      formLabelWidth: '130px',
      comments: '',
      entity: {
        psid: '',
        createdBy: '',
        type: '',
        startdate: '',
        enddate: '',
        visitors: '',
        contactperson: '',
        phonenumber: '',
        carnumber: '',
        cartype: '',
        parktype: '',
        parklevel: '',
        buildingaccess: '',
        state: 0
      },
      loading: false,
      typeoptions: ['Пропуск на посещение', 'Пропуск на въезд'],
      // Verification rule
      rules: {
        // state: [{ required: true, message: 'Role status cannot be empty', trigger: 'blur' }],
        describe: [{ required: true, message: 'Role description cannot be empty', trigger: 'blur' }]
      }
    }
  },
  computed: {
    ...mapGetters([
      'website',
      'user'
    ])
  },
  created() {
    const id = this.$route.params && this.$route.params.id
    this.fetchData(id)
  },
  methods: {
    addComment() {
      this.dialogVisible = true
    },
    cancleCommit() {
      this.dialogVisible = false
      this.comments = ''
    },
    fetchData(id) {
      const _this = this
      _this.loading = true
      getPassById(id).then((result) => {
        if (result.status === 200) {
          _this.entity.psid = result.data.psid
          _this.entity.createdBy = result.data.createdBy
          _this.entity.type = result.data.type
          _this.entity.startdate = result.data.startdate
          _this.entity.enddate = result.data.enddate
          _this.entity.visitors = result.data.visitors
          _this.entity.contactperson = result.data.contactperson
          _this.entity.phonenumber = result.data.phonenumber
          _this.entity.carnumber = result.data.carnumber
          _this.entity.cartype = result.data.cartype
          _this.entity.parktype = result.data.parktype
          _this.entity.parklevel = result.data.parklevel
          _this.entity.buildingaccess = result.data.buildingaccess
          _this.entity.state = result.data.state
          // _this.entity.comments = result.data.comments
          _this.entity.historyLog = result.data.historyLog
          _this.entity.createTime = result.data.createTime
          _this.loading = false
        }
      }).catch((err) => {
        console.log('err :', err)
      })
    },
    saveAndFlush(id) {
      const _this = this
      _this.$refs.entity.validate(valid => {
        if (valid) {
          _this.entity.state = id
          if (id === 2) {
            _this.entity.historyLog = _this.entity.historyLog + ';Approved by: ' + this.$store.state.user.account + ' at: ' + new Date().toLocaleString()
          } else if (id === 0) {
            _this.entity.historyLog = _this.entity.historyLog + ';Rejected by: ' + this.$store.state.user.account + ' at: ' + new Date().toLocaleString() + ' Comments: ' + _this.comments
          } else {
            _this.entity.historyLog = _this.entity.historyLog + 'Updated by: ' + this.$store.state.user.account + ' at: ' + new Date().toLocaleString()
          }
          if (_this.entity.psid > 0) {
            // Modify information
            updatePass(_this.entity).then((result) => {
              if (result.status === 200) {
                _this.$notify({ title: 'Success', message: 'Modify the Pass successfully!', type: 'success' })
                _this.$router.push({ path: '/' })
              }
            }).catch((err) => {
              console.log('err :', err)
            })
          }
        }
      })
    }
  }
}

</script>

<style lang="scss">
.el-form {
width: 700px;
}
// .init-container {
//     line-height: 24px;
//     font-weight: 700;
//     font-size: 14px;
//     color: #606266;
//     margin-bottom: 17px;
// }
.el-form-item__label {
  padding: 0 20px 0 0;
}
.el-alert__title {
  font-size: 1rem;
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
