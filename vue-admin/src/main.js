import 'babel-polyfill';
import Vue from 'vue';
import 'normalize.css/normalize.css'; // A modern alternative to CSS resets
import ElementUI from 'element-ui';
import 'element-ui/lib/theme-chalk/index.css';
import locale from 'element-ui/lib/locale/lang/en';
import '@/styles/index.scss'; // global css
import App from '@/App';
import router from '@/router';
import '@/directive/index';
import '@/filter/index';
import store from '@/store';
import '@/icons'; // icon
import '@/permission'; // permission control

Vue.use(ElementUI, { locale });

Vue.config.productionTip = false;

new Vue({
  el: '#app',
  router: router,
  store: store,
  render: h => h(App)
});
