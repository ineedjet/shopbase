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

// QUASAR

import iconSet from 'quasar/icon-set/fontawesome-v5.js'
import '@quasar/extras/fontawesome-v5/fontawesome-v5.css'

import '../assets/styles/quasar.styl'
import 'quasar/dist/quasar.ie.polyfills'

import {
   Quasar,
   QLayout,
   QHeader,
   QDrawer,
   QPageContainer,
   QPage,
   QSpinner,
   QTable
 } from 'quasar'
 
 Vue.use(Quasar, {
   config: {},
   components: {
     QLayout,
     QHeader,
     QDrawer,
     QPageContainer,
     QPage,
     QSpinner,
     QTable
   },
   directives: {
   },
   iconSet: iconSet,
   plugins: {
   }
 })
