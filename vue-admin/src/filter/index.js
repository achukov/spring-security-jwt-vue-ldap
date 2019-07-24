import Vue from 'vue'
// Time formatting
import { formatDate } from '@/utils/index'

// Timestamp-processed filter
Vue.filter('formatDate', function(time) {
  // Return the processed value
  var date = new Date(time)
  return formatDate(date, 'dd-MM-yyyy')
})

// Timestamp-processed filter
Vue.filter('formatTime', function(time) {
  // Return the processed value
  var date = new Date(time)
  return formatDate(date, 'dd-MM-yyyy hh:mm:ss')
})

// Status display filter
Vue.filter('showState', function(state) {
  // Determine what type of state is
  let result = ''
  if (state === 0) {
    result = 'Deleted'
  } else if (state === 1) {
    result = 'Normal'
  } else {
    result = 'Hidden'
  }
  return result
})

Vue.filter('showBuild', function(buildingaccess) {
  // Determine what type of state is
  let result = ''
  if (buildingaccess === '0') {
    result = 'Нет'
  } else if (buildingaccess === '1') {
    result = 'Да'
  } else {
    result = 'Неизвестно'
  }
  return result
})

Vue.filter('showInherit', function(inherit) {
  let result = ''
  if (inherit === 0) {
    result = 'Not inherit'
  } else if (inherit === 1) {
    result = 'inherit'
  } else {
    result = 'Not inherit'
  }
  return result
})

// Status display filter
Vue.filter('showGender', function(gender) {
  // Determine what type of state is
  let result = ''
  if (gender === 0) {
    result = 'Female'
  } else if (gender === 1) {
    result = 'Male'
  } else {
    result = 'Unknown'
  }
  return result
})

Vue.filter('uppercase', function(value) {
  if (!value) {
    return ''
  }

  value = value.toString()
  return value.toUpperCase()
})

Vue.filter('formatText', function(text) {
  try {
    var array = text.split(';')
    var str = array.join('\n')
    return str
  } catch (e) {
    return null
  }
})
