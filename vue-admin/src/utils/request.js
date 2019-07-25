import axios from 'axios';
import { Message, MessageBox } from 'element-ui';
import store from '@/store';
import Qs from 'qs';
import { getToken } from '@/utils/auth';

// Create an axios instance
const service = axios.create({
  // baseURL: '/api', // Development environment using proxy
  baseURL: process.env.BASE_API, // Production environment uses this, no proxy required
  timeout: 50000, // Request timeout
  responseType: 'json',
  withCredentials: false, // Whether to allow cookies with these
  headers: {
    'Content-Type': 'application/json; charset=UTF-8'
  }
});

// Request interceptor
service.interceptors.request.use(
  config => {
    if (getToken() !== '') {
      config.headers['Authorization'] = 'Bearer ' + getToken(); // Let each request carry a custom token, please modify it according to the actual situation.
    }
    const method = config.method.toLocaleLowerCase();
    if (method === 'get') {
      // GET request to serialize parameters
      config.url += ('?' + Qs.stringify(config.data));
    }
    return config;
  },
  error => {
    // Do something with request error
    console.log(error); // for debug
    Promise.reject(error);
  }
);

// Response Interceptor
service.interceptors.response.use(
  response => {
    const res = response.data;
    if (res.status !== 200) {
      // 400: illegal token; 401: insufficient authority; 403: Token expired;
      if (res.status === 400 || res.status === 401 || res.status === 403) {
        MessageBox.confirm('You have been logged out, you can cancel to stay on this page, or log in again', 'Confirm logout',
          { confirmButtonText: 'Re-register',
            cancelButtonText: 'Cancel',
            type: 'warning'
          }
        ).then(() => {
          store.dispatch('FedLogOut').then(() => {
            location.reload(); // In order to re-instantiate the vue-router object to avoid bugs
          });
        });
      } else {
        Message({
          message: res.message,
          type: 'error',
          duration: 5 * 1000
        });
      }
      return Promise.reject('error');
    } else {
      return res;
    }
  },
  error => {
    const errorData = error.response.data;
    console.log('request error :', error);
    // 400: illegal token; 401: insufficient authority; 403: Token expired;
    if (errorData.status === 400 || errorData.status === 401 || errorData.status === 403) {
      MessageBox.confirm('You have been logged out, you can cancel to stay on this page, or log in again', 'Confirm logout',
        { confirmButtonText: 'Re-register',
          cancelButtonText: 'Cancel',
          type: 'warning'
        }
      ).then(() => {
        store.dispatch('FedLogOut').then(() => {
          location.reload(); // In order to re-instantiate the vue-router object to avoid bugs
        });
      });
    } else {
      Message({
        message: errorData.message,
        type: 'error',
        duration: 5 * 1000
      });
    }
    return Promise.reject(errorData);
  }
);

export default service;
