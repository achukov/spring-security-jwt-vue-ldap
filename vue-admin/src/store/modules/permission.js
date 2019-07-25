// store/permission.js
import { asyncRouterMap, constantRouterMap } from '@/router';

/**
 * @param  {Array} userRouter User permission json returned in the background.
 * @param  {Array} allRouter  a collection of all dynamic routes configured at the front end.
 * @return {Array} realRoutes a Filtered route.
 */

export function recursionRouter(userRouter = [], allRouter = []) {
  var realRoutes = [];
  allRouter.forEach((v, i) => {
    // 404 loop
    if (v.path === '*') {
      realRoutes.push(v);
    }
    userRouter.forEach((item, index) => {
      if (item.resources === v.meta.resources) {
        if (item.children && item.children.length > 0) {
          v.children = recursionRouter(item.children, v.children);
        }
        v.meta.title = item.title;
        v.meta.icon = item.icon;
        realRoutes.push(v);
      }
    });
  });
  return realRoutes;
}

/**
* @param {Array} routes User filtered route
* Recursively set the first children.path to the default route for all routes with subroutes
*/

export function setDefaultRoute(routes) {
  routes.forEach((v, i) => {
    if (v.children && v.children.length > 0) {
      v.redirect = { name: v.children[0].name };
      setDefaultRoute(v.children);
    }
  });
}

const permission = {
  state: {
    routers: constantRouterMap, // This is the default permission list, such as 404 500 and other routes.
    dynamicRouters: [] // This is a list of rights obtained through the background
  },
  mutations: {
    SET_ROUTERS: (state, routers) => {
      state.dynamicRouters = routers;
      state.routers = constantRouterMap.concat(routers);
      // console.log(JSON.stringify(state.routers))
    }
  },
  actions: {
    GenerateRoutes({ commit }, data) {
      return new Promise(resolve => {
        commit('SET_ROUTERS', recursionRouter(data, asyncRouterMap));
        resolve();
      });
    }
  }
};

export default permission;
