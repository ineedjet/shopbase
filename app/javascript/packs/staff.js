import Vue from 'vue'
Vue.prototype.$eventBus = new Vue();

import Staff from '../components/staff'
import router from '../utils/router'
import store from '../store'

import Api from '../api/axios'
Vue.prototype.$api = Api;

import { Quasar } from 'quasar'
import quasarParams from '../utils/quasar'
Vue.use(Quasar, quasarParams);

import ActionCableVue from 'actioncable-vue';
import cableParams from '../utils/action-cable'
Vue.use(ActionCableVue, cableParams);

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(Staff, {
      props: {
        userEmail: document.body.getAttribute('data-user-email')
      },
    }),
    router,
    store,
  }).$mount()
  document.body.appendChild(app.$el)
})


