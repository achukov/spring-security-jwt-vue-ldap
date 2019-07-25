import Vue from 'vue';
import store from '@/store';
import Inputmask from 'inputmask';

/** Register global directive**/

/**
 * Instruction for determining authority
 * usage: <el-button v-has="'perm:new'" class="btns">Add to</el-button>
 */
Vue.directive('has', {
  inserted: function(el, binding) {
    if (!Vue.prototype.$_has(binding.value)) {
      el.parentNode.removeChild(el);
    }
  }
});

// Permission check method
Vue.prototype.$_has = function(value) {
  // Get user button permissions
  let isExist = false;
  // List of all current user buttons
  const dynamicButtons = store.getters.buttons;
  if (dynamicButtons === undefined || dynamicButtons === null || dynamicButtons.length < 1) {
    return isExist;
  }
  dynamicButtons.forEach(button => {
    if (button.resources === value) {
      isExist = true;
      return isExist;
    }
  });
  return isExist;
};

/**
 * Instruction to modify the title
 * usage: <div v-title>Article management</div>
 */
Vue.directive('title', {
  inserted: function(el, binding) {
    document.title = el.innerText;
    el.remove();
  }
});

Vue.directive('mask', {
  bind: function(el, binding) {
    Inputmask(binding.value).mask(el.getElementsByTagName('INPUT')[0]);
  }
});
// // create a directive to transform the model value
// Vue.directive('uppercase', {
//   twoWay: true, // this transformation applies back to the vm
//   bind: function() {
//     this.handler = function() {
//       this.set(this.el.value.toUpperCase())
//     }.bind(this)
//     this.el.addEventListener('input', this.handler)
//   },
//   unbind: function() {
//     this.el.removeEventListener('input', this.handler)
//   }
// })
Vue.directive('uppercase',
  {
    inserted: function(el, _, vnode) {
      el.addEventListener('input', async function(e) {
        e.target.value = e.target.value.toUpperCase();
        vnode.componentInstance.$emit('input', e.target.value.toUpperCase());
      });
    }
  });
