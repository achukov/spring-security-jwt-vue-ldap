import request from '@/utils/request'

export function getRolePage(params) {
  return request({ url: '/role/page', method: 'get', data: params })
}

export function getRoleAll() {
  return request({ url: '/role/all', method: 'get' })
}

export function getRoleById(params) {
  return request({ url: '/role/info/' + params, method: 'get' })
}

export function saveRole(params) {
  return request({ url: '/role/', method: 'post', data: params })
}

export function updateRole(params) {
  return request({ url: '/role/', method: 'put', data: params })
}

export function removeRoleById(params) {
  return request({ url: '/role/' + params, method: 'delete' })
}

export function updateRolePermission(params) {
  return request({ url: '/role/update/permission', method: 'post', data: params })
}

