const getters = {
  sidebar: state => state.app.sidebar,
  device: state => state.app.device,
  token: state => state.user.token,
  employeeId: state => state.user.employeeId,
  mail: state => state.user.mail,
  account: state => state.user.account,
  uid: state => state.user.uid,
  roles: state => state.user.roles,
  user: state => state.user.user,
  // User menu obtained from the background, not parsed
  menus: state => state.user.menus,
  // User button permissions obtained from the background
  buttons: state => state.user.buttons,

  // General information
  website: state => state.common.website,

  // permission.js
  // Menu routing, displayed on the page
  menu_routers: state => state.permission.routers,
  // Dynamic menu routing for the current user
  dynamicRouters: state => state.permission.dynamicRouters
};
export default getters;
