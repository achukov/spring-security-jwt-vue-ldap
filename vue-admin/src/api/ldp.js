import request from '@/utils/request';

export function getLdpPage(params) {
  return request({ url: '/ldp/list', method: 'get', data: params });
}
export function getMyLdpPage(params) {
  return request({ url: '/ldp/my', method: 'get', data: params });
}
export function getLdpAll() {
  return request({ url: '/ldp/all', method: 'get' });
}

export function getLdpById(params) {
  return request({ url: '/ldp/' + params, method: 'get' });
}

export function saveLdp(params) {
  return request({ url: '/ldp/', method: 'post', data: params });
}

export function updateLdp(params) {
  return request({ url: '/ldp/', method: 'put', data: params });
}

export function removeLdpById(params) {
  return request({ url: '/ldp/' + params, method: 'delete' });
}
