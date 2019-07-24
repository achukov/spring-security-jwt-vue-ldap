import request from '@/utils/request'

export function getFolderTree() {
  return request({ url: '/folder/tree', method: 'get' })
}

export function getFolderPage(params) {
  return request({ url: '/folder/list', method: 'get', data: params })
}
export function getFolderAll() {
  return request({ url: '/folder/all', method: 'get' })
}

export function getFolderById(params) {
  return request({ url: '/folder/' + params, method: 'get' })
}

export function saveFolder(params) {
  return request({ url: '/folder/', method: 'post', data: params })
}

export function updateFolder(params) {
  return request({ url: '/folder/', method: 'put', data: params })
}

export function removeFolderById(params) {
  return request({ url: '/folder/' + params, method: 'delete' })
}
