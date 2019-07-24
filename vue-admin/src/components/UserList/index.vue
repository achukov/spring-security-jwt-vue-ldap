<template>
  <div>
    <el-container v-has="'role:view'">
      <el-input
        v-model="entity.visitors"
        :autosize="{ minRows: 3, maxRows: 5}"
        type="textarea"
        placeholder="Please input"
        cleareble/>
    </el-container>
  </div>
</template>

<script>

import { mapGetters } from 'vuex'

export default {
  name: 'UserList',
  props: {
    avatar: {
      type: String,
      default: ''
    }
  },
  data() {
    return {
    }
  },
  computed: {
    ...mapGetters([
      'website'
    ]),
    getAvatarAction() {
      // Set file upload URL
      return process.env.BASE_API + this.website.upload.avatar
    }
  },
  created() {
    this.imageUrl = this.avatar
  },
  methods: {
    handleAvatarSuccess(res, file) {
      if (res.status === 200) {
        this.imageUrl = res.data.url
        this.$emit('getAvatar', this.imageUrl)
      } else {
        this.$message.error(res.message)
      }
    },
    beforeAvatarUpload(file) {
      const suffix = file.name.substring(file.name.lastIndexOf('.') + 1)
      // Determine if the format of the image is correct
      const isJPEG = suffix === 'jpeg'
      const isPNG = suffix === 'png'
      const isBMP = suffix === 'bmp'
      const isJPG = suffix === 'jpg'
      const isGIF = suffix === 'gif'
      const isLt2M = file.size / 1024 / 1024 < 2
      if (!isJPEG && !isPNG && !isBMP && !isJPG && !isGIF) {
        this.$message.error('The avatar can only be the image format of the [ jpeg , png , bmp , jpg , gif ] suffix!')
      }
      if (!isLt2M) {
        this.$message.error('Avatar image size cannot exceed 2MB!')
      }
      return isJPEG || isPNG || isBMP || isJPG || isGIF && isLt2M
    }
  }
}

</script>
<style lang='scss' scoped>
</style>
