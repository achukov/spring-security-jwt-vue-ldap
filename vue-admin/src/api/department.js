import request from '@/utils/request'

export function getDeptTree() {
  return request({ url: '/dept/tree', method: 'get' })
}

export function getDeptPage(params) {
  return request({ url: '/dept/page', method: 'get', data: params })
}
export function getDeptAll() {
  return request({ url: '/dept/all', method: 'get' })
}

export function getDeptById(params) {
  return request({ url: '/dept/' + params, method: 'get' })
}

export function saveDept(params) {
  return request({ url: '/dept/', method: 'post', data: params })
}

export function updateDept(params) {
  return request({ url: '/dept/', method: 'put', data: params })
}

export function removeDeptById(params) {
  return request({ url: '/dept/' + params, method: 'delete' })
}
