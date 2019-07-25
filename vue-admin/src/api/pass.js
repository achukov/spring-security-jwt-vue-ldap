import request from '@/utils/request';

export function getPassPage(params) {
  return request({ url: '/pass/list', method: 'get', data: params });
}
export function getMyPassPage(params) {
  return request({ url: '/pass/my', method: 'get', data: params });
}
export function getPassAll() {
  return request({ url: '/pass/all', method: 'get' });
}

export function getPassById(params) {
  return request({ url: '/pass/' + params, method: 'get' });
}

export function savePass(params) {
  return request({ url: '/pass/', method: 'post', data: params });
}

export function updatePass(params) {
  return request({ url: '/pass/', method: 'put', data: params });
}

export function removePassById(params) {
  return request({ url: '/pass/' + params, method: 'delete' });
}
