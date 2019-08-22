
export function parseTime(time, cFormat) {
  if (arguments.length === 0) {
    return null;
  }
  if (!time) {
    return null;
  }
  const format = cFormat || '{d}-{m}-{y} {h}:{i}:{s}';
  let date;
  if (typeof time === 'object') {
    date = time;
  } else {
    if (('' + time).length === 10) time = parseInt(time) * 1000;
    date = new Date(time);
  }
  const formatObj = {
    d: date.getDate(),
    m: date.getMonth() + 1,
    y: date.getFullYear(),
    h: date.getHours(),
    i: date.getMinutes(),
    s: date.getSeconds(),
    a: date.getDay()
  };
  const time_str = format.replace(/{(d|m|y|h|i|s|a)+}/g, (result, key) => {
    let value = formatObj[key];
    // Note: getDay() returns 0 on Sunday
    if (key === 'a') {
      return ['day', 'One', 'Two', 'Three', 'Four', 'Five', 'Six'][value];
    }
    if (result.length > 0 && value < 10) {
      value = '0' + value;
    }
    return value || 0;
  });
  return time_str;
}

export function getLastMonthDate(time) {
  time.setMonth(time.getMonth() - 1);
  var y = time.getFullYear();
  var m = time.getMonth() + 1;
  var d = time.getDate();
  return y + '-' + m + '-' + d;
}

export function formatTime(time, option) {
  time = +time * 1000;
  const d = new Date(time);
  const now = Date.now();

  const diff = (now - d) / 1000;

  if (diff < 30) {
    return 'just';
  } else if (diff < 3600) {
    // less 1 hour
    return Math.ceil(diff / 60) + 'minutes ago';
  } else if (diff < 3600 * 24) {
    return Math.ceil(diff / 3600) + 'an hour ago';
  } else if (diff < 3600 * 24 * 2) {
    return '1 day ago';
  }
  if (option) {
    return parseTime(time, option);
  } else {
    return (
      d.getMonth() +
      1 +
      'month' +
      d.getDate() +
      'day' +
      d.getHours() +
      'Hour' +
      d.getMinutes() +
      'Minute'
    );
  }
}

export function transToMap(data, k, v) {
  var ret = {};
  for (var i = 0; i < data.length; i++) {
    ret[data[i][k]] = data[i][v];
  }
  return ret;
}

export function mapToArry(map) {
  var list = [];
  for (var key in map) {
    list.push([key, map[key]]);
  }
  return list;
}
export function getObjectURL(file) {
  var url = null;
  if (window.createObjectURL !== undefined) {
    // basic
    url = window.createObjectURL(file);
  } else if (window.URL !== undefined) {
    if (file.raw !== undefined) {
      url = URL.createObjectURL(file.raw);
    } else {
      // mozilla(firefox)
      url = window.URL.createObjectURL(file);
    }
  } else if (window.webkitURL !== undefined) {
    // webkit or chrome
    url = window.webkitURL.createObjectURL(file);
  }
  return url;
}

export function uuid() {
  var s = [];
  var hexDigits = '0123456789abcdef';
  for (var i = 0; i < 36; i++) {
    s[i] = hexDigits.substr(Math.floor(Math.random() * 0x10), 1);
  }
  s[14] = '4'; // bits 12-15 of the time_hi_and_version field to 0010
  s[19] = hexDigits.substr((s[19] & 0x3) | 0x8, 1); // bits 6-7 of the clock_seq_hi_and_reserved to 01
  s[8] = s[13] = s[18] = s[23] = '';

  var uuid = s.join('');
  return uuid;
}

export function isExternal(path) {
  return /^(https?:|mailto:|tel:)/.test(path);
}

export function formatDate(date, fmt) {
  if (/(y+)/.test(fmt)) {
    fmt = fmt.replace(RegExp.$1, (date.getFullYear() + '').substr(4 - RegExp.$1.length));
  }
  const o = {
    'M+': date.getMonth() + 1,
    'd+': date.getDate(),
    'h+': date.getHours(),
    'm+': date.getMinutes(),
    's+': date.getSeconds()
  };
  for (const k in o) {
    if (new RegExp(`(${k})`).test(fmt)) {
      const str = o[k] + '';
      fmt = fmt.replace(RegExp.$1, (RegExp.$1.length === 1) ? str : padLeftZero(str));
    }
  }
  return fmt;
}

function padLeftZero(str) {
  return ('00' + str).substr(str.length);
}

export function formatText(text) {
  const str = text.split('_').map((word) => {
    return word[0].toUpperCase().concat(word.slice(1, word.length));
  });
  return str.join(' ');
}

export function splitParagraphs(text) {
  return text.split(/\n/);
}

export function compareDate(date) {
  // console.log(date);
  var result;
  var timestamp = Date.parse(new Date());
  timestamp = timestamp / 1000;
  // console.log(timestamp);
  var timestamp2 = Date.parse(new Date(date));
  timestamp2 = timestamp2 / 1000;
  if (timestamp > timestamp2) {
    result = true;
  } else {
    result = false;
  }
  // console.log(stringTime + "的时间戳为：" + timestamp2)
  return result;
}

/**
 * @description  on(element, event, handler)
 */
export const on = (function() {
  if (document.addEventListener) {
    return function(element, event, handler) {
      if (element && event && handler) {
        element.addEventListener(event, handler, false);
      }
    };
  } else {
    return function(element, event, handler) {
      if (element && event && handler) {
        element.attachEvent('on' + event, handler);
      }
    };
  }
})();

/**
 * @description  off(element, event, handler)
 */
export const off = (function() {
  if (document.removeEventListener) {
    return function(element, event, handler) {
      if (element && event) {
        element.removeEventListener(event, handler, false);
      }
    };
  } else {
    return function(element, event, handler) {
      if (element && event) {
        element.detachEvent('on' + event, handler);
      }
    };
  }
})();

export function getCurrentMonthFirst(time) {
  var date = time;
  date.setDate(1);
  var month = parseInt(date.getMonth() + 1);
  var day = date.getDate();
  if (month < 10) {
    month = '0' + month;
  }
  if (day < 10) {
    day = '0' + day;
  }
  return date.getFullYear() + '-' + month + '-' + day;
}

export function getCurrentMonthLast(time) {
  var date = time;
  var currentMonth = date.getMonth();
  var nextMonth = ++currentMonth;
  var nextMonthFirstDay = new Date(date.getFullYear(), nextMonth, 1);
  var oneDay = 1000 * 60 * 60 * 24;
  var lastTime = new Date(nextMonthFirstDay - oneDay);
  var month = parseInt(lastTime.getMonth() + 1);
  var day = lastTime.getDate();
  if (month < 10) {
    month = '0' + month;
  }
  if (day < 10) {
    day = '0' + day;
  }
  return new Date(date.getFullYear() + '-' + month + '-' + day);
}
