const common = {
  state: {
    website: {
      upload: {
        image: '/upload/image',
        avatar: '/upload/avatar'
      },
      title: 'Dashboard',
      logo: '/static/logo.png',
      info: {
        title: 'Dashboard',
        list: [
          'is a development platform based on Spring Cloud and oAuth2.0 based on Vue before and after separation',
          ' is a vue + vuex + vue-router fast background management system, using token interactive authentication. ',
          'Minimumly help companies save time and expenses. ',
          'current version: v1.0'
        ]
      },
      dept: {
        alert: 'Do not delete the department indiscriminately. When you really need to delete the department, (1) Please make sure there are no sub-departments under this department. (2) Please make sure there are no users under this department. Only if the above two conditions are met, the department can be deleted successfully!'
      },
      folder: {
        alert: 'Do not delete the folders indiscriminately. When you really need to delete the folder, (1) Please make sure there are no sub-departments under this department. (2) Please make sure there are no users under this department. Only if the above two conditions are met, the department can be deleted successfully!'
      },
      role: {
        alert: 'Do not delete the role indiscriminately. When you really need to delete the role, (1). Make sure there are no users under this role. (2) Please make sure that the role has no assigned permissions. Only if the above two conditions are met, the role can be deleted successfully!'
      }
    }
  },
  actions: {},
  mutations: {

  }
};
export default common;
