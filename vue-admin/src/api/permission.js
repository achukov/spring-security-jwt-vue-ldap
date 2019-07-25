import request from '@/utils/request';

export function getPermissionTree(params) {
  return request({ url: '/permission/tree', method: 'get', data: params });
}

export function getPermissionPage(params) {
  return request({ url: '/permission/page', method: 'get', data: params });
}

export function getPermissionAll() {
  return request({ url: '/permission/all', method: 'get' });
}

export function getPermissionById(params) {
  return request({ url: '/permission/info/' + params, method: 'get' });
}

export function savePermission(params) {
  return request({ url: '/permission/', method: 'post', data: params });
}

export function updatePermission(params) {
  return request({ url: '/permission/', method: 'put', data: params });
}

export function removePermissionById(params) {
  return request({ url: '/permission/' + params, method: 'delete' });
}

