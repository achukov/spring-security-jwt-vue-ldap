import Vue from 'vue';
import Router from 'vue-router';

// in development-env not use lazy-loading, because lazy-loading too many pages will cause webpack hot update too slow. so only in production use lazy-loading;
// detail: https://panjiachen.github.io/vue-element-admin-site/#/lazy-loading

Vue.use(Router);

import Layout from '@/views/layout/Layout';

/**
* hidden: true                   if `hidden:true` will not show in the sidebar(default is false)
* alwaysShow: true               if set true, will always show the root menu, whatever its child routes length
*                                if not set alwaysShow, only more than one route under the children
*                                it will becomes nested mode, otherwise not show the root menu
* redirect: noredirect           if `redirect:noredirect` will no redirect in the breadcrumb
* name:'router-name'             the name is used by <keep-alive> (must set!!!)
* meta : {
    title: 'title'               the name show in submenu and breadcrumb (recommend set)
    icon: 'svg-name'             the icon show in the sidebar
    breadcrumb: false            if false, the item will hidden in breadcrumb(default is true)
  }
**/

export const constantRouterMap = [
  { path: '/login', name: 'Login', component: () => import('@/views/login/index'), hidden: true },
  { path: '/', component: Layout, redirect: '/dashboard', name: 'Dashboard', hidden: true,
    children: [
      { path: 'dashboard', component: () => import('@/views/dashboard/index') },
      { path: 'userinfo', name: 'UserInfo', component: () => import('@/views/dashboard/userinfo') }
    ] },
  { path: '/error', component: () => import('@/views/error/404/index'), hidden: true }
];

export default new Router({
  mode: 'history',
  scrollBehavior: () => ({ y: 0 }),
  routes: constantRouterMap
});

// Asynchronously mounted route
// Dynamic routing table that needs to be loaded according to permissions
export const asyncRouterMap = [
  { path: '/pre', component: Layout, name: 'pre', meta: { resources: 'pre', title: 'Permissions' },
    children: [
      { path: 'index', component: () => import('@/views/pre/perm/index'), name: 'perm', meta: { resources: 'perm' }},
      { path: 'user', component: () => import('@/views/pre/user/index'), name: 'user', meta: { resources: 'user' }},
      { path: 'role', component: () => import('@/views/pre/role/index'), name: 'role', meta: { resources: 'role' }},
      { path: 'dept', component: () => import('@/views/pre/dept/index'), name: 'dept', meta: { resources: 'dept' }}
    ]
  },
  { path: '/pass', component: Layout, name: 'pass', redirect: '/pass/index', meta: { resources: 'pass', title: 'PassApproval' },
    children: [
      { path: 'index', component: () => import('@/views/pass/list/index'), name: 'pass_list', meta: { resources: 'pass_list' }},
      { path: 'index/:id', component: () => import('@/views/pass/list/index'), hidden: true, meta: { resources: 'pass_list' }},
      { path: 'my', component: () => import('@/views/pass/my/index'), name: 'pass_my', meta: { resources: 'pass_my' }}
    ]
  },
  { path: '/ldp', component: Layout, name: 'ldp', meta: { resources: 'ldp', title: 'ldp' },
    children: [
      { path: 'index', component: () => import('@/views/ldp/list/index'), name: 'ldp_my', meta: { resources: 'ldp_my' }},
      { path: 'tasks', component: () => import('@/views/ldp/myprocess/index'), name: 'my_process', meta: { resources: 'my_process' }}
    ]
  },
  { path: '/sys', component: Layout, name: 'sys', meta: { resources: 'sys', title: 'System settings' },
    children: [
      { path: 'folder', component: () => import('@/views/sys/folder/index'), name: 'folder', meta: { resources: 'folder' }},
      { path: 'database', component: () => import('@/views/sys/database/index'), name: 'sys_database', meta: { resources: 'sys_database' }}
    ]
  },
  // redirect 404
  { path: '*', component: () => import('@/views/error/404/index'), hidden: true, meta: { resources: '404', title: '404' }}
];
