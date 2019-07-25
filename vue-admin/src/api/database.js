import request from '@/utils/request';

export function getDatabasePage(params) {
  return request({ url: '/database/list', method: 'get', data: params });
}
export function getDatabaseAll() {
  return request({ url: '/database/all', method: 'get' });
}

export function getDatabaseById(params) {
  return request({ url: '/database/' + params, method: 'get' });
}

export function saveDatabase(params) {
  return request({ url: '/database/', method: 'post', data: params });
}

export function updateDatabase(params) {
  return request({ url: '/database/', method: 'put', data: params });
}

export function removeDatabaseById(params) {
  return request({ url: '/database/' + params, method: 'delete' });
}
