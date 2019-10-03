import Vue from 'vue'
import Staff from '../components/staff'
import Api from '../api/axios'
import router from '../utils/router'
Vue.prototype.$eventBus = new Vue();
Vue.prototype.$api = Api;

import { Quasar } from 'quasar'
import quasarParams from '../utils/quasar'
Vue.use(Quasar, quasarParams);

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(Staff, {
      props: {
        userEmail: document.body.getAttribute('data-user-email')
      },
    }),
    router,
  }).$mount()
  document.body.appendChild(app.$el)
})


