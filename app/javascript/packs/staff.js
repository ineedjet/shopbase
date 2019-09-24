import Vue from 'vue'
import App from '../components/staff'
import Api from '../api/axios';
Vue.prototype.$eventBus = new Vue();
Vue.prototype.$api = Api;

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)
})
