import request from '@/utils/request';

export function getUserPage(params) {
  return request({ url: '/user/page/info', method: 'get', data: params });
}

export function getUserAll() {
  return request({ url: '/user/all', method: 'get' });
}

export function getUserById(params) {
  return request({ url: '/user/info/' + params, method: 'get' });
}

export function saveUser(params) {
  return request({ url: '/user/', method: 'post', data: params });
}

export function updateUser(params) {
  return request({ url: '/user/', method: 'put', data: params });
}

export function removeUserById(params) {
  return request({ url: '/user/' + params, method: 'delete' });
}

export function updateUserRoles(params) {
  return request({ url: '/role/update/user', method: 'post', data: params });
}

