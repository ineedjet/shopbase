import Vue from 'vue'
import VueRouter from 'vue-router'

import Clients from '../components/staff/dashboard/clients'
import Organizations from '../components/staff/dashboard/organizations'

Vue.use(VueRouter)
export default new VueRouter( options: {
  mode: 'history',
  hashbang: false,
  routes: [
    { path: '/clients', component: Clients, name: 'Clients' }
    { path: '/organizations', component: Organizations, name: 'Organizations' }
  ],
})
